Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FLpWj12283
	for linux-mips-outgoing; Wed, 15 Aug 2001 14:51:32 -0700
Received: from newsmtp2.atmel.com (newsmtp2.atmel.org [12.146.133.142])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FLpVj12277
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 14:51:31 -0700
Received: from hermes.sjo.atmel.com (newhermes [10.64.0.105])
	by newsmtp2.atmel.com (8.9.3+Sun/8.9.1) with ESMTP id OAA18941
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 14:44:26 -0700 (PDT)
Received: from mmc.atmel.com (mail [10.127.240.34])
	by hermes.sjo.atmel.com (8.9.1b+Sun/8.9.1) with ESMTP id OAA25112
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 14:44:44 -0700 (PDT)
Received: from mmc.atmel.com (IDENT:swang@pc-33.mmc.atmel.com [10.127.240.163])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id RAA23512
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 17:51:34 -0400 (EDT)
Message-ID: <3B7AFD6B.C0891B97@mmc.atmel.com>
Date: Wed, 15 Aug 2001 17:53:31 -0500
From: Shuanglin Wang <swang@mmc.atmel.com>
Reply-To: swang@mmc.atmel.com
Organization: ATMEL MMC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-8smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: About booting malta board.
References: <20010810153944.89482.qmail@web13906.mail.yahoo.com>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I try to install the Linux on the Malta board. In the big-endian mode, it
works fine. But in the little-endian mode, the kernel just displayed
"LINUX started..." and then deadlock.  Does anybody can help  me solve the
problem ?

I guess the system maybe failed to create an initial console for displaying
messages to me?

Thanks,

--Shuanglin
