Received:  by oss.sgi.com id <S553876AbQJ3R6g>;
	Mon, 30 Oct 2000 09:58:36 -0800
Received: from tower.ti.com ([192.94.94.5]:37081 "EHLO tower.ti.com")
	by oss.sgi.com with ESMTP id <S553873AbQJ3R6a>;
	Mon, 30 Oct 2000 09:58:30 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by tower.ti.com (8.11.1/8.11.1) with ESMTP id e9UHwO921636;
	Mon, 30 Oct 2000 11:58:24 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA03260;
	Mon, 30 Oct 2000 11:58:23 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA03250;
	Mon, 30 Oct 2000 11:58:23 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id LAA18937;
	Mon, 30 Oct 2000 11:58:23 -0600 (CST)
Message-ID: <39FDB7DD.25FCEDE7@ti.com>
Date:   Mon, 30 Oct 2000 11:03:09 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: ATLAS board!
References: <39FC8D4C.16654639@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:

> Hello,
>
> I have an Atlas board and now I am struggling to setup a Linux on it. I
> have few questions
> 1. After I will install Linux on the board, it will function as a
> standalone computer ?

We have not used it as a stand-alone system here (only as a development
platform) but the board does have all the peripheral in's and out's to be
a stand-alone box.

>
> 2 Do I need Yamon after  installing Linux on it ?
>
> Thanks
> Nicu

There is BIOS type functionality in Yamon that is needed to be able to
boot Linux (Bootup, PCI enumeration, low level hardware initialization
etc). If you were to write your own boot-up and low-level startup routines
and then write an OS loader that could boot a kernel image from the drive,
then you could conceivably boot Linux on the box without Yamon.
