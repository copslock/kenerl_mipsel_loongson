Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 10:41:10 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:22027 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225316AbTKDKki>;
	Tue, 4 Nov 2003 10:40:38 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AGyZl-0007Ek-00; Tue, 04 Nov 2003 10:38:17 +0000
Received: from holborn.algor.co.uk ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AGyba-0004EL-00; Tue, 04 Nov 2003 10:40:10 +0000
Message-ID: <3FA7820A.2010701@mips.com>
Date: Tue, 04 Nov 2003 10:40:10 +0000
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK) Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Doug Kehn <rdkehn@yahoo.com>
CC: linux-mips@linux-mips.org
Subject: Re: Kernel compiler error : flexible array member not at end of struct
References: <20031104054130.12392.qmail@web12008.mail.yahoo.com>
In-Reply-To: <20031104054130.12392.qmail@web12008.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------030907060805090900090207"
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.606, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030907060805090900090207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Doug Kehn wrote:
> I am using gcc version 2.96-mips3264-000710 (from
> sdelinux-5.01-4eb.i386.rpm).  The kernel is,
> obviously, 2.4.21 (from linux-mips.org).  uclibc is
> version 0.9.21.
> 
> I have seen one or two other posting related to this
> same error.  However, I was unable to find any
> suggested resoltions.  Does anyone know of a solution
> to this compile error?

   There is an updated version of the compiler that handles zero-length 
arrays in structures correctly.  See 
ftp://ftp.mips.com/pub/tools/software/sde-for-linux/

   Alternatively you could apply the attached patch

	Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250

--------------030907060805090900090207
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: md_p.h
===================================================================
RCS file: linux-2.4.18/include/linux/raid/md_p.h,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- md_p.h	4 Mar 2002 11:13:33 -0000	1.1
+++ md_p.h	8 Nov 2002 13:09:02 -0000	1.2
@@ -151,10 +151,12 @@
 	 */
 	mdp_disk_t disks[MD_SB_DISKS];
 
+#if MD_SB_RESERVED_WORDS
 	/*
 	 * Reserved
 	 */
 	__u32 reserved[MD_SB_RESERVED_WORDS];
+#endif
 
 	/*
 	 * Active descriptor

--------------030907060805090900090207--
