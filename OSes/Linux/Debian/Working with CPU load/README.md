Commands to find Load

* per-CPU utilization: eg, using mpstat -P ALL 1
* per-process CPU utilization: eg, top, pidstat 1, etc.
* per-thread run queue (scheduler) latency: eg, in /proc/PID/schedstats, delaystats, perf sched
* CPU run queue latency: eg, in /proc/schedstat, perf sched, my runqlat bcc tool.
* CPU run queue length: eg, using vmstat 1 and the 'r' column, or my runqlen bcc tool.

The first two are utilization metrics, the last three are saturation metrics.