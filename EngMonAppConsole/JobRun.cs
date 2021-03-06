//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EngMonAppConsole
{
    using System;
    using System.Collections.Generic;
    
    public partial class JobRun
    {
        public JobRun()
        {
            this.JobRunDataLocations = new HashSet<JobRunDataLocation>();
        }
    
        public string JobRunID { get; set; }
        public string fk_JobID { get; set; }
        public Nullable<System.DateTime> RunStartTime { get; set; }
        public Nullable<System.DateTime> RunEndTime { get; set; }
        public Nullable<double> RunDuration { get; set; }
        public Nullable<int> fk_RunStatus { get; set; }
        public Nullable<long> RowsIn { get; set; }
        public Nullable<long> RowsOut { get; set; }
        public string ErrorMessage { get; set; }
    
        public virtual Job Job { get; set; }
        public virtual ICollection<JobRunDataLocation> JobRunDataLocations { get; set; }
    }
}
