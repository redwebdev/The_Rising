/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#include "ConversationManager.h"
#include "server/zone/managers/creature/CreatureTemplateManager.h"
#include "server/zone/objects/creature/conversation/DeliverMissionConversationObserver.h"
#include "server/zone/objects/creature/conversation/InformantMissionConversationObserver.h"
#include "server/zone/objects/creature/conversation/TrainerConversationObserver.h"
#include "server/zone/objects/creature/conversation/ConversationObserver.h"
#include "server/zone/objects/creature/conversation/LuaConversationObserver.h"
#include "server/zone/objects/creature/conversation/PetTrainingConversationObserver.h"

ConversationManager::ConversationManager()
	: Logger("ConversationManager") {
}

ConversationManager::~ConversationManager() {
	//Do nothing.
}

ConversationObserver* ConversationManager::getConversationObserver(uint32 conversationTemplateCRC) {
	if (conversationObservers.containsKey(conversationTemplateCRC)) {
		//Observer does already exist, return it.
		return conversationObservers.get(conversationTemplateCRC).get();
	} else {
		if (CreatureTemplateManager::DEBUG_MODE)
			return NULL;
		//No observer, create it.
		ManagedReference<ConversationObserver*> conversationObserver = NULL;
		ConversationTemplate* conversationTemplate = CreatureTemplateManager::instance()->getConversationTemplate(conversationTemplateCRC);
		if (conversationTemplate != NULL) {
			switch (conversationTemplate->getConversationTemplateType()) {
			case ConversationTemplate::ConversationTemplateTypeNormal:
				conversationObserver = new ConversationObserver(conversationTemplate);
				break;
			case ConversationTemplate::ConversationTemplateTypeTrainer:
				conversationObserver = new TrainerConversationObserver(conversationTemplate);
				break;
			case ConversationTemplate::ConversationTemplateTypeDeliverMission:
				conversationObserver = new DeliverMissionConversationObserver(conversationTemplate);
				break;
			case ConversationTemplate::ConversationTemplateTypeInformantMission:
				conversationObserver = new InformantMissionConversationObserver(conversationTemplate);
				break;
			case ConversationTemplate::ConversationTemplateTypeLua:
				conversationObserver = new LuaConversationObserver(conversationTemplate);
				break;
			case ConversationTemplate::ConversationTemplateTypePersonality:
				conversationObserver = new PetTrainingConversationObserver(conversationTemplate);
				break;
			default:
				conversationObserver = new ConversationObserver(conversationTemplate);
				break;
			}

			if (conversationObserver != NULL) {
				//Add it to the map.
				conversationObservers.put(conversationTemplateCRC, conversationObserver);
			}
		}
		return conversationObserver;
	}
}
