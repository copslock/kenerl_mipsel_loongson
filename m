Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADNau228664
	for linux-mips-outgoing; Tue, 13 Nov 2001 15:36:56 -0800
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADNai028657
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 15:36:44 -0800
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id fADNacu21287;
	Tue, 13 Nov 2001 15:36:38 -0800
Received: from newton.sanera.net (newton.sanera.net [172.16.2.11])
	by icarus.sanera.net (8.11.6/8.11.2) with ESMTP id fADNaXu07839;
	Tue, 13 Nov 2001 15:36:33 -0800
Received: from exceed1.sanera.net (exceed1.sanera.net [172.16.2.31])
	by newton.sanera.net (8.11.4/8.11.4) with ESMTP id fADNaUM23719;
	Tue, 13 Nov 2001 15:36:30 -0800 (PST)
Received: from exceed1.sanera.net (exceed1.sanera.net [172.16.2.31])
	by exceed1.sanera.net (8.9.3+Sun/8.9.3) with SMTP id PAA06294;
	Tue, 13 Nov 2001 15:36:32 -0800 (PST)
Message-Id: <200111132336.PAA06294@exceed1.sanera.net>
Date: Tue, 13 Nov 2001 15:36:32 -0800 (PST)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: BUG : Memory leak in Linux 2.4.2 MIPS SMP kernel
To: ralf@gnu.org, linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: LSH7x1WXZ/9lJOHbdoVjeQ==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	Here is the bug we found in the Linux 2.4.2 MIPS SMP kernel and the
	fix for the bug.
	
1. Summary:
	Memory leak in Linux 2.4.2 MIPS SMP kernel

2. Description:
	Memory leak happens whenever a process is created and destroyed.
	Whatever memory allocated during process creation is not getting
	freed when the process exits. This problem can be easily reproduced
	by writing any program/script which does a lot of process creation
	and termination. my test script is
	
	while true
	do
		cat /proc/meminfo
		ls /bin
		cat /proc/slabinfo
	end
	
	when /proc/slabinfo is printed, we can see that size of 32-byte
	memory chunks growing indefinitely and eventually causing the
	following panic:
	
	kernel BUG at page_alloc.c:75!
Unable to handle kernel paging request at virtual address 00000000, epc == 
8013bcdc, ra == 8013bcdc
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 10009f00 0000001f 0000000a
$4 : 802afc10 00000001 00000001 00000000
$8 : 802d7636 b0060170 0000001f 0000000d
$12: 00000000 0000001f 10009f00 0000000a
$16: 80329f50 80329f50 00000000 00657a03
$20: 8053000c 806451a0 80b785a0 ffc00000
$24: 802d7617 8036dca1
$28: 8036c000 8036de08 806451a0 8013bcdc
epc    : 000000008013bcdc
Status : 10009f03
Cause  : 1080000c

BadAddr: 00000000ffc00000Process kswapd (pid: 5, stackpage=8036c000)
Stack: 80253434 8025344c 0000004b 00000001 806451a0 00403000 80329f50 00403000
       00000001 00657a03 8053000c 806451a0 80b785a0 ffc00000 806451a0 8013cba8
       00403000 00000000 80329f50 00403000 801395fc 8013967c 00000000 00000000
       00000000 00000000 00000000 00000000 00657a03 00000000 00000000 00000000
       00000000 00000000 00403000 8053000c 00000007 00424000 80b785a0 806451a0
       ffc00000 ...
Call Trace: [<80253434>] [<8025344c>] [<8013cba8>] [<801395fc>] [<8013967c>] 
[<801398b8>]
 [<801399d8>] [<80139ab0>] [<80136a30>] [<8013b42c>] [<80139c1c>] [<80139c24>]
 [<80162fa8>] [<8013b3e8>] [<8013b4a0>] [<8013b524>] [<8013b55c>] [<80107d38>]
 [<80108d9c>] [<80108d8c>]

3. Keywords
	mips, SMP, memory leak

4. Kernel version

	Linux version 2.4.2

5. Output
	(included as part of description)

6. testcase
	(included as part of description)

7. Environment
	7.1 software
		None
	7.2 Processor info
		(NOTE *** cat /proc/cpuinfo does not print information about 
		    both the CPUs ***)
		cpu                     : MIPS
		processor               : 0
		cpu model               : SiByte SB1 V0.1
		BogoMIPS                : 332.59
		processor               : 1
		cpu model               : SiByte SB1 V0.1
		BogoMIPS                : 332.59
		system type             : SiByte unknown
		byteorder               : big endian
		unaligned accesses      : 0
		wait instruction        : no
		microsecond timers      : no
		extra interrupt vector  : yes
		hardware watchpoint     : no
		VCED exceptions         : not available
		VCEI exceptions         : not available
	7.3 Module information
		No modules.
	7.4 Loaded driver and hardware information (/proc/ioports, /proc/iomem)
	
		bash-2.04# cat /proc/ioports
		bash-2.04# cat /proc/iomem
		00000000-0fe94fff : System RAM
		  00100000-00267d77 : Kernel code
		  00299a40-002ad38f : Kernel data
	7.5 PCI information
		No PCI devices attached
	7.6 SCSI information
		No SCSI devices attached
	7.7 Other information

8. Fix

I found that the bug is in destroy_context() in include/asm-mips/mmu_context.h.
destroy_context() is supposed to kfree() the memory that is allocated by
init_new_context() but it is not doing that.

I modified destroy_context as follows:

/*
 * Destroy context related info for an mm_struct that is about
 * to be put to rest.
 */
extern inline void destroy_context(struct mm_struct *mm)
{
#ifdef CONFIG_SMP
        kfree((void *)mm->context);
#else
        /* Nothing to do.  */
#endif
}

And when I tested this I do not see the memory leak any more.


Krishna Kondaka
Sanera Systems Inc.
krishna@sanera.net
