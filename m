Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24KuMI25623
	for linux-mips-outgoing; Mon, 4 Mar 2002 12:56:22 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g24KuD925620
	for <linux-mips@oss.sgi.com>; Mon, 4 Mar 2002 12:56:13 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05230
	for <linux-mips@oss.sgi.com>; Mon, 4 Mar 2002 11:56:13 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g24JlvB32229;
	Mon, 4 Mar 2002 11:47:57 -0800
Message-ID: <3C83D029.2080402@mvista.com>
Date: Mon, 04 Mar 2002 11:51:05 -0800
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: experimental FPU context switch patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I implemented a new FPU context saving/restoring patch, as previously
suggested by Kevin and Ralf.  The major change is that we will save the FPU
context when we switch out a process, if necessary.

The goal is to gurrantee an off-line process always has its FPU context
saved in memory and thus free to move aother CPU in a SMP system.

The initial experimental patch can be found at the following URL.
It is a quick hack to study the performance impact.  It should be
further optimized.  It also needs to be extended so that it works
for all CPUs (including the ones without FPU) and becomes true SMP-safe
(getting rid of global variable last_task_used_math).

http://linux.junsun.net/patches/oss.sgi.com/experiemental/020304-new-fpu-context-switch/patch

Here is the pseudo code version of the patch:

do_cpu() {

         if (current->used_math) {               /* Using the FPU again.  */
-               lazy_fpu_switch(last_task_used_math);
+               restore_fp(current);    /* we don't need to save  for the 
current proc */
         } else {                                /* First time FPU user.  */

r4xx0_resume()

         save non_scratch registers
+       if (current proc owns FPU) {    /* t used FPU in the curr run */
+               make it turn off FPU for next run
+               save FPU context to current proc
+               (note we leave last_task_used_math alone)
         ....


lmbench is run to compare the performance difference on a UP system
(NEC VR5500).  See the output at the following URL.  orig are
the unpatched kernel.

http://linux.junsun.net/patches/oss.sgi.com/experiemental/020304-new-fpu-context-switch/performance

It is obvious there is not much performance difference.  And this is not
a surprise.

A couple of attributes of the patch:

1) it does not save FPU if the proc did not use FPU in the current run
2) when proc uses FPU again in next run, we don't have to restore FPU context
    if the hardware context has not been used by another proc yet
    (i.e., last_task_used_math == current)

So

1) if no processes are actively using FPU, we don't see much overhead other
    than a couple of load/branch instructions in resume

2) if most processes are actively using FPU, then we see the same overhead.
    The saving of FPU context is necessary in this scenario, whether it is done
    resume() (as in the patch) or a little later in lazy_fpu_swotch() as in
    the current kernel.

3) The only pathological case which would make the patch bad is when you have
    a process that actively uses FPU and it frequently switches context with
    non-FPU-using processes.  In this case, the saving of FPU context each
    time fpu-using proc is switched off is an overhead.

    If each time the fpu-using process runs through a full time slice, the
    overhead is very small percentage wise.  It is the frequent context
    switching in this case would make a kill.

I am interested in testing any benchmarks that would create case 3).  Please
let me know if you know any.

So much for rambling.

Jun
