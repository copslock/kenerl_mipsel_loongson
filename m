Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA471512 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Jan 1998 16:46:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA28892 for linux-list; Sun, 18 Jan 1998 16:43:29 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA28874 for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 16:43:14 -0800
Received: from netexpress.net (shamu.netexpress.net [206.65.64.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA00156
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 16:43:09 -0800
	env-from (drachen@netexpress.net)
Received: from netexpress.net (flexgen-17.netexpress.net [206.65.65.146])
	by netexpress.net (8.8.7/8.8.5) with ESMTP id SAA17852;
	Sun, 18 Jan 1998 18:42:45 -0600
Message-ID: <34C2A186.32EF7CFF@netexpress.net>
Date: Sun, 18 Jan 1998 18:42:46 -0600
From: David Hinkle <drachen@netexpress.net>
X-Mailer: Mozilla 4.04 [en] (Win95; I)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: My NEC VR4000's
References: <m0xtzBj-0005FsC@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Oh?  What is bugtraq?

Alan Cox wrote:

> > password....  Bye the way... Is there an easier way to clear the root
> > password?    And does anybody know what filesystem IRIX uses?
>
> If its running Irix < 6.4 then read bugtraq archives for about 100,000 ways
> to break root on your machine  8)
>
> The best general scheme on a remote box is to stuff the disk into a machine
> and without mounting it replace any disk block starting root:........:dfgkd
> with your own password string.
