Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f364Gft14796
	for linux-mips-outgoing; Thu, 5 Apr 2001 21:16:41 -0700
Received: from mta6.snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f364GfM14793
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 21:16:41 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with ESMTP id <0GBC00IZ2RV4I0@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Thu,  5 Apr 2001 21:16:16 -0700 (PDT)
Date: Thu, 05 Apr 2001 21:15:25 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: edata alignment
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Message-id: <3ACD42DD.A9E0A0E7@pacbell.net>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en, bg
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


In arch/mips/kernel/head.S, there is this code in kernel_entry:

   la      t0, _edata
   sw      zero, (t0)

What guarantees that edata will be word aligned? I don't see a .ALIGN
directive in the ld.script so is it safe to assume that edata will
always be at least word aligned?  I've linked into the kernel a very
large ramdisk, and edata ends up being an odd address, causing a cpu
fault. 

Pete
