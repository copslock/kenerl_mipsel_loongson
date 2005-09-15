Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2005 22:53:26 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:216.31.210.19]:36879 "EHLO
	MMS3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225479AbVIOVxE>; Thu, 15 Sep 2005 22:53:04 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Thu, 15 Sep 2005 14:52:21 -0700
X-Server-Uuid: 35E76369-CF33-4172-911A-D1698BD5E887
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com; Thu, 15 Sep 2005 14:52:41
 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BUM06576; Thu, 15 Sep 2005 14:52:42 -0700 (PDT)
Received: from nt-sjca-0740.brcm.ad.broadcom.com (
 nt-sjca-0740.sj.broadcom.com [10.16.192.49]) by
 mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP id OAA26498; Thu, 15
 Sep 2005 14:52:42 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com ([10.16.192.220]) by
 nt-sjca-0740.brcm.ad.broadcom.com with Microsoft SMTPSVC(6.0.3790.211);
 Thu, 15 Sep 2005 14:52:40 -0700
Received: from [127.0.0.1] ([10.240.253.31]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft SMTPSVC(6.0.3790.211);
 Thu, 15 Sep 2005 14:52:40 -0700
Message-ID: <4329ED24.50506@broadcom.com>
Date:	Thu, 15 Sep 2005 14:52:36 -0700
From:	"Mark Mason" <mason@broadcom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Jonathan Day" <imipak@yahoo.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Building the kernel for a Broadcom SB1
References: <20050915205904.16380.qmail@web31515.mail.mud.yahoo.com>
In-Reply-To: <20050915205904.16380.qmail@web31515.mail.mud.yahoo.com>
X-OriginalArrivalTime: 15 Sep 2005 21:52:41.0018 (UTC)
 FILETIME=[CB85D9A0:01C5BA3F]
X-WSS-ID: 6F37329F20G1881239-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Jonathan Day wrote:

>Hi,
>
>I'm having a few issues building the current
>2.6.14-rc1 for a Broadcom SB1 MIPS64 processor. (No
>huge surprise there, building anything for that
>processor is a pain.)
>
>Anyway, there are a few symbols undefined, which is
>causing problems. First off the bat is TO_PHYS_MASK.
>There is no set of definitions in
>include/asm-mips/addrspace.h for the SB1 processor.
>(For that matter, there's no set of definitions for
>the MIPS64_R2, so I'm guessing those using _R2 chips
>probably have the same problem.)
>  
>
Here's the patch for that particular problem.  There's also a few other 
patches for the SB1 floating around (check the email archives), but 
there appears to be a backlog with getting them committed to the CVS 
repository.

HTH,
Mark

Index: include/asm-mips/addrspace.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/addrspace.h,v
retrieving revision 1.18
diff -u -p -r1.18 addrspace.h
--- include/asm-mips/addrspace.h    14 Jul 2005 12:05:08 -0000    1.18
+++ include/asm-mips/addrspace.h    15 Sep 2005 21:46:56 -0000
@@ -131,6 +131,8 @@
     || defined (CONFIG_CPU_R5000)                    \
     || defined (CONFIG_CPU_NEVADA)                    \
     || defined (CONFIG_CPU_TX49XX)                    \
+    || defined (CONFIG_CPU_SB1)                        \
+    || defined (CONFIG_CPU_SB1A)                    \
     || defined (CONFIG_CPU_MIPS64_R1)
 #define KUSIZE        _LLCONST_(0x0000010000000000)    /* 2^^40 */
 #define KUSIZE_64    _LLCONST_(0x0000010000000000)    /* 2^^40 */
.
