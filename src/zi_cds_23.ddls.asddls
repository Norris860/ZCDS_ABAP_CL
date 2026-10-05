@AccessControl.authorizationCheck: #NOT_REQUIRED
define hierarchy ZI_CDS_23
  as parent child hierarchy(
    source ZI_CDS_22
    child to parent association _Manager
    start where
      Manager is initial
    siblings order by
      Employee
    multiple parents allowed
    orphans ignore
    cycles breakup
    //    generate spantree

    cache on
  )
{
  key Employee,
      Manager,
      Name,
      $node.parent_id             as ParentId,
      $node.node_id               as NodeID,
      $node.hierarchy_is_cycle    as HisCycle,
      $node.hierarchy_is_orphan   as HisOrphan,
      $node.hierarchy_level       as HLevel,
      $node.hierarchy_parent_rank as HParentRank,
      $node.hierarchy_rank        as HRank,
      $node.hierarchy_tree_size   as HTreeSize
}
