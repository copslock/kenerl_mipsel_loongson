Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DD7WY07337
	for linux-mips-outgoing; Mon, 13 Aug 2001 06:07:32 -0700
Received: from web13908.mail.yahoo.com (web13908.mail.yahoo.com [216.136.175.71])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DD7Tj07334
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 06:07:29 -0700
Message-ID: <20010813130729.37581.qmail@web13908.mail.yahoo.com>
Received: from [61.133.138.154] by web13908.mail.yahoo.com; Mon, 13 Aug 2001 06:07:29 PDT
Date: Mon, 13 Aug 2001 06:07:29 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: mips ide disk dma problem
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi, all,

I meet problems about mips ide disk. I find dma mode
is different from other platform. We have to use
dma_cache_wback_inv and vtonocache functions to work
under DMA mode, I read pcnet32 ethernet driver,
it works like that. I do not know if I have to support
ide disk dma, what I have to do?
I use Acerlab 1535D southbridge and M5229 IDE 
controller. I patch 1535D driver to linux 2.2.12 
kernel. Hard disk can work well using PIO mode.
But it is very slow on our mips evaluation board.
Therefore, if someone knows how and where to add
dma_cache_wback_inv, vtonocahce, something like these.
Please help me. 

Thanks in advance!

Barry

__________________________________________________
Do You Yahoo!?
Send instant messages & get email alerts with Yahoo! Messenger.
http://im.yahoo.com/
