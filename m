Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LGkDj24978
	for linux-mips-outgoing; Sat, 21 Jul 2001 09:46:13 -0700
Received: from web13906.mail.yahoo.com (web13906.mail.yahoo.com [216.136.175.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LGkBV24975
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 09:46:11 -0700
Message-ID: <20010721164611.96915.qmail@web13906.mail.yahoo.com>
Received: from [61.133.134.171] by web13906.mail.yahoo.com via HTTP; Sat, 21 Jul 2001 09:46:11 PDT
Date: Sat, 21 Jul 2001 09:46:11 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about alim15x3 ide driver
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, all,

I meet problem about Ali 1535D alim15x3 ide driver.
Because our hardware bug in mips evaluation board,
I can not use DMA mode in alim15x3.c, I have to
use PIO mode. In 2.2.12, I just modify ali15x3_dmaproc
function, and can support PIO directly.
I do not know how to support only PIO mode for
alim15x3 under 2.4.3 kernel.
If someone knows, please help me. Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
