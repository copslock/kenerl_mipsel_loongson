Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MFPvD10423
	for linux-mips-outgoing; Tue, 22 Jan 2002 07:25:57 -0800
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MFPZP10418;
	Tue, 22 Jan 2002 07:25:36 -0800
Received: from mail2.sony.co.jp (GateKeeper11.Sony.CO.JP [146.215.0.74])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id g0MEPVL05788;
	Tue, 22 Jan 2002 23:25:31 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id g0MEPVH01056;
	Tue, 22 Jan 2002 23:25:31 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id g0MEPUA01039;
	Tue, 22 Jan 2002 23:25:30 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id XAA10476; Tue, 22 Jan 2002 23:30:16 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id XAA16961; Tue, 22 Jan 2002 23:25:29 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g0MEPTJ05605; Tue, 22 Jan 2002 23:25:29 +0900 (JST)
To: aj@suse.de, hjl@lucon.org, ralf@oss.sgi.com, kevink@mips.com
Cc: linux-mips@oss.sgi.com
Subject: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020122232529V.machida@sm.sony.co.jp>
Date: Tue, 22 Jan 2002 23:25:29 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi, all.

Please review an attached patch set and if it is ok, please megre
into the cvs trees. 

Kevin, please let us  know about "k1 semaphore" you said.
I want to know we can merge those functions or not.

Technical discussions are welcome. 

------------
From: Machida Hiroyuki <machida@sm.sony.co.jp>
To: kevink@mips.com, hjl@lucon.org, drepper@redhat.com,
   libc-hacker@sources.redhat.com, linux-mips@oss.sgi.com
Date: Tue, 22 Jan 2002 15:27:44 +0900
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)


Hi, all.

As I said at 1/20, I'll post the short descriptions about our
test-and-set implementation and patches for linux-2.4.17 and
glibc-2.2.3. 

=====================================================================

We implemented the fast and safe user level test and set function for 
single MIPS CPUs. You don't need to use LL/SC and sysmips() with
this method. (excatly say, sysmips() is needed for initializing, but
once initialized, we don't use it any more).


  NOTE: We assume the single processor to use this method, You can
  not use our method for SMP.  


WHAT'S CHANGED:

  * kernel side change #1
	Set specific constant (we call this value
	"_TST_ACCESS_MAGIC") to K1 on every transition from kernel
	mode to user mode. This means you can use k1 in any
	exception handler as same as before our method introduced,
	except that you have to do 
		"li	k1, _TST_ACCESS_MAGIC" 
	at the very previous of
		"eret" 
	or 
		"j	k0;
		"rfe"
	.
	We choose the value of _TST_ACCESS_MAGIC, to cause SEGV
	fault when you use this value as address.


  * kernel side change #2
	On memory fault hander, kernel check write-access to 
	_TST_ACCESS_MAGIC from fixed address range of user process.
	(EPC is in  _TST_START_MAGIC to _TST_START_MAGIC+PAGE_SIZE)
	If the condtion is met, kernel restart user process 
	from _TST_START_MAGIC. 


  * kernel side change #3
	We add pseudo device driver "/dev/tst" to provide
	test_and_set procedure at the same virtual address
	(_TST_START_MAGIC) to any user process. 

	
    _TST_START_MAGIC:
	        .set noreorder
	0:
	        move    k1, a0
	        lw      v0, 0(a0)
	        nop
	        bnez    v0, 1f
	        nop
	        bne     k1, a0, 0b
	        nop			....<point A>
	        sw      a1, 0(k1)
	1:
	        jr      ra
	        nop


  * glibc change:

	We implement  test_and_set(addr, val) as follows,

		Do mmap /dev/tst to _TST_START_MAGIC, if not yet mapped.
		call _TST_START_MAGIC(addr, val)
	
	If we can't open /dev/tst then, use sysmips() as final resort.


HOW TO WORK:
	If  no context-switch is occured in _TST_START_MAGIC()
	procedure,  nobody changes the mutex var. It's no problem. 
	So you can do _TST_START_MAGIC() porcedure as you see.

	But, if some context-swtich is occured in _TST_START_MAGIC() 
	somebody chages the mutex var. It's a problem.
	We must not store to the mutex var, if context-swtich is
	occured at <point A>.  
	In our method, kernel sets k1 as _TST_ACCESS_MAGIC on
	transition to user mode.  "sw      a1, 0(k1)"  causes
	SEGV-fault if context-swtich is occured at <point A>. 
	The SEGV-fault hander catch this situation, restart user
	process from top of _TST_START_MAGIC().


PATCHES:

I attached three patches;
	1. patch for linux kernel 2.4.17 (SourceForge tree)
	2. patch for glibc 2.2.3  (of HHL 2.0)
	3. patch for linuxthread 2.2.3 (of HHL 2.0)

To test those patches; you must
	turn on CONFIG_MIPS_TST_DEV on config kernel,
	have working version of sysmips(MIPS_ATOMIC_SET),
	update kernel headers before building glibc and
	make /dev/tst device ("mknod c /dev/tst 123 0", 123 is a
	tempoary major number for this device) 

I'v tested  at ITE board. On testing, I'v made lettle changes into
"drivers/char/Config.in" and "arch/mips/kernel/sysmip.c" to enable
CONFIG_MIPS_TST_DEV and to work sysmips() at ITE board. Those chages
are not included in the patch set.

===================================================================

    You can find the paper about it in
	http://lc.linux.or.jp/lc2001/papers/tas-ps2-paper.pdf
	(sorry in japanese only)

    The abstract of the paper is following;

	The Implementation of user level test-and-set on PS2 Linux
	In the multi-thread environment like Linux, a fast
	user-level mutual exclusion mechanism is strongly
	required. But MIPS chips designed for embedded and single
	processor, like the Emotion Engine, have no atomic
	test-and-set instruction. We implemented the fast user-level
	mutual exclusion without invoking system-call and its costs,
	on the PS2 Linux. This method utilizes the memory protection 
	facility of Operating System, to detect preemption and
	nullify the operation. In this paper, we present the method
	and its evaluation.  

---
Hiroyuki Machida
Sony Corp.
