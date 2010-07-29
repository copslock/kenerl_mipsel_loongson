Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jul 2010 00:51:36 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17379 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492881Ab0G2Wvb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jul 2010 00:51:31 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c52060c0000>; Thu, 29 Jul 2010 15:51:56 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 29 Jul 2010 15:51:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 29 Jul 2010 15:51:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6TMpNK0021726;
        Thu, 29 Jul 2010 15:51:23 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6TMpLx7021725;
        Thu, 29 Jul 2010 15:51:21 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     strace-devel@lists.sourceforge.net, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] Update MIPS Linux syscalls to match 2.6.35-rc6+
Date:   Thu, 29 Jul 2010 15:51:14 -0700
Message-Id: <1280443874-21690-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 29 Jul 2010 22:51:27.0803 (UTC) FILETIME=[941E08B0:01CB2F70]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

* linux/mips/syscallent.h: Add and update 405 hooks.
---
 linux/mips/syscallent.h |  650 +++++++++++++++++++++++++++++------------------
 1 files changed, 405 insertions(+), 245 deletions(-)

diff --git a/linux/mips/syscallent.h b/linux/mips/syscallent.h
index e2fe509..6551468 100644
--- a/linux/mips/syscallent.h
+++ b/linux/mips/syscallent.h
@@ -4252,7 +4252,7 @@
 	{ 4,	0,	printargs,		"lookup_dcookie"}, /* 4247 */
 	{ 1,	0,	sys_epoll_create,	"epoll_create"	}, /* 4248 */
 	{ 4,	TD,	sys_epoll_ctl,		"epoll_ctl"	}, /* 4249 */
-	{ 3,	TD,	sys_epoll_wait,		"epoll_wait"	}, /* 4250 */
+	{ 4,	TD,	sys_epoll_wait,		"epoll_wait"	}, /* 4250 */
 	{ 5,	0,	sys_remap_file_pages,	"remap_file_pages"}, /* 4251 */
 	{ 1,	0,	printargs,		"set_tid_address"}, /* 4252 */
 	{ 0,	0,	sys_restart_syscall,	"restart_syscall"}, /* 4253 */
@@ -4308,20 +4308,36 @@
 	{ 1,	TP,	sys_unshare,		"unshare"	}, /* 4303 */
 	{ 6,	TD,	printargs,		"splice"	}, /* 4304 */
 	{ 4,	TD,	printargs,		"sync_file_range" }, /* 4305 */
-	{ 0,	0,	printargs,		"SYS_4306"	}, /* 4306 */
-	{ 0,	0,	printargs,		"SYS_4307"	}, /* 4307 */
+	{ 4,	TD,	printargs,		"tee"		}, /* 4306 */
+	{ 4,	TD,	printargs,		"vmsplice"	}, /* 4307 */
 	{ 6,	0,	sys_move_pages,		"move_pages"	}, /* 4308 */
-	{ 0,	0,	printargs,		"SYS_4309"	}, /* 4309 */
-	{ 0,	0,	printargs,		"SYS_4310"	}, /* 4310 */
-	{ 0,	0,	printargs,		"SYS_4311"	}, /* 4311 */
+	{ 2,	0,	printargs,		"set_robust_list" }, /* 4309 */
+	{ 3,	0,	printargs,		"get_robust_list" }, /* 4310 */
+	{ 4,	0,	printargs,		"kexec_load"	}, /* 4311 */
 	{ 3,	0,	sys_getcpu,		"getcpu"	}, /* 4312 */
 	{ 5,	TD,	sys_epoll_pwait,	"epoll_pwait"	}, /* 4313 */
-	{ 0,	0,	printargs,		"SYS_4314"	}, /* 4314 */
-	{ 0,	0,	printargs,		"SYS_4315"	}, /* 4315 */
-	{ 0,	0,	printargs,		"SYS_4316"	}, /* 4316 */
+	{ 3,	0,	printargs,		"ioprio_set"	}, /* 4314 */
+	{ 2,	0,	printargs,		"ioprio_get"	}, /* 4315 */
+	{ 4,	0,	printargs,		"utimensat"	}, /* 4316 */
 	{ 3,	TD|TS,	sys_signalfd,		"signalfd"	}, /* 4317 */
 	{ 4,	TD,	sys_timerfd,		"timerfd"	}, /* 4318 */
 	{ 1,	TD,	sys_eventfd,		"eventfd"	}, /* 4319 */
+	{ 6,	TF,	sys_fallocate,		"fallocate"	}, /* 4320 */
+	{ 2,	TD,	sys_timerfd_create,	"timerfd_create" }, /* 4321 */
+	{ 2,	TD,	sys_timerfd_gettime,	"timerfd_gettime" }, /* 4322 */
+	{ 4,	TD,	sys_timerfd_settime,	"timerfd_settime" }, /* 4323 */
+	{ 4,	TD|TS,	sys_signalfd4,		"signalfd4"	}, /* 4324 */
+	{ 2,	TD,	sys_eventfd2,		"eventfd2"	}, /* 4325 */
+	{ 1,	0,	sys_epoll_create1,	"epoll_create1"	}, /* 4326 */
+	{ 3,	TD,	sys_dup3,		"dup3"		}, /* 4327 */
+	{ 2,	TD,	sys_pipe2,		"pipe2"		}, /* 4328 */
+	{ 1,	TD,	sys_inotify_init1,	"inotify_init1"	}, /* 4329 */
+	{ 6,	TD,	printargs,		"preadv"	}, /* 4330 */
+	{ 6,	TD,	printargs,		"pwritev"	}, /* 4331 */
+	{ 4,	TP|TS,	printargs,		"rt_tgsigqueueinfo" }, /* 4332 */
+	{ 5,	TD,	printargs,		"perf_event_open" }, /* 4333 */
+	{ 4,	TN,	sys_accept4,		"accept4"	}, /* 4334 */
+	{ 5,	TN,	sys_recvmmsg,		"recvmmsg"	}, /* 4335 */
 #else
 	{ 0,	0,	printargs,		"o32_syscall"	}, /* 4000 */
 	{ 0,	0,	printargs,		"o32_exit"		}, /* 4001 */
@@ -4573,7 +4589,7 @@
 	{ 3,	0,	printargs,		"o32_lookup_dcookie"}, /* 4247 */
 	{ 1,	0,	printargs,		"o32_epoll_create"	}, /* 4248 */
 	{ 4,	TD,	printargs,		"o32_epoll_ctl"	}, /* 4249 */
-	{ 3,	TD,	printargs,		"o32_epoll_wait"	}, /* 4250 */
+	{ 4,	TD,	printargs,		"o32_epoll_wait"	}, /* 4250 */
 	{ 5,	0,	printargs,		"o32_remap_file_pages"}, /* 4251 */
 	{ 1,	0,	printargs,		"o32_set_tid_address"}, /* 4252 */
 	{ 0,	0,	printargs,		"o32_restart_syscall"}, /* 4253 */
@@ -4629,37 +4645,37 @@
 	{ 1,	TP,	printargs,		"o32_unshare"	}, /* 4303 */
 	{ 6,	TD,	printargs,		"o32_splice"	}, /* 4304 */
 	{ 4,	TD,	printargs,		"o32_sync_file_range" }, /* 4305 */
-	{ 0,	0,	printargs,		"o32_SYS_4306"	}, /* 4306 */
-	{ 0,	0,	printargs,		"o32_SYS_4307"	}, /* 4307 */
+	{ 4,	TD,	printargs,		"o32_tee"	}, /* 4306 */
+	{ 4,	TD,	printargs,		"o32_vmsplice"	}, /* 4307 */
 	{ 6,	0,	printargs,		"o32_move_pages"	}, /* 4308 */
-	{ 0,	0,	printargs,		"o32_SYS_4309"	}, /* 4309 */
-	{ 0,	0,	printargs,		"o32_SYS_4310"	}, /* 4310 */
-	{ 0,	0,	printargs,		"o32_SYS_4311"	}, /* 4311 */
+	{ 2,	0,	printargs,		"o32_set_robust_list" }, /* 4309 */
+	{ 3,	0,	printargs,		"o32_get_robust_list" }, /* 4310 */
+	{ 4,	0,	printargs,		"o32_kexec_load" }, /* 4311 */
 	{ 3,	0,	printargs,		"o32_getcpu"	}, /* 4312 */
 	{ 5,	TD,	printargs,		"o32_epoll_pwait"	}, /* 4313 */
-	{ 0,	0,	printargs,		"o32_SYS_4314"	}, /* 4314 */
-	{ 0,	0,	printargs,		"o32_SYS_4315"	}, /* 4315 */
-	{ 0,	0,	printargs,		"o32_SYS_4316"	}, /* 4316 */
+	{ 3,	0,	printargs,		"o32_ioprio_set" }, /* 4314 */
+	{ 2,	0,	printargs,		"o32_ioprio_get" }, /* 4315 */
+	{ 4,	0,	printargs,		"o32_utimensat"	}, /* 4316 */
 	{ 3,	TD|TS,	printargs,		"o32_signalfd"	}, /* 4317 */
 	{ 4,	TD,	printargs,		"o32_timerfd"	}, /* 4318 */
 	{ 1,	TD,	printargs,		"o32_eventfd"	}, /* 4319 */
+	{ 6,	TF,	printargs,		"o32_fallocate"	}, /* 4320 */
+	{ 2,	TD,	printargs,		"o32_timerfd_create" }, /* 4321 */
+	{ 2,	TD,	printargs,		"o32_timerfd_gettime" }, /* 4322 */
+	{ 4,	TD,	printargs,		"o32_timerfd_settime" }, /* 4323 */
+	{ 4,	TD|TS,	printargs,		"o32_signalfd4"	}, /* 4324 */
+	{ 2,	TD,	printargs,		"o32_eventfd2"	}, /* 4325 */
+	{ 1,	0,	printargs,		"o32_epoll_create1" }, /* 4326 */
+	{ 3,	TD,	printargs,		"o32_dup3"	}, /* 4327 */
+	{ 2,	TD,	printargs,		"o32_pipe2"	}, /* 4328 */
+	{ 1,	TD,	printargs,		"o32_inotify_init1" }, /* 4329 */
+	{ 6,	TD,	printargs,		"o32_preadv"	}, /* 4330 */
+	{ 6,	TD,	printargs,		"o32_pwritev"	}, /* 4331 */
+	{ 4,	TP|TS,	printargs,		"o32_rt_tgsigqueueinfo" }, /* 4332 */
+	{ 5,	TD,	printargs,		"o32_perf_event_open" }, /* 4333 */
+	{ 4,	TN,	printargs,		"o32_accept4"	}, /* 4334 */
+	{ 5,	TN,	printargs,		"o32_recvmmsg"	}, /* 4335 */
 #endif
-	{ 0,	0,	printargs,		"SYS_4320"	}, /* 4320 */
-	{ 0,	0,	printargs,		"SYS_4321"	}, /* 4321 */
-	{ 0,	0,	printargs,		"SYS_4322"	}, /* 4322 */
-	{ 0,	0,	printargs,		"SYS_4323"	}, /* 4323 */
-	{ 0,	0,	printargs,		"SYS_4324"	}, /* 4324 */
-	{ 0,	0,	printargs,		"SYS_4325"	}, /* 4325 */
-	{ 0,	0,	printargs,		"SYS_4326"	}, /* 4326 */
-	{ 0,	0,	printargs,		"SYS_4327"	}, /* 4327 */
-	{ 0,	0,	printargs,		"SYS_4328"	}, /* 4328 */
-	{ 0,	0,	printargs,		"SYS_4329"	}, /* 4329 */
-	{ 0,	0,	printargs,		"SYS_4330"	}, /* 4330 */
-	{ 0,	0,	printargs,		"SYS_4331"	}, /* 4331 */
-	{ 0,	0,	printargs,		"SYS_4332"	}, /* 4332 */
-	{ 0,	0,	printargs,		"SYS_4333"	}, /* 4333 */
-	{ 0,	0,	printargs,		"SYS_4334"	}, /* 4334 */
-	{ 0,	0,	printargs,		"SYS_4335"	}, /* 4335 */
 	{ 0,	0,	printargs,		"SYS_4336"	}, /* 4336 */
 	{ 0,	0,	printargs,		"SYS_4337"	}, /* 4337 */
 	{ 0,	0,	printargs,		"SYS_4338"	}, /* 4338 */
@@ -5520,33 +5536,107 @@
 	{ 2,	0,	sys_fremovexattr,	"fremovexattr"	}, /* 5191 */
 	{ 2,	0,	sys_kill,		"tkill"		}, /* 5192 */
 	{ 1,	0,	sys_time,		"time"		}, /* 5193 */
-	{ 5,	0,	printargs,		"futex"		}, /* 5194 */
-	{ 3,	0,	printargs,		"sched_setaffinity"}, /* 5195 */
-	{ 3,	0,	printargs,		"sched_getaffinity"}, /* 5196 */
+	{ 6,	0,	sys_futex,		"futex"		}, /* 5194 */
+	{ 3,	0,	sys_sched_setaffinity,	"sched_setaffinity"}, /* 5195 */
+	{ 3,	0,	sys_sched_getaffinity,	"sched_getaffinity"}, /* 5196 */
 	{ 3,	0,	printargs,		"cacheflush"	}, /* 5197 */
 	{ 3,	0,	printargs,		"cachectl"	}, /* 5198 */
 	{ 4,	0,	sys_sysmips,		"sysmips"	}, /* 5199 */
-	{ 0,	0,	printargs,		"SYS_5200"	}, /* 5200 */
-	{ 0,	0,	printargs,		"SYS_5201"	}, /* 5201 */
-	{ 0,	0,	printargs,		"SYS_5202"	}, /* 5202 */
-	{ 0,	0,	printargs,		"SYS_5203"	}, /* 5203 */
-	{ 0,	0,	printargs,		"SYS_5204"	}, /* 5204 */
+	{ 2,	0,	sys_io_setup,		"io_setup"	}, /* 5200 */
+	{ 1,	0,	sys_io_destroy,		"io_destroy"	}, /* 5201 */
+	{ 5,	0,	sys_io_getevents,	"io_getevents"	}, /* 5202 */
+	{ 3,	0,	sys_io_submit,		"io_submit"	}, /* 5203 */
+	{ 3,	0,	sys_io_cancel,		"io_cancel"	}, /* 5204 */
 	{ 1,	TP,	sys_exit,		"exit_group"	}, /* 5205 */
-	{ 0,	0,	printargs,		"SYS_5206"	}, /* 5206 */
-	{ 0,	0,	printargs,		"SYS_5207"	}, /* 5207 */
-	{ 0,	0,	printargs,		"SYS_5208"	}, /* 5208 */
-	{ 0,	0,	printargs,		"SYS_5209"	}, /* 5209 */
-	{ 0,	0,	printargs,		"SYS_5210"	}, /* 5210 */
+	{ 3,	0,	printargs,		"lookup_dcookie" }, /* 5206 */
+	{ 1,	0,	sys_epoll_create,	"epoll_create"	}, /* 5207 */
+	{ 4,	TD,	sys_epoll_ctl,		"epoll_ctl"	}, /* 5208 */
+	{ 4,	TD,	sys_epoll_wait,		"epoll_wait"	}, /* 5209 */
+	{ 5,	0,	sys_remap_file_pages,	"remap_file_pages" }, /* 5210 */
 	{ 1,	TS,	printargs,		"rt_sigreturn"	}, /* 5211 */
-	{ 5,	0,	printargs,		"timer_create"	}, /* 5212 */
-	{ 5,	0,	printargs,		"timer_settime"	}, /* 5213 */
-	{ 5,	0,	printargs,		"timer_gettime"	}, /* 5214 */
-	{ 5,	0,	printargs,		"timer_getoverrun"}, /* 5215 */
-	{ 5,	0,	printargs,		"timer_delete"	}, /* 5216 */
-	{ 5,	0,	printargs,		"clock_settime"	}, /* 5217 */
-	{ 5,	0,	printargs,		"clock_gettime"	}, /* 5218 */
-	{ 5,	0,	printargs,		"clock_getres"	}, /* 5219 */
-	{ 5,	0,	printargs,		"clock_nanosleep"}, /* 5220 */
+	{ 1,	0,	printargs,		"set_tid_address" }, /* 5212 */
+	{ 0,	0,	sys_restart_syscall,	"restart_syscall" }, /* 5213 */
+	{ 5,	TI,	sys_semtimedop,		"semtimedop"	}, /* 5214 */
+	{ 4,	0,	sys_fadvise64_64,	"fadvise64_64"	}, /* 5215 */
+	{ 3,	0,	sys_timer_create,	"timer_create"	}, /* 5216 */
+	{ 4,	0,	sys_timer_settime,	"timer_settime"	}, /* 5217 */
+	{ 2,	0,	sys_timer_gettime,	"timer_gettime"	}, /* 5218 */
+	{ 1,	0,	sys_timer_getoverrun,	"timer_getoverrun"}, /* 5219 */
+	{ 1,	0,	sys_timer_delete,	"timer_delete"	}, /* 5220 */
+	{ 2,	0,	sys_clock_settime,	"clock_settime"	}, /* 5221 */
+	{ 2,	0,	sys_clock_gettime,	"clock_gettime"	}, /* 5222 */
+	{ 2,	0,	sys_clock_getres,	"clock_getres"	}, /* 5223 */
+	{ 4,	0,	sys_clock_nanosleep,	"clock_nanosleep"}, /* 5224 */
+	{ 3,	TS,	sys_tgkill,		"tgkill"	}, /* 5225 */
+	{ 2,	TF,	sys_utimes,		"utimes"	}, /* 5226 */
+	{ 6,	0,	sys_mbind,		"mbind"		}, /* 5227 */
+	{ 0,	0,	printargs,		"SYS_5228"	}, /* 5228 */
+	{ 0,	0,	printargs,		"SYS_5228"	}, /* 5229 */
+	{ 4,	0,	sys_mq_open,		"mq_open"	}, /* 5230 */
+	{ 1,	0,	sys_mq_unlink,		"mq_unlink"	}, /* 5231 */
+	{ 5,	0,	sys_mq_timedsend,	"mq_timedsend"	}, /* 5232 */
+	{ 5,	0,	sys_mq_timedreceive,	"mq_timedreceive" }, /* 5233 */
+	{ 2,	0,	sys_mq_notify,		"mq_notify"	}, /* 5234 */
+	{ 3,	0,	sys_mq_getsetattr,	"mq_getsetattr"	}, /* 5235 */
+	{ 0,	0,	printargs,		"SYS_5236"	}, /* 5236 */
+	{ 5,	TP,	sys_waitid,		"waitid"	}, /* 5237 */
+	{ 0,	0,	printargs,		"SYS_5238"	}, /* 5238 */
+	{ 5,	0,	printargs,		"add_key"	}, /* 5239 */
+	{ 4,	0,	printargs,		"request_key"	}, /* 5230 */
+	{ 5,	0,	printargs,		"keyctl"	}, /* 5241 */
+	{ 1,	0,	sys_set_thread_area,	"set_thread_area" }, /* 5242 */
+	{ 0,	TD,	printargs,		"inotify_init"	}, /* 5243 */
+	{ 3,	TD,	sys_inotify_add_watch,	"inotify_add_watch" }, /* 5244 */
+	{ 2,	TD,	sys_inotify_rm_watch,	"inotify_rm_watch" }, /* 5245 */
+	{ 4,	0,	printargs,		"migrate_pages"	}, /* 5246 */
+	{ 4,	TD|TF,	sys_openat,		"openat"	}, /* 5247 */
+	{ 3,	TD|TF,	sys_mkdirat,		"mkdirat"	}, /* 5248 */
+	{ 4,	TD|TF,	sys_mknodat,		"mknodat"	}, /* 5249 */
+	{ 5,	TD|TF,	sys_fchownat,		"fchownat"	}, /* 5250 */
+	{ 3,	TD|TF,	sys_futimesat,		"futimesat"	}, /* 5251 */
+	{ 4,	TD|TF,	sys_newfstatat,		"newfstatat"	}, /* 5252 */
+	{ 3,	TD|TF,	sys_unlinkat,		"unlinkat"	}, /* 5253 */
+	{ 4,	TD|TF,	sys_renameat,		"renameat"	}, /* 5254 */
+	{ 5,	TD|TF,	sys_linkat,		"linkat"	}, /* 5255 */
+	{ 3,	TD|TF,	sys_symlinkat,		"symlinkat"	}, /* 5256 */
+	{ 4,	TD|TF,	sys_readlinkat,		"readlinkat"	}, /* 5257 */
+	{ 3,	TD|TF,	sys_fchmodat,		"fchmodat"	}, /* 5258 */
+	{ 3,	TD|TF,	sys_faccessat,		"faccessat"	}, /* 5259 */
+	{ 6,	TD,	sys_pselect6,		"pselect6"	}, /* 5260 */
+	{ 5,	TD,	sys_ppoll,		"ppoll"		}, /* 5261 */
+	{ 1,	TP,	sys_unshare,		"unshare"	}, /* 5262 */
+	{ 6,	TD,	printargs,		"splice"	}, /* 5263 */
+	{ 4,	TD,	printargs,		"sync_file_range" }, /* 5264 */
+	{ 4,	TD,	printargs,		"tee"		}, /* 5265 */
+	{ 4,	TD,	printargs,		"vmsplice"	}, /* 5266 */
+	{ 6,	0,	printargs,		"move_pages"	}, /* 5267 */
+	{ 2,	0,	printargs,		"set_robust_list" }, /* 5268 */
+	{ 3,	0,	printargs,		"get_robust_list" }, /* 5269 */
+	{ 5,	0,	printargs,		"kexec_load"	}, /* 5270 */
+	{ 3,	0,	sys_getcpu,		"getcpu"	}, /* 5271 */
+	{ 5,	TD,	sys_epoll_pwait,	"epoll_pwait"	}, /* 5272 */
+	{ 3,	0,	printargs,		"ioprio_set"	}, /* 5273 */
+	{ 2,	0,	printargs,		"ioprio_get"	}, /* 5274 */
+	{ 4,	TD|TF,	sys_utimensat,		"utimensat"	}, /* 5275 */
+	{ 3,	TD|TS,	sys_signalfd,		"signalfd"	}, /* 5276 */
+	{ 0,	0,	printargs,		"SYS_5277"	}, /* 5277 */
+	{ 1,	TD,	sys_eventfd,		"eventfd"	}, /* 5278 */
+	{ 6,	TF,	sys_fallocate,		"fallocate"	}, /* 5279 */
+	{ 2,	TD,	sys_timerfd_create,	"timerfd_create" }, /* 5280 */
+	{ 2,	TD,	sys_timerfd_gettime,	"timerfd_gettime" }, /* 5281 */
+	{ 4,	TD,	sys_timerfd_settime,	"timerfd_settime" }, /* 5282 */
+	{ 4,	TD|TS,	sys_signalfd4,		"signalfd4"	}, /* 5283 */
+	{ 2,	TD,	sys_eventfd2,		"eventfd2"	}, /* 5284 */
+	{ 1,	0,	sys_epoll_create1,	"epoll_create1"	}, /* 5285 */
+	{ 3,	TD,	sys_dup3,		"dup3"		}, /* 5286 */
+	{ 2,	TD,	sys_pipe2,		"pipe2"		}, /* 5287 */
+	{ 1,	TD,	sys_inotify_init1,	"inotify_init1"	}, /* 5288 */
+	{ 5,	TD,	printargs,		"preadv"	}, /* 5289 */
+	{ 5,	TD,	printargs,		"pwritev"	}, /* 5290 */
+	{ 4,	TP|TS,	printargs,		"rt_tgsigqueueinfo" }, /* 5291 */
+	{ 5,	TD,	printargs,		"perf_event_open" }, /* 5292 */
+	{ 4,	TN,	sys_accept4,		"accept4"	}, /* 5293 */
+	{ 5,	TN,	sys_recvmmsg,		"recvmmsg"	}, /* 5294 */
 #else
 	{ 0,	0,	printargs,		"n64_read"		}, /* 5000 */
 	{ 0,	0,	printargs,		"n64_write"		}, /* 5001 */
@@ -5748,102 +5838,102 @@
 	{ 0,	0,	printargs,		"n64_cacheflush"	}, /* 5197 */
 	{ 0,	0,	printargs,		"n64_cachectl"		}, /* 5198 */
 	{ 0,	0,	printargs,		"n64_sysmips"		}, /* 5199 */
-	{ 0,	0,	printargs,		"SYS_5200"		}, /* 5200 */
-	{ 0,	0,	printargs,		"SYS_5201"		}, /* 5201 */
-	{ 0,	0,	printargs,		"SYS_5202"		}, /* 5202 */
-	{ 0,	0,	printargs,		"SYS_5203"		}, /* 5203 */
-	{ 0,	0,	printargs,		"SYS_5204"		}, /* 5204 */
+	{ 0,	0,	printargs,		"n64_io_setup"		}, /* 5200 */
+	{ 0,	0,	printargs,		"n64_io_destroy"	}, /* 5201 */
+	{ 0,	0,	printargs,		"n64_io_getevents"	}, /* 5202 */
+	{ 0,	0,	printargs,		"n64_io_submit"		}, /* 5203 */
+	{ 0,	0,	printargs,		"n64_io_cancel"		}, /* 5204 */
 	{ 1,	TP,	printargs,		"n64_exit_group"	}, /* 5205 */
-	{ 0,	0,	printargs,		"SYS_5206"		}, /* 5206 */
-	{ 0,	0,	printargs,		"SYS_5207"		}, /* 5207 */
-	{ 0,	0,	printargs,		"SYS_5208"		}, /* 5208 */
-	{ 0,	0,	printargs,		"SYS_5209"		}, /* 5209 */
-	{ 0,	0,	printargs,		"SYS_5210"		}, /* 5210 */
+	{ 0,	0,	printargs,		"n64_lookup_dcookie"	}, /* 5206 */
+	{ 0,	0,	printargs,		"n64_epoll_create"	}, /* 5207 */
+	{ 0,	0,	printargs,		"n64_epoll_ctl"		}, /* 5208 */
+	{ 0,	0,	printargs,		"n64_epoll_wait"	}, /* 5209 */
+	{ 0,	0,	printargs,		"n64_remap_file_pages"	}, /* 5210 */
 	{ 0,	0,	printargs,		"n64_rt_sigreturn"	}, /* 5211 */
-	{ 5,	0,	printargs,		"n64_timer_create"	}, /* 5212 */
-	{ 5,	0,	printargs,		"n64_timer_settime"	}, /* 5213 */
-	{ 5,	0,	printargs,		"n64_timer_gettime"	}, /* 5214 */
-	{ 5,	0,	printargs,		"n64_timer_getoverrun"}, /* 5215 */
-	{ 5,	0,	printargs,		"n64_timer_delete"	}, /* 5216 */
-	{ 5,	0,	printargs,		"n64_clock_settime"	}, /* 5217 */
-	{ 5,	0,	printargs,		"n64_clock_gettime"	}, /* 5218 */
-	{ 5,	0,	printargs,		"n64_clock_getres"	}, /* 5219 */
-	{ 5,	0,	printargs,		"n64_clock_nanosleep"}, /* 5220 */
+	{ 1,	0,	printargs,		"n64_set_tid_address"	}, /* 5212 */
+	{ 0,	0,	printargs,		"n64_restart_syscall"	}, /* 5213 */
+	{ 5,	TI,	printargs,		"n64_semtimedop"	}, /* 5214 */
+	{ 0,	0,	printargs,		"n64_fadvise64_64"	}, /* 5215 */
+	{ 0,	0,	printargs,		"n64_timer_create"	}, /* 5216 */
+	{ 0,	0,	printargs,		"n64_timer_settime"	}, /* 5217 */
+	{ 0,	0,	printargs,		"n64_timer_gettime"	}, /* 5218 */
+	{ 0,	0,	printargs,		"n64_timer_getoverrun"	}, /* 5219 */
+	{ 0,	0,	printargs,		"n64_timer_delete"	}, /* 5220 */
+	{ 0,	0,	printargs,		"n64_clock_settime"	}, /* 5221 */
+	{ 0,	0,	printargs,		"n64_clock_gettime"	}, /* 5222 */
+	{ 0,	0,	printargs,		"n64_clock_getres"	}, /* 5223 */
+	{ 0,	0,	printargs,		"n64_clock_nanosleep"	}, /* 5224 */
+	{ 0,	0,	printargs,		"n64_tgkill"		}, /* 5225 */
+	{ 0,	0,	printargs,		"n64_utimes"		}, /* 5226 */
+	{ 0,	0,	printargs,		"n64_mbind"		}, /* 5227 */
+	{ 0,	0,	printargs,		"n64_SYS_5228"		}, /* 5228 */
+	{ 0,	0,	printargs,		"n64_SYS_5228"		}, /* 5229 */
+	{ 0,	0,	printargs,		"n64_mq_open"		}, /* 5230 */
+	{ 0,	0,	printargs,		"n64_mq_unlink"		}, /* 5231 */
+	{ 0,	0,	printargs,		"n64_mq_timedsend"	}, /* 5232 */
+	{ 0,	0,	printargs,		"n64_mq_timedreceive"	}, /* 5233 */
+	{ 0,	0,	printargs,		"n64_mq_notify"		}, /* 5234 */
+	{ 0,	0,	printargs,		"n64_mq_getsetattr"	}, /* 5235 */
+	{ 0,	0,	printargs,		"n64_SYS_5236"		}, /* 5236 */
+	{ 0,	0,	printargs,		"n64_waitid"		}, /* 5237 */
+	{ 0,	0,	printargs,		"n64_SYS_5238"		}, /* 5238 */
+	{ 0,	0,	printargs,		"n64_add_key"		}, /* 5239 */
+	{ 0,	0,	printargs,		"n64_request_key"	}, /* 5230 */
+	{ 0,	0,	printargs,		"n64_keyctl"		}, /* 5241 */
+	{ 0,	0,	printargs,		"n64_set_thread_area"	}, /* 5242 */
+	{ 0,	0,	printargs,		"n64_inotify_init"	}, /* 5243 */
+	{ 0,	0,	printargs,		"n64_inotify_add_watch" }, /* 5244 */
+	{ 0,	0,	printargs,		"n64_inotify_rm_watch"	}, /* 5245 */
+	{ 0,	0,	printargs,		"n64_migrate_pages"	}, /* 5246 */
+	{ 0,	0,	printargs,		"n64_openat"		}, /* 5247 */
+	{ 0,	0,	printargs,		"n64_mkdirat"		}, /* 5248 */
+	{ 0,	0,	printargs,		"n64_mknodat"		}, /* 5249 */
+	{ 0,	0,	printargs,		"n64_fchownat"		}, /* 5250 */
+	{ 0,	0,	printargs,		"n64_futimesat"		}, /* 5251 */
+	{ 0,	0,	printargs,		"n64_newfstatat"	}, /* 5252 */
+	{ 0,	0,	printargs,		"n64_unlinkat"		}, /* 5253 */
+	{ 0,	0,	printargs,		"n64_renameat"		}, /* 5254 */
+	{ 0,	0,	printargs,		"n64_linkat"		}, /* 5255 */
+	{ 0,	0,	printargs,		"n64_symlinkat"		}, /* 5256 */
+	{ 0,	0,	printargs,		"n64_readlinkat"	}, /* 5257 */
+	{ 0,	0,	printargs,		"n64_fchmodat"		}, /* 5258 */
+	{ 0,	0,	printargs,		"n64_faccessat"		}, /* 5259 */
+	{ 0,	0,	printargs,		"n64_pselect6"		}, /* 5260 */
+	{ 0,	0,	printargs,		"n64_ppoll"		}, /* 5261 */
+	{ 0,	0,	printargs,		"n64_unshare"		}, /* 5262 */
+	{ 0,	0,	printargs,		"n64_splice"		}, /* 5263 */
+	{ 0,	0,	printargs,		"n64_sync_file_range"	}, /* 5264 */
+	{ 0,	0,	printargs,		"n64_tee"		}, /* 5265 */
+	{ 0,	0,	printargs,		"n64_vmsplice"		}, /* 5266 */
+	{ 0,	0,	printargs,		"n64_move_pages"	}, /* 5267 */
+	{ 0,	0,	printargs,		"n64_set_robust_list"	}, /* 5268 */
+	{ 0,	0,	printargs,		"n64_get_robust_list"	}, /* 5269 */
+	{ 0,	0,	printargs,		"n64_kexec_load"	}, /* 5270 */
+	{ 0,	0,	printargs,		"n64_getcpu"		}, /* 5271 */
+	{ 0,	0,	printargs,		"n64_epoll_pwait"	}, /* 5272 */
+	{ 0,	0,	printargs,		"n64_ioprio_set"	}, /* 5273 */
+	{ 0,	0,	printargs,		"n64_ioprio_get"	}, /* 5274 */
+	{ 0,	0,	printargs,		"n64_utimensat"		}, /* 5275 */
+	{ 0,	0,	printargs,		"n64_signalfd"		}, /* 5276 */
+	{ 0,	0,	printargs,		"n64_SYS_5277"		}, /* 5277 */
+	{ 0,	0,	printargs,		"n64_eventfd"		}, /* 5278 */
+	{ 0,	0,	printargs,		"n64_fallocate"		}, /* 5279 */
+	{ 0,	0,	printargs,		"n64_timerfd_create"	}, /* 5280 */
+	{ 0,	0,	printargs,		"n64_timerfd_gettime"	}, /* 5281 */
+	{ 0,	0,	printargs,		"n64_timerfd_settime"	}, /* 5282 */
+	{ 0,	0,	printargs,		"n64_signalfd4"		}, /* 5283 */
+	{ 0,	0,	printargs,		"n64_eventfd2"		}, /* 5284 */
+	{ 0,	0,	printargs,		"n64_epoll_create1"	}, /* 5285 */
+	{ 0,	0,	printargs,		"n64_dup3"		}, /* 5286 */
+	{ 0,	0,	printargs,		"n64_pipe2"		}, /* 5287 */
+	{ 0,	0,	printargs,		"n64_inotify_init1"	}, /* 5288 */
+	{ 0,	0,	printargs,		"n64_preadv"		}, /* 5289 */
+	{ 0,	0,	printargs,		"n64_pwritev"		}, /* 5290 */
+	{ 0,	0,	printargs,		"n64_rt_tgsigqueueinfo" }, /* 5291 */
+	{ 0,	0,	printargs,		"n64_perf_event_open"	}, /* 5292 */
+	{ 0,	0,	printargs,		"n64_accept4"		}, /* 5293 */
+	{ 0,	0,	printargs,		"n64_recvmmsg"		}, /* 5294 */
 #endif
-	{ 0,	0,	printargs,		"SYS_5221"	}, /* 5221 */
-	{ 0,	0,	printargs,		"SYS_5222"	}, /* 5222 */
-	{ 0,	0,	printargs,		"SYS_5223"	}, /* 5223 */
-	{ 0,	0,	printargs,		"SYS_5224"	}, /* 5224 */
-	{ 0,	0,	printargs,		"SYS_5225"	}, /* 5225 */
-	{ 0,	0,	printargs,		"SYS_5226"	}, /* 5226 */
-	{ 0,	0,	printargs,		"SYS_5227"	}, /* 5227 */
-	{ 0,	0,	printargs,		"SYS_5228"	}, /* 5228 */
-	{ 0,	0,	printargs,		"SYS_5229"	}, /* 5229 */
-	{ 0,	0,	printargs,		"SYS_5230"	}, /* 5230 */
-	{ 0,	0,	printargs,		"SYS_5231"	}, /* 5231 */
-	{ 0,	0,	printargs,		"SYS_5232"	}, /* 5232 */
-	{ 0,	0,	printargs,		"SYS_5233"	}, /* 5233 */
-	{ 0,	0,	printargs,		"SYS_5234"	}, /* 5234 */
-	{ 0,	0,	printargs,		"SYS_5235"	}, /* 5235 */
-	{ 0,	0,	printargs,		"SYS_5236"	}, /* 5236 */
-	{ 0,	0,	printargs,		"SYS_5237"	}, /* 5237 */
-	{ 0,	0,	printargs,		"SYS_5238"	}, /* 5238 */
-	{ 0,	0,	printargs,		"SYS_5239"	}, /* 5239 */
-	{ 0,	0,	printargs,		"SYS_5240"	}, /* 5240 */
-	{ 0,	0,	printargs,		"SYS_5241"	}, /* 5241 */
-	{ 0,	0,	printargs,		"SYS_5242"	}, /* 5242 */
-	{ 0,	0,	printargs,		"SYS_5243"	}, /* 5243 */
-	{ 0,	0,	printargs,		"SYS_5244"	}, /* 5244 */
-	{ 0,	0,	printargs,		"SYS_5245"	}, /* 5245 */
-	{ 0,	0,	printargs,		"SYS_5246"	}, /* 5246 */
-	{ 0,	0,	printargs,		"SYS_5247"	}, /* 5247 */
-	{ 0,	0,	printargs,		"SYS_5248"	}, /* 5248 */
-	{ 0,	0,	printargs,		"SYS_5249"	}, /* 5249 */
-	{ 0,	0,	printargs,		"SYS_5250"	}, /* 5250 */
-	{ 0,	0,	printargs,		"SYS_5251"	}, /* 5251 */
-	{ 0,	0,	printargs,		"SYS_5252"	}, /* 5252 */
-	{ 0,	0,	printargs,		"SYS_5253"	}, /* 5253 */
-	{ 0,	0,	printargs,		"SYS_5254"	}, /* 5254 */
-	{ 0,	0,	printargs,		"SYS_5255"	}, /* 5255 */
-	{ 0,	0,	printargs,		"SYS_5256"	}, /* 5256 */
-	{ 0,	0,	printargs,		"SYS_5257"	}, /* 5257 */
-	{ 0,	0,	printargs,		"SYS_5258"	}, /* 5258 */
-	{ 0,	0,	printargs,		"SYS_5259"	}, /* 5259 */
-	{ 0,	0,	printargs,		"SYS_5260"	}, /* 5260 */
-	{ 0,	0,	printargs,		"SYS_5261"	}, /* 5261 */
-	{ 0,	0,	printargs,		"SYS_5262"	}, /* 5262 */
-	{ 0,	0,	printargs,		"SYS_5263"	}, /* 5263 */
-	{ 0,	0,	printargs,		"SYS_5264"	}, /* 5264 */
-	{ 0,	0,	printargs,		"SYS_5265"	}, /* 5265 */
-	{ 0,	0,	printargs,		"SYS_5266"	}, /* 5266 */
-	{ 0,	0,	printargs,		"SYS_5267"	}, /* 5267 */
-	{ 0,	0,	printargs,		"SYS_5268"	}, /* 5268 */
-	{ 0,	0,	printargs,		"SYS_5269"	}, /* 5269 */
-	{ 0,	0,	printargs,		"SYS_5270"	}, /* 5270 */
-	{ 0,	0,	printargs,		"SYS_5271"	}, /* 5271 */
-	{ 0,	0,	printargs,		"SYS_5272"	}, /* 5272 */
-	{ 0,	0,	printargs,		"SYS_5273"	}, /* 5273 */
-	{ 0,	0,	printargs,		"SYS_5274"	}, /* 5274 */
-	{ 0,	0,	printargs,		"SYS_5275"	}, /* 5275 */
-	{ 0,	0,	printargs,		"SYS_5276"	}, /* 5276 */
-	{ 0,	0,	printargs,		"SYS_5277"	}, /* 5277 */
-	{ 0,	0,	printargs,		"SYS_5278"	}, /* 5278 */
-	{ 0,	0,	printargs,		"SYS_5279"	}, /* 5279 */
-	{ 0,	0,	printargs,		"SYS_5280"	}, /* 5280 */
-	{ 0,	0,	printargs,		"SYS_5281"	}, /* 5281 */
-	{ 0,	0,	printargs,		"SYS_5282"	}, /* 5282 */
-	{ 0,	0,	printargs,		"SYS_5283"	}, /* 5283 */
-	{ 0,	0,	printargs,		"SYS_5284"	}, /* 5284 */
-	{ 0,	0,	printargs,		"SYS_5285"	}, /* 5285 */
-	{ 0,	0,	printargs,		"SYS_5286"	}, /* 5286 */
-	{ 0,	0,	printargs,		"SYS_5287"	}, /* 5287 */
-	{ 0,	0,	printargs,		"SYS_5288"	}, /* 5288 */
-	{ 0,	0,	printargs,		"SYS_5289"	}, /* 5289 */
-	{ 0,	0,	printargs,		"SYS_5290"	}, /* 5290 */
-	{ 0,	0,	printargs,		"SYS_5291"	}, /* 5291 */
-	{ 0,	0,	printargs,		"SYS_5292"	}, /* 5292 */
-	{ 0,	0,	printargs,		"SYS_5293"	}, /* 5293 */
-	{ 0,	0,	printargs,		"SYS_5294"	}, /* 5294 */
 	{ 0,	0,	printargs,		"SYS_5295"	}, /* 5295 */
 	{ 0,	0,	printargs,		"SYS_5296"	}, /* 5296 */
 	{ 0,	0,	printargs,		"SYS_5297"	}, /* 5297 */
@@ -6746,43 +6836,113 @@
 	{ 2,	0,	sys_fremovexattr,	"fremovexattr"	}, /* 6191 */
 	{ 2,	0,	sys_kill,		"tkill"		}, /* 6192 */
 	{ 1,	0,	sys_time,		"time"		}, /* 6193 */
-	{ 5,	0,	printargs,		"futex"		}, /* 6194 */
-	{ 3,	0,	printargs,		"sched_setaffinity"}, /* 6195 */
-	{ 3,	0,	printargs,		"sched_getaffinity"}, /* 6196 */
+	{ 6,	0,	sys_futex,		"futex"		}, /* 6194 */
+	{ 3,	0,	sys_sched_setaffinity,	"sched_setaffinity"}, /* 6195 */
+	{ 3,	0,	sys_sched_getaffinity,	"sched_getaffinity"}, /* 6196 */
 	{ 3,	0,	printargs,		"cacheflush"	}, /* 6197 */
 	{ 3,	0,	printargs,		"cachectl"	}, /* 6198 */
 	{ 4,	0,	sys_sysmips,		"sysmips"	}, /* 6199 */
-	{ 0,	0,	printargs,		"io_setup"	}, /* 6200 */
-	{ 0,	0,	printargs,		"io_destroy"	}, /* 6201 */
-	{ 0,	0,	printargs,		"io_getevents"	}, /* 6202 */
-	{ 0,	0,	printargs,		"io_submit"	}, /* 6203 */
-	{ 0,	0,	printargs,		"io_cancel"	}, /* 6204 */
+	{ 2,	0,	sys_io_setup,		"io_setup"	}, /* 6200 */
+	{ 1,	0,	sys_io_destroy,		"io_destroy"	}, /* 6201 */
+	{ 5,	0,	sys_io_getevents,	"io_getevents"	}, /* 6202 */
+	{ 3,	0,	sys_io_submit,		"io_submit"	}, /* 6203 */
+	{ 3,	0,	sys_io_cancel,		"io_cancel"	}, /* 6204 */
 	{ 1,	TP,	sys_exit,		"exit_group"}, /* 6205 */
 	{ 3,	0,	printargs,		"lookup_dcookie"	}, /* 6206 */
 	{ 1,	0,	sys_epoll_create,	"epoll_create"	}, /* 6207 */
 	{ 4,	TD,	sys_epoll_ctl,		"epoll_ctl"	}, /* 6208 */
-	{ 3,	TD,	sys_epoll_wait,		"epoll_wait"	}, /* 6209 */
+	{ 4,	TD,	sys_epoll_wait,		"epoll_wait"	}, /* 6209 */
 	{ 5,	0,	sys_remap_file_pages,	"remap_file_pages"	}, /* 6210 */
 	{ 1,	TS,	printargs,		"rt_sigreturn"	}, /* 6211 */
 	{ 3,	0,	sys_fcntl,		"fcntl64"	}, /* 6212 */
-	{ 0,	0,	printargs,		"set_tid_address"	}, /* 6213 */
-	{ 0,	0,	printargs,		"restart_syscall"	}, /* 6214 */
-	{ 0,	0,	printargs,		"semtimedop"	}, /* 6215 */
-	{ 0,	0,	printargs,		"fadvise64"	}, /* 6216 */
-	{ 0,	0,	printargs,		"statfs64"	}, /* 6217 */
-	{ 0,	0,	printargs,		"fstatfs64"	}, /* 6218 */
-	{ 4,	TD|TN,	printargs,		"sendfile64"	}, /* 6219 */
-	{ 3,	0,	printargs,		"timer_create"	}, /* 6220 */
-	{ 4,	0,	printargs,		"timer_settime"	}, /* 6221 */
-	{ 2,	0,	printargs,		"timer_gettime"	}, /* 6222 */
-	{ 1,	0,	printargs,		"timer_getoverrun"	}, /* 6223 */
-	{ 1,	0,	printargs,		"timer_delete"	}, /* 6224 */
-	{ 2,	0,	printargs,		"clock_settime"	}, /* 6225 */
-	{ 2,	0,	printargs,		"clock_gettime"	}, /* 6226 */
-	{ 2,	0,	printargs,		"clock_getres"	}, /* 6227 */
-	{ 4,	0,	printargs,		"clock_nanosleep"	}, /* 6228 */
-	{ 3,	0,	printargs,		"tgkill"	}, /* 6229 */
-	{ 2,	0,	printargs,		"utimes"	}, /* 6230 */
+	{ 1,	0,	printargs,		"set_tid_address" }, /* 6213 */
+	{ 0,	0,	sys_restart_syscall,	"restart_syscall" }, /* 6214 */
+	{ 5,	TI,	sys_semtimedop,		"semtimedop"	}, /* 6215 */
+	{ 5,	0,	sys_fadvise64,		"fadvise64"	}, /* 6216 */
+	{ 3,	TF,	sys_statfs64,		"statfs64"	}, /* 6217 */
+	{ 3,	TD,	sys_fstatfs64,		"fstatfs64"	}, /* 6218 */
+	{ 4,	TD|TN,	sys_sendfile64,		"sendfile64"	}, /* 6219 */
+	{ 3,	0,	sys_timer_create,	"timer_create"	}, /* 6220 */
+	{ 4,	0,	sys_timer_settime,	"timer_settime"	}, /* 6221 */
+	{ 2,	0,	sys_timer_gettime,	"timer_gettime"	}, /* 6222 */
+	{ 1,	0,	sys_timer_getoverrun,	"timer_getoverrun"	}, /* 6223 */
+	{ 1,	0,	sys_timer_delete,	"timer_delete"	}, /* 6224 */
+	{ 2,	0,	sys_clock_settime,	"clock_settime"	}, /* 6225 */
+	{ 2,	0,	sys_clock_gettime,	"clock_gettime"	}, /* 6226 */
+	{ 2,	0,	sys_clock_getres,	"clock_getres"	}, /* 6227 */
+	{ 4,	0,	sys_clock_nanosleep,	"clock_nanosleep" }, /* 6228 */
+	{ 3,	TS,	sys_tgkill,		"tgkill"	}, /* 6229 */
+	{ 2,	TF,	sys_utimes,		"utimes"	}, /* 6230 */
+	{ 0,	0,	printargs,		"SYS_6231"	}, /* 6231 */
+	{ 0,	0,	printargs,		"SYS_6232"	}, /* 6232 */
+	{ 0,	0,	printargs,		"SYS_6233"	}, /* 6233 */
+	{ 4,	0,	sys_mq_open,		"mq_open"	}, /* 6234 */
+	{ 1,	0,	sys_mq_unlink,		"mq_unlink"	}, /* 6235 */
+	{ 5,	0,	sys_mq_timedsend,	"mq_timedsend"	}, /* 6236 */
+	{ 5,	0,	sys_mq_timedreceive,	"mq_timedreceive" }, /* 6237 */
+	{ 2,	0,	sys_mq_notify,		"mq_notify"	}, /* 6238 */
+	{ 3,	0,	sys_mq_getsetattr,	"mq_getsetattr"	}, /* 6239 */
+	{ 0,	0,	printargs,		"SYS_6240"	}, /* 6240 */
+	{ 5,	TP,	sys_waitid,		"waitid"	}, /* 6241 */
+	{ 0,	0,	printargs,		"SYS_6242"	}, /* 6242 */
+	{ 5,	0,	printargs,		"add_key"	}, /* 6243 */
+	{ 4,	0,	printargs,		"request_key"	}, /* 6244 */
+	{ 5,	0,	printargs,		"keyctl"	}, /* 6245 */
+	{ 1,	0,	sys_set_thread_area,	"set_thread_area" }, /* 6246 */
+	{ 0,	TD,	printargs,		"inotify_init"	}, /* 6247 */
+	{ 3,	TD,	sys_inotify_add_watch,	"inotify_add_watch" }, /* 6248 */
+	{ 2,	TD,	sys_inotify_rm_watch,	"inotify_rm_watch" }, /* 6249 */
+	{ 4,	0,	printargs,		"migrate_pages"	}, /* 6250 */
+	{ 4,	TD|TF,	sys_openat,		"openat"	}, /* 6251 */
+	{ 3,	TD|TF,	sys_mkdirat,		"mkdirat"	}, /* 6252 */
+	{ 4,	TD|TF,	sys_mknodat,		"mknodat"	}, /* 6253 */
+	{ 5,	TD|TF,	sys_fchownat,		"fchownat"	}, /* 6254 */
+	{ 3,	TD|TF,	sys_futimesat,		"futimesat"	}, /* 6255 */
+	{ 4,	TD|TF,	sys_newfstatat,		"newfstatat"	}, /* 6256 */
+	{ 3,	TD|TF,	sys_unlinkat,		"unlinkat"	}, /* 6257 */
+	{ 4,	TD|TF,	sys_renameat,		"renameat"	}, /* 6258 */
+	{ 5,	TD|TF,	sys_linkat,		"linkat"	}, /* 6259 */
+	{ 3,	TD|TF,	sys_symlinkat,		"symlinkat"	}, /* 6260 */
+	{ 4,	TD|TF,	sys_readlinkat,		"readlinkat"	}, /* 6261 */
+	{ 3,	TD|TF,	sys_fchmodat,		"fchmodat"	}, /* 6262 */
+	{ 3,	TD|TF,	sys_faccessat,		"faccessat"	}, /* 6263 */
+	{ 6,	TD,	sys_pselect6,		"pselect6"	}, /* 6264 */
+	{ 5,	TD,	sys_ppoll,		"ppoll"		}, /* 6265 */
+	{ 1,	TP,	sys_unshare,		"unshare"	}, /* 6266 */
+	{ 6,	TD,	printargs,		"splice"	}, /* 6267 */
+	{ 4,	TD,	printargs,		"sync_file_range" }, /* 6268 */
+	{ 4,	TD,	printargs,		"tee"		}, /* 6269 */
+	{ 4,	TD,	printargs,		"vmsplice"	}, /* 6270 */
+	{ 6,	0,	printargs,		"move_pages"	}, /* 6271 */
+	{ 2,	0,	printargs,		"set_robust_list" }, /* 6272 */
+	{ 3,	0,	printargs,		"get_robust_list" }, /* 6273 */
+	{ 5,	0,	printargs,		"kexec_load"	}, /* 6274 */
+	{ 3,	0,	sys_getcpu,		"getcpu"	}, /* 6275 */
+	{ 5,	TD,	sys_epoll_pwait,	"epoll_pwait"	}, /* 6276 */
+	{ 3,	0,	printargs,		"ioprio_set"	}, /* 6277 */
+	{ 2,	0,	printargs,		"ioprio_get"	}, /* 6278 */
+	{ 4,	TD|TF,	sys_utimensat,		"utimensat"	}, /* 6279 */
+	{ 3,	TD|TS,	sys_signalfd,		"signalfd"	}, /* 6280 */
+	{ 0,	0,	printargs,		"SYS_6281"	}, /* 6281 */
+	{ 1,	TD,	sys_eventfd,		"eventfd"	}, /* 6282 */
+	{ 6,	TF,	sys_fallocate,		"fallocate"	}, /* 6283 */
+	{ 2,	TD,	sys_timerfd_create,	"timerfd_create" }, /* 6284 */
+	{ 2,	TD,	sys_timerfd_gettime,	"timerfd_gettime" }, /* 6285 */
+	{ 4,	TD,	sys_timerfd_settime,	"timerfd_settime" }, /* 6286 */
+	{ 4,	TD|TS,	sys_signalfd4,		"signalfd4"	}, /* 6287 */
+	{ 2,	TD,	sys_eventfd2,		"eventfd2"	}, /* 6288 */
+	{ 1,	0,	sys_epoll_create1,	"epoll_create1"	}, /* 6289 */
+	{ 3,	TD,	sys_dup3,		"dup3"		}, /* 6290 */
+	{ 2,	TD,	sys_pipe2,		"pipe2"		}, /* 6291 */
+	{ 1,	TD,	sys_inotify_init1,	"inotify_init1"	}, /* 6292 */
+	{ 5,	TD,	printargs,		"preadv"	}, /* 6293 */
+	{ 5,	TD,	printargs,		"pwritev"	}, /* 6294 */
+	{ 4,	TP|TS,	printargs,		"rt_tgsigqueueinfo" }, /* 6295 */
+	{ 5,	TD,	printargs,		"perf_event_open" }, /* 6296 */
+	{ 4,	TN,	sys_accept4,		"accept4"	}, /* 6297 */
+	{ 5,	TN,	sys_recvmmsg,		"recvmmsg"	}, /* 6298 */
+	{ 3,	TD,	sys_getdents,		"getdents"	}, /* 6299 */
+
 #else
 	{ 0,	0,	printargs,		"n32_read"		}, /* 6000 */
 	{ 0,	0,	printargs,		"n32_write"		}, /* 6001 */
@@ -7015,76 +7175,76 @@
 	{ 4,	0,	printargs,		"n32_clock_nanosleep"	}, /* 6228 */
 	{ 3,	0,	printargs,		"n32_tgkill"		}, /* 6229 */
 	{ 2,	0,	printargs,		"n32_utimes"		}, /* 6230 */
+	{ 0,	0,	printargs,		"n32_SYS_6231"		}, /* 6231 */
+	{ 0,	0,	printargs,		"n32_SYS_6232"		}, /* 6232 */
+	{ 0,	0,	printargs,		"n32_SYS_6233"		}, /* 6233 */
+	{ 4,	0,	printargs,		"n32_mq_open"		}, /* 6234 */
+	{ 1,	0,	printargs,		"n32_mq_unlink"		}, /* 6235 */
+	{ 5,	0,	printargs,		"n32_mq_timedsend"	}, /* 6236 */
+	{ 5,	0,	printargs,		"n32_mq_timedreceive"	}, /* 6237 */
+	{ 2,	0,	printargs,		"n32_mq_notify"		}, /* 6238 */
+	{ 3,	0,	printargs,		"n32_mq_getsetattr"	}, /* 6239 */
+	{ 0,	0,	printargs,		"n32_SYS_6240"		}, /* 6240 */
+	{ 5,	TP,	printargs,		"n32_waitid"		}, /* 6241 */
+	{ 0,	0,	printargs,		"n32_SYS_6242"		}, /* 6242 */
+	{ 5,	0,	printargs,		"n32_add_key"		}, /* 6243 */
+	{ 4,	0,	printargs,		"n32_request_key"	}, /* 6244 */
+	{ 5,	0,	printargs,		"n32_keyctl"		}, /* 6245 */
+	{ 1,	0,	printargs,		"n32_set_thread_area"	}, /* 6246 */
+	{ 0,	TD,	printargs,		"n32_inotify_init"	}, /* 6247 */
+	{ 3,	TD,	printargs,		"n32_inotify_add_watch" }, /* 6248 */
+	{ 2,	TD,	printargs,		"n32_inotify_rm_watch"	}, /* 6249 */
+	{ 4,	0,	printargs,		"n32_migrate_pages"	}, /* 6250 */
+	{ 4,	TD|TF,	printargs,		"n32_openat"		}, /* 6251 */
+	{ 3,	TD|TF,	printargs,		"n32_mkdirat"		}, /* 6252 */
+	{ 4,	TD|TF,	printargs,		"n32_mknodat"		}, /* 6253 */
+	{ 5,	TD|TF,	printargs,		"n32_fchownat"		}, /* 6254 */
+	{ 3,	TD|TF,	printargs,		"n32_futimesat"		}, /* 6255 */
+	{ 4,	TD|TF,	printargs,		"n32_newfstatat"	}, /* 6256 */
+	{ 3,	TD|TF,	printargs,		"n32_unlinkat"		}, /* 6257 */
+	{ 4,	TD|TF,	printargs,		"n32_renameat"		}, /* 6258 */
+	{ 5,	TD|TF,	printargs,		"n32_linkat"		}, /* 6259 */
+	{ 3,	TD|TF,	printargs,		"n32_symlinkat"		}, /* 6260 */
+	{ 4,	TD|TF,	printargs,		"n32_readlinkat"	}, /* 6261 */
+	{ 3,	TD|TF,	printargs,		"n32_fchmodat"		}, /* 6262 */
+	{ 3,	TD|TF,	printargs,		"n32_faccessat"		}, /* 6263 */
+	{ 6,	TD,	printargs,		"n32_pselect6"		}, /* 6264 */
+	{ 5,	TD,	printargs,		"n32_ppoll"		}, /* 6265 */
+	{ 1,	TP,	printargs,		"n32_unshare"		}, /* 6266 */
+	{ 6,	TD,	printargs,		"n32_splice"		}, /* 6267 */
+	{ 4,	TD,	printargs,		"n32_sync_file_range"	}, /* 6268 */
+	{ 4,	TD,	printargs,		"n32_tee"		}, /* 6269 */
+	{ 4,	TD,	printargs,		"n32_vmsplice"		}, /* 6270 */
+	{ 6,	0,	printargs,		"n32_move_pages"	}, /* 6271 */
+	{ 2,	0,	printargs,		"n32_set_robust_list"	}, /* 6272 */
+	{ 3,	0,	printargs,		"n32_get_robust_list"	}, /* 6273 */
+	{ 5,	0,	printargs,		"n32_kexec_load"	}, /* 6274 */
+	{ 3,	0,	printargs,		"n32_getcpu"		}, /* 6275 */
+	{ 5,	TD,	printargs,		"n32_epoll_pwait"	}, /* 6276 */
+	{ 3,	0,	printargs,		"n32_ioprio_set"	}, /* 6277 */
+	{ 2,	0,	printargs,		"n32_ioprio_get"	}, /* 6278 */
+	{ 4,	TD|TF,	printargs,		"n32_utimensat"		}, /* 6279 */
+	{ 3,	TD|TS,	printargs,		"n32_signalfd"		}, /* 6280 */
+	{ 0,	0,	printargs,		"n32_SYS_6281"		}, /* 6281 */
+	{ 1,	TD,	printargs,		"n32_eventfd"		}, /* 6282 */
+	{ 6,	TF,	printargs,		"n32_fallocate"		}, /* 6283 */
+	{ 2,	TD,	printargs,		"n32_timerfd_create"	}, /* 6284 */
+	{ 2,	TD,	printargs,		"n32_timerfd_gettime"	}, /* 6285 */
+	{ 4,	TD,	printargs,		"n32_timerfd_settime"	}, /* 6286 */
+	{ 4,	TD|TS,	printargs,		"n32_signalfd4"		}, /* 6287 */
+	{ 2,	TD,	printargs,		"n32_eventfd2"		}, /* 6288 */
+	{ 1,	0,	printargs,		"n32_epoll_create1"	}, /* 6289 */
+	{ 3,	TD,	printargs,		"n32_dup3"		}, /* 6290 */
+	{ 2,	TD,	printargs,		"n32_pipe2"		}, /* 6291 */
+	{ 1,	TD,	printargs,		"n32_inotify_init1"	}, /* 6292 */
+	{ 5,	TD,	printargs,		"n32_preadv"		}, /* 6293 */
+	{ 5,	TD,	printargs,		"n32_pwritev"		}, /* 6294 */
+	{ 4,	TP|TS,	printargs,		"n32_rt_tgsigqueueinfo" }, /* 6295 */
+	{ 5,	TD,	printargs,		"n32_perf_event_open"	}, /* 6296 */
+	{ 4,	TN,	printargs,		"n32_accept4"		}, /* 6297 */
+	{ 5,	TN,	printargs,		"n32_recvmmsg"		}, /* 6298 */
+	{ 3,	TD,	printargs,		"n32_getdents"		}, /* 6299 */
 #endif
-	{ 0,	0,	printargs,		"SYS_6231"	}, /* 6231 */
-	{ 0,	0,	printargs,		"SYS_6232"	}, /* 6232 */
-	{ 0,	0,	printargs,		"SYS_6233"	}, /* 6233 */
-	{ 0,	0,	printargs,		"SYS_6234"	}, /* 6234 */
-	{ 0,	0,	printargs,		"SYS_6235"	}, /* 6235 */
-	{ 0,	0,	printargs,		"SYS_6236"	}, /* 6236 */
-	{ 0,	0,	printargs,		"SYS_6237"	}, /* 6237 */
-	{ 0,	0,	printargs,		"SYS_6238"	}, /* 6238 */
-	{ 0,	0,	printargs,		"SYS_6239"	}, /* 6239 */
-	{ 0,	0,	printargs,		"SYS_6240"	}, /* 6240 */
-	{ 0,	0,	printargs,		"SYS_6241"	}, /* 6241 */
-	{ 0,	0,	printargs,		"SYS_6242"	}, /* 6242 */
-	{ 0,	0,	printargs,		"SYS_6243"	}, /* 6243 */
-	{ 0,	0,	printargs,		"SYS_6244"	}, /* 6244 */
-	{ 0,	0,	printargs,		"SYS_6245"	}, /* 6245 */
-	{ 0,	0,	printargs,		"SYS_6246"	}, /* 6246 */
-	{ 0,	0,	printargs,		"SYS_6247"	}, /* 6247 */
-	{ 0,	0,	printargs,		"SYS_6248"	}, /* 6248 */
-	{ 0,	0,	printargs,		"SYS_6249"	}, /* 6249 */
-	{ 0,	0,	printargs,		"SYS_6250"	}, /* 6250 */
-	{ 0,	0,	printargs,		"SYS_6251"	}, /* 6251 */
-	{ 0,	0,	printargs,		"SYS_6252"	}, /* 6252 */
-	{ 0,	0,	printargs,		"SYS_6253"	}, /* 6253 */
-	{ 0,	0,	printargs,		"SYS_6254"	}, /* 6254 */
-	{ 0,	0,	printargs,		"SYS_6255"	}, /* 6255 */
-	{ 0,	0,	printargs,		"SYS_6256"	}, /* 6256 */
-	{ 0,	0,	printargs,		"SYS_6257"	}, /* 6257 */
-	{ 0,	0,	printargs,		"SYS_6258"	}, /* 6258 */
-	{ 0,	0,	printargs,		"SYS_6259"	}, /* 6259 */
-	{ 0,	0,	printargs,		"SYS_6260"	}, /* 6260 */
-	{ 0,	0,	printargs,		"SYS_6261"	}, /* 6261 */
-	{ 0,	0,	printargs,		"SYS_6262"	}, /* 6262 */
-	{ 0,	0,	printargs,		"SYS_6263"	}, /* 6263 */
-	{ 0,	0,	printargs,		"SYS_6264"	}, /* 6264 */
-	{ 0,	0,	printargs,		"SYS_6265"	}, /* 6265 */
-	{ 0,	0,	printargs,		"SYS_6266"	}, /* 6266 */
-	{ 0,	0,	printargs,		"SYS_6267"	}, /* 6267 */
-	{ 0,	0,	printargs,		"SYS_6268"	}, /* 6268 */
-	{ 0,	0,	printargs,		"SYS_6269"	}, /* 6269 */
-	{ 0,	0,	printargs,		"SYS_6270"	}, /* 6270 */
-	{ 0,	0,	printargs,		"SYS_6271"	}, /* 6271 */
-	{ 0,	0,	printargs,		"SYS_6272"	}, /* 6272 */
-	{ 0,	0,	printargs,		"SYS_6273"	}, /* 6273 */
-	{ 0,	0,	printargs,		"SYS_6274"	}, /* 6274 */
-	{ 0,	0,	printargs,		"SYS_6275"	}, /* 6275 */
-	{ 0,	0,	printargs,		"SYS_6276"	}, /* 6276 */
-	{ 0,	0,	printargs,		"SYS_6277"	}, /* 6277 */
-	{ 0,	0,	printargs,		"SYS_6278"	}, /* 6278 */
-	{ 0,	0,	printargs,		"SYS_6279"	}, /* 6279 */
-	{ 0,	0,	printargs,		"SYS_6280"	}, /* 6280 */
-	{ 0,	0,	printargs,		"SYS_6281"	}, /* 6281 */
-	{ 0,	0,	printargs,		"SYS_6282"	}, /* 6282 */
-	{ 0,	0,	printargs,		"SYS_6283"	}, /* 6283 */
-	{ 0,	0,	printargs,		"SYS_6284"	}, /* 6284 */
-	{ 0,	0,	printargs,		"SYS_6285"	}, /* 6285 */
-	{ 0,	0,	printargs,		"SYS_6286"	}, /* 6286 */
-	{ 0,	0,	printargs,		"SYS_6287"	}, /* 6287 */
-	{ 0,	0,	printargs,		"SYS_6288"	}, /* 6288 */
-	{ 0,	0,	printargs,		"SYS_6289"	}, /* 6289 */
-	{ 0,	0,	printargs,		"SYS_6290"	}, /* 6290 */
-	{ 0,	0,	printargs,		"SYS_6291"	}, /* 6291 */
-	{ 0,	0,	printargs,		"SYS_6292"	}, /* 6292 */
-	{ 0,	0,	printargs,		"SYS_6293"	}, /* 6293 */
-	{ 0,	0,	printargs,		"SYS_6294"	}, /* 6294 */
-	{ 0,	0,	printargs,		"SYS_6295"	}, /* 6295 */
-	{ 0,	0,	printargs,		"SYS_6296"	}, /* 6296 */
-	{ 0,	0,	printargs,		"SYS_6297"	}, /* 6297 */
-	{ 0,	0,	printargs,		"SYS_6298"	}, /* 6298 */
-	{ 0,	0,	printargs,		"SYS_6299"	}, /* 6299 */
 	{ 0,	0,	printargs,		"SYS_6300"	}, /* 6300 */
 	{ 0,	0,	printargs,		"SYS_6301"	}, /* 6301 */
 	{ 0,	0,	printargs,		"SYS_6302"	}, /* 6302 */
-- 
1.5.6.5
