Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA60084 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 12:16:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA44448
	for linux-list;
	Tue, 2 Feb 1999 12:15:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA39967
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 12:15:35 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08344; Tue, 2 Feb 1999 12:15:27 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id UAA20697; Tue, 2 Feb 1999 20:15:21 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m107n69-0007U1C; Tue, 2 Feb 99 21:11 GMT
Message-Id: <m107n69-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: weird HAL2
To: ulfc@bun.falkenberg.se (Ulf Carlsson)
Date: Tue, 2 Feb 1999 21:11:04 +0000 (GMT)
Cc: alambie@rock.csd.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <19990202205328.A1996@bun.falkenberg.se> from "Ulf Carlsson" at Feb 2, 99 08:53:28 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> This is exactly what I'm trying to do by first writing 0x0000 to isr, waiting
> some us, and then writing 0x0018. Then the card should be active and isr should
> IMHO contain 0x0018.

Stupid question but does

write 0x0010
wait 10uS
write 0x0018

work ?

(ie do you have to bring them out of reset card, then codec ?
