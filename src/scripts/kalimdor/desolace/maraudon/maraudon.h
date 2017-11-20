/*
  ROCKETTE FOR NOSTALRIUS
 */

#ifndef MARAUDON_H
#define MARAUDON_H
#include "scriptPCH.h"

enum
{
    MARAUDON_MAX_ENCOUNTER = 1,

    TYPE_CELEBRAS = 1,

    NPC_CELEBRAS_REDEEMED = 13716
};

/*
class instance_maraudon : public ScriptedInstance
{
    public:
        instance_maraudon(Map* pMap);
        void OnCreatureCreate(Creature* pGo) override;
        void OnGameObjectCreate(GameObject* pGo) override;
        const ObjectGuid GetCelebrasGuid() const { return (cGuid); }
        const ObjectGuid GetPedestalGuid() const { return (pGuid); }
        const ObjectGuid GetBookGuid() const { return (bGuid); }
        const ObjectGuid GetAuraGuid() const { return (aGuid); }
 private:
    ObjectGuid cGuid;
    ObjectGuid pGuid;
    ObjectGuid bGuid;
    ObjectGuid aGuid;
};
*/

#endif
