Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7J5Dq18617
	for linux-mips-outgoing; Fri, 7 Dec 2001 11:05:13 -0800
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7J5Ao18608
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 11:05:10 -0800
Received: from 63.70.210.4 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Fri, 07 Dec 2001 10:05:01 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id KAA24531 for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 10:05:08
 -0800 (PST)
Received: from broadcom.com (kwalker@dt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.8.8/8.8.8/MS01) with ESMTP id KAA03799
 for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 10:05:08 -0800 (PST)
Message-ID: <3C1104D4.F700768A@broadcom.com>
Date: Fri, 07 Dec 2001 10:05:08 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: .section problems in entry.S
X-WSS-ID: 100FDB47525688-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I just investigated assembler warnings coming from
arch/mips/kernel/entry.S (checked out as of 12/07 00:00 UTC), and
noticed the following.  After expanding macros, you get something like:

	.text

	.section ".text.init"   (from __INIT)

	.data			(from PANIC)
	.previous		(from PANIC)
	--> section is now .text.init

	.previous		(from __FINIT)
	--> section is now .data, not .text as intended.

Perhaps .pushsection and .popsection should be used in some or all
macros like this?

Or am I smoking crack?

Kip
