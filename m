Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA679909 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Dec 1997 07:17:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA10554 for linux-list; Mon, 8 Dec 1997 07:13:18 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA10544 for <linux@cthulhu.engr.sgi.com>; Mon, 8 Dec 1997 07:13:08 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA01381
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Dec 1997 07:13:05 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id QAA06984;
	Mon, 8 Dec 1997 16:12:36 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA21744; Mon, 8 Dec 1997 16:12:35 +0100
Message-ID: <19971208161234.55761@thoma.uni-koblenz.de>
Date: Mon, 8 Dec 1997 16:12:34 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Baechle <ralf@mailhost.uni-koblenz.de>, linux@cthulhu.engr.sgi.com
Subject: Re: Uploads ...
References: <19971208150602.52582@brian.uni-koblenz.de> <m0xf4dp-0005FtC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0xf4dp-0005FtC@lightning.swansea.linux.org.uk>; from Alan Cox on Mon, Dec 08, 1997 at 02:58:36PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Dec 08, 1997 at 02:58:36PM +0000, Alan Cox wrote:
> >  - binutils (gcc dies during compile)
> 
> Build without gcc -O and it builds

Removing the 64bit targets from the binutils' configuration is probably
preferable as it will make the binutils quite a bit faster.  Nevertheless
I want this bug to be fixed - GCC 2.8 or not.

  Ralf
