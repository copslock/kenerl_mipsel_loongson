Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LEFQO22235
	for linux-mips-outgoing; Tue, 21 Aug 2001 07:15:26 -0700
Received: from newsmtp2.atmel.com (newsmtp2.atmel.org [12.146.133.142])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LEFP922232
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 07:15:25 -0700
Received: from hermes.sjo.atmel.com (newhermes [10.64.0.105])
	by newsmtp2.atmel.com (8.9.3+Sun/8.9.1) with ESMTP id HAA12880
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 07:08:12 -0700 (PDT)
Received: from mmc.atmel.com (mail [10.127.240.34])
	by hermes.sjo.atmel.com (8.9.1b+Sun/8.9.1) with ESMTP id HAA05907
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 07:08:30 -0700 (PDT)
Received: from mmc.atmel.com (IDENT:swang@pc-33.mmc.atmel.com [10.127.240.163])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA16049
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 10:15:28 -0400 (EDT)
Message-ID: <3B827B7C.16A1C763@mmc.atmel.com>
Date: Tue, 21 Aug 2001 10:17:16 -0500
From: Shuanglin Wang <swang@mmc.atmel.com>
Reply-To: swang@mmc.atmel.com
Organization: ATMEL MMC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-8smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Question on porting Linux...
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net> <001201c12a29$57f3b660$8021690a@huawei.com> <20010821131721.F13302@dea.linux-mips.net>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I'm working on porting Linux to a third-part board. I don't know where to start.
Can anyone give me some tips?
By the way, the board doesn't have PCI bus, Interrupt controller, and RTC.  Do
you think it is possible to port Linux to it?  And how difficult will it be?

A lot of thanks,

--Shuanglin
