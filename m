Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LKPTu29663
	for linux-mips-outgoing; Tue, 21 Aug 2001 13:25:29 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LKPR929660
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 13:25:27 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA13898;
	Tue, 21 Aug 2001 13:25:18 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA10483;
	Tue, 21 Aug 2001 13:25:17 -0700 (PDT)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7LKNta13094;
	Tue, 21 Aug 2001 22:23:56 +0200 (MEST)
Message-ID: <3B82C410.5E82AD6D@mips.com>
Date: Tue, 21 Aug 2001 22:26:56 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: swang@mmc.atmel.com
CC: linux-mips@oss.sgi.com
Subject: Re: Question on porting Linux...
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net> <001201c12a29$57f3b660$8021690a@huawei.com> <20010821131721.F13302@dea.linux-mips.net> <3B827B7C.16A1C763@mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You are probably referring to the MIPS SEAD board, I have made a port for that board
now.
It runs with a small ramdisk, which basically only consist of a stand-alone shell
and a few simple commands like ls, etc...
So you can't do much with it, but you can make you own ramdisk, and just merge it in
with the kernel.
I will try to put an image on our FTP site
(ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/) tomorrow.

/Carsten

Shuanglin Wang wrote:

> Hi all,
>
> I'm working on porting Linux to a third-part board. I don't know where to start.
> Can anyone give me some tips?
> By the way, the board doesn't have PCI bus, Interrupt controller, and RTC.  Do
> you think it is possible to port Linux to it?  And how difficult will it be?
>
> A lot of thanks,
>
> --Shuanglin
