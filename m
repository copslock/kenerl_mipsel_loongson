Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8SCPiG10320
	for linux-mips-outgoing; Fri, 28 Sep 2001 05:25:44 -0700
Received: from mailsrv.s3group.com (mailsrv.s3group.com [193.120.90.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8SCPeD10317
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 05:25:41 -0700
Received: from headyin.s3group.com (headyin.s3group.com [193.120.89.200])
        by mailsrv.s3group.com  with ESMTP id f8SCNqa21228
        for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 13:23:52 +0100 (IST)
Received: from temple ([193.120.89.132])
 by headyin.s3group.com (Sun Internet Mail Server sims.4.0.2000.10.12.16.25.p8)
 with SMTP id <0GKD009QHH6YEY@headyin.s3group.com> for linux-mips@oss.sgi.com;
 Fri, 28 Sep 2001 13:25:46 +0100 (BST)
Date: Fri, 28 Sep 2001 13:54:43 +0100
From: Mike Manchip <michael.manchip@s3group.com>
Subject: having trouble installing exceptions
To: linux-mips <linux-mips@oss.sgi.com>
Reply-to: Mike Manchip <michael.manchip@s3group.com>
Message-id: <016601c1481c$be873260$845978c1@temple.leop.s3group.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all

I'm currently trying to get the mips port to work on a galileo gt64115 board
with a rm5231 chip.

I'm OK right until the point when I'm installing exceptions into
non-cacheable space in arch/mips/kernel/traps.c

as soon as I memcpy except_vec3_generic to KSEG0 + 0x180 and flush the
instruction cache, my machine hangs, and I can't see why!


/* Copy the generic exception handler code to it's final destination. */
 memcpy((void *)(KSEG0 + 0x80), &except_vec1_generic, 0x80);
 memcpy((void *)(KSEG0 + 0x100), &except_vec2_generic, 0x80);
 memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 flush_icache_range(KSEG0 + 0x80, KSEG0 + 0x200);

Is it possibly something to do with the monitor I'm using? I'm using both
PROM and in desperation, a vxworks one (it can see the ethernet card, thus
speeding up kernel loads tremendously).
How does the monitor do exceptions? Do I have to do something special with
exceptions when a monitor is present?

thanks
mike
