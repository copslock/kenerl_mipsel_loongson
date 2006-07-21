Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2006 07:52:04 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:5001 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8133479AbWGUGvz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2006 07:51:55 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id AFFB52062A
	for <linux-mips@linux-mips.org>; Fri, 21 Jul 2006 12:18:50 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 9AD102061C
	for <linux-mips@linux-mips.org>; Fri, 21 Jul 2006 12:18:50 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Jul 2006 12:21:46 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Bit operations work differently on MIPS and IA32
Date:	Fri, 21 Jul 2006 12:21:45 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D442@blr-m2-msg.wipro.com>
In-Reply-To: <20060720174522.67213.qmail@web31514.mail.mud.yahoo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bit operations work differently on MIPS and IA32
Thread-Index: AcasJFVDEyeancCHSNS+3F9wS4UZvwAajYsg
From:	<hemanth.venkatesh@wipro.com>
To:	<imipak@yahoo.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 21 Jul 2006 06:51:46.0195 (UTC) FILETIME=[21FB2E30:01C6AC92]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

Hi,

It was indeed compiler options, but not sure exactly which one.
Previously we were using WR GNU compiler  mips-wrs-linux-gnu-gcc, and
when we replaced it with mips-wrs-linux-gnu-mips32_el-gpp-gcc bit
operations are working perfectly. The system has been booted from a
cramfs RAMDISK image.

Thanks for your help
Hemanth

-----Original Message-----
From: Jonathan Day [mailto:imipak@yahoo.com] 
Sent: Thursday, July 20, 2006 11:15 PM
To: Hemanth V (WT01 - Embedded Systems); linux-mips@linux-mips.org
Subject: Re: Bit operations work differently on MIPS and IA32

Hi,

Well, looking at it, the word is aligned in exactly
the same way but the bitfields are applied in the
opposite direction. (In the ix32 example, the 6 bits
are counting from the low end of the word, but on the
MIPS are counting from the high end.)

The first question one must ask is whether you are
using the same toolchain for both and what compiler
directives you are giving in each case. (If you are
using GCC on the MIPS, it would also be good to know
what sort of code it was compiled to generate by
default. If you ask GCC for the version information,
it'll give the compiler flags used.)

Even with this information, as another poster noted,
bitfield operations are not guaranteed to be portable.
The best I, or anyone else, can do is see if there's
anything obviously inconsistant in the compiler flags.

If you absolutely need to use the bitfields you've
listed, you CAN do a workaround. Either you can use a
#ifdef to determine the order the bitfields are listed
in the union, OR you can take 6 bits off each end and
recombine the end you want to keep with the offset.

(Optimizing the code could break either of these
methods, as there is no guarantee where the optimizer
will decide to place the fields. That would presumably
be system-dependent, as different bytes may be easier
to access on different architectures, so would be
subject to different optimizations.)

--- hemanth.venkatesh@wipro.com wrote:

> Hi All,
> 
>  
> 
> I ran the below program on an IA32 and AU1100
> machine, both being little
> endian machines and got different results. Does
> anyone know what could
> be the cause of this behaviour. This problem is
> blocking us from booting
> the cramfs rootfs.
> 
>  
> 
> #include <stdio.h>
> 
> typedef unsigned int u32;
> 
> main()
> 
> {
> 
> struct tmp{
> 
> u32 namelen:6,offset:26;
> 
> }tmp1;
> 
>  
> 
> (*(int *)(&tmp1))=0x4c0;
> 
>  
> 
> printf("%d %d\n",tmp1.namelen,tmp1.offset);
> 
>  
> 
> }
> 
>  
> 
> Results on IA32 : 0 19
> 
>  
> 
> Results on AU1100 (MIPS):  0 1216
> 
>  
> 
> Thanks
> 
> hemanth
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
