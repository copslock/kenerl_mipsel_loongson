Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LKYD129831
	for linux-mips-outgoing; Tue, 21 Aug 2001 13:34:13 -0700
Received: from newsmtp2.atmel.com (newsmtp2.atmel.com [12.146.133.142])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LKYC929828
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 13:34:12 -0700
Received: from hermes.sjo.atmel.com (newhermes [10.64.0.105])
	by newsmtp2.atmel.com (8.9.3+Sun/8.9.1) with ESMTP id NAA20672;
	Tue, 21 Aug 2001 13:26:59 -0700 (PDT)
Received: from mmc.atmel.com (mail [10.127.240.34])
	by hermes.sjo.atmel.com (8.9.1b+Sun/8.9.1) with ESMTP id NAA28809;
	Tue, 21 Aug 2001 13:27:17 -0700 (PDT)
Received: from mmc.atmel.com (IDENT:swang@pc-33.mmc.atmel.com [10.127.240.163])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id QAA19872;
	Tue, 21 Aug 2001 16:34:17 -0400 (EDT)
Message-ID: <3B82D443.4C9DBDBE@mmc.atmel.com>
Date: Tue, 21 Aug 2001 16:36:03 -0500
From: Shuanglin Wang <swang@mmc.atmel.com>
Reply-To: swang@mmc.atmel.com
Organization: ATMEL MMC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-8smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Question on porting Linux...
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net> <001201c12a29$57f3b660$8021690a@huawei.com> <20010821131721.F13302@dea.linux-mips.net> <3B827B7C.16A1C763@mmc.atmel.com> <3B82C410.5E82AD6D@mips.com>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> You are probably referring to the MIPS SEAD board, I have made a port for that board
> now.
> It runs with a small ramdisk, which basically only consist of a stand-alone shell
> and a few simple commands like ls, etc...
> So you can't do much with it, but you can make you own ramdisk, and just merge it in
> with the kernel.
> I will try to put an image on our FTP site
> (ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/) tomorrow.
>
> /Carsten
>

Yes, it is a MIPS SEAD-2 board. By the way, can I get the source code of the kernel
with SEAD-2 board support ?

>
