Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 14:41:50 +0000 (GMT)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:63671 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225192AbUL1Olm> convert rfc822-to-8bit;
	Tue, 28 Dec 2004 14:41:42 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id iBSEfL0e021320;
	Tue, 28 Dec 2004 08:41:23 -0600 (CST)
Received: from dbde2k01.ent.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id iBSEfIcb014471;
	Tue, 28 Dec 2004 08:41:19 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: do_ri exception in Linux (MIPS 4kec)
Date: Tue, 28 Dec 2004 20:11:16 +0530
Message-ID: <F6B01C6242515443BB6E5DDD63AE935F046804@dbde2k01.itg.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: do_ri exception in Linux (MIPS 4kec)
Thread-Index: AcTsD9yVrj6PGEd/T5iWluYb3MjpcwA1eNlg
From: "Nori, Soma Sekhar" <nsekhar@ti.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>, "Iyer, Suraj" <ssiyer@ti.com>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips

Ralf,

Thanks for the input.

To understand what exceptions I was getting (apart from RI), I implemented a counter for each exception.
In "except_vec3_generic" (entry.S), I included some code to increment a counter for each exception received.

<code>
	NESTED(except_vec3_generic, 0, sp)

#if defined(CONFIG_CPU_R5432)
	/* [jsun] work around a nasty bug in R5432  */
	mfc0	k0, CP0_INDEX
#endif 
	mfc0	k1, CP0_CAUSE
      la    k0, exception_counter
	andi	k1, k1, 0x7c                
	addu	k0, k0, k1
      lw    k1, (k0)
      addi  k1, k1, 1
      sw    k1, (k0)

	... (original code follows)

</code>

exception_counter is an array of 32 integers. On printing out the array in do_ri exception handler, I found that only TLB Mod(Code 1), TLBL (Code 2), TLBS (Code 3), syscall (code 8) and RI (code 10) exceptions were received (had count >= 1). With this, will it be safe to assume that RI is the only unwanted exception?

To get hold of exact EPC at which RI is occuring, I tried to clear the EXL bit of status register by adding some more code above the exception counting code in the except_vec3_generic routine.

<code>
	NESTED(except_vec3_generic, 0, sp)

#if defined(CONFIG_CPU_R5432)
	/* [jsun] work around a nasty bug in R5432  */
	mfc0	k0, CP0_INDEX
#endif 
      mfc0    k0, CP0_STATUS
      nop
      ori     k0, k0, 0x2
      xori    k0, k0, 0x2
      mtc0    k0, CP0_STATUS
      nop
	
	... (Exception counting code follows)

</code>

Surprisingly, the processor does not seem to alow me to clear the EXL bit. I get AdEL (code 4) exception as I complete the "mtc0    k0, CP0_STATUS" instruction. The processor goes into an infinite loop of exceptions and boot-up hangs after printing "Freeing unused kernel memory: 48k freed". Is it not possible for software to clear the EXL bit after it has been set by the hardware? If not, what else can I do to get hold of the correct EPC value where RI is occuring?

Thanks,
Sekhar
        

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Monday, December 27, 2004 6:00 PM
To: Nori, Soma Sekhar
Cc: linux-mips@linux-mips.org; Iyer, Suraj
Subject: Re: do_ri exception in Linux (MIPS 4kec)


On Thu, Dec 23, 2004 at 04:58:03PM +0530, Nori, Soma Sekhar wrote:

> We are using montavista Linux version 2.4.17, gcc version 2.95.3 running on MIPS 4kec.
> 
> Here is the dump:
> $0 : 00000000 0044def4 000001ac 0000006b 00000000 7fff7c08 00000001 00000000
> $8 : 0000fc00 00000001 00000000 941524d0 00004700 00000000 97fc3ea0 7fff7c08
> $16: 100048a4 100029d8 100029d8 10003020 00000000 7fff7dc8 10003b60 2d8e2163
> $24: 00000001 2ab7bc30                   10008e70 7fff7bf0 04000000 00439e50
> Hi : 00000000
> Lo : 00000001
> epc  : 00439e84    Not tainted
> Status: 0000fc13
> Cause : 10800028
> Process sh (pid: 18, stackpage=97fc2000)
> Stack: 00000001 00000000 2abd0ff0 7fff7c28 10008e70 00000000 10008e6c 00000000
>        100049a0 0042f188 00000000 100029d8 00000001 00000001 7fff7f04 10008e70
>        00427fe4 00427f00 00000000 00000000 10002764 10008e70 10008e70 00000000
>        00000000 00000000 10008e70 00422734 00000001 00000001 7fff7f04 10008e70
>        10008e70 00000003 10008e70 004315cc 00000001 00000000 10002764 00000000
>        10008e70 ...
> Call Trace:
> Code: 00000000  2421dd48  00220821 <8c220000> 00000000  005c1021  00400008  0000
> 0000  8f99802c
> 
> The epc is not in kernel space and ksymoops did not provide any info. The epc keeps changing to different locations in user space over multiple runs.

In a case like this you're likely dealing with double exceptions.  Your
code is taking an exception and the exception handler while running with
c0_status set is taking another exception.  If the first exception handler
is still running with the c0_status.exl bit set the CPU when taking the
second exception it will not record the PC of the second exception and
you will have a seemingly unexplainable exception.

A few processors have the nasty habit of throwing RI receptions or do
similarly weird things when executing code that is mapped through multiple
TLB pages but the 4kEC shouldn't.

  Ralf
