Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA87776 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 17:08:43 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA01767
	for linux-list;
	Wed, 10 Feb 1999 17:08:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA13552
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Feb 1999 17:08:01 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from perron-null.patser.net (9dyn136.breda.casema.net [195.96.116.136]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA07494
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 17:07:58 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (indigo2.patser.net [192.168.6.40])
	by perron-null.patser.net (8.9.0/8.9.0) with ESMTP id BAA11755;
	Thu, 11 Feb 1999 01:56:34 +0100
Message-ID: <36C22E71.729B3FE3@infopact.nl>
Date: Wed, 10 Feb 1999 17:12:17 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: Chris Chiapusio <chipper@llamas.net>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Challange S question..
References: <Pine.LNX.4.05.9902101630540.769-100000@chipsworld.llamas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Chris Chiapusio wrote:

> This is my first time working witha  net booting workstation and i'm
> having a problem w/ the install kernel booting on a Challenge S.
>
> I saw the mention in the mail archive and attempted to do as it instructs,
> but alas, I have had no success.
>
> the kernel says this on boot:
> SGI Zilog8530 serial driver version 1.00
> Keyboard timeout
> Keyboard timeout
> tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
> tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
> <snip>
> VFS: Mounted root (nfs filesystem).
> Adv: done running setup()
> Freeing unused kernel memory: 44k freed
>
> and freezes there.
>
> now what i've done regarding the instructions on the web site are:
> [root@outland dev]# pwd
> /usr/src/sgi/installfs/dev
> [root@outland dev]# ls -al tty* console*
> lrwxrwxrwx   1 root     root            5 Feb 10 16:16 console -> ttyS0
> lrwxrwxrwx   1 root     root            5 Feb 10 16:21 tty00 -> ttyS0
> lrwxrwxrwx   1 root     root            5 Feb 10 16:21 tty01 -> ttyS1
> crw-------   1 root     root       4,   1 May 11  1998 tty1
> crw-------   1 root     root       4,   2 May 11  1998 tty2
> crw-------   1 root     root       4,   3 May 11  1998 tty3
> crw-------   1 root     root       4,   4 May 11  1998 tty4
> crw-------   1 root     root       4,   5 May 11  1998 tty5
> crw-r--r--   1 root     root       4,  64 Feb 10 16:16 ttyS0
> crw-r--r--   1 root     root       4,  65 Feb 10 16:13 ttyS1
>

You should link /dev/ttyS1 to /dev/console and all will be fine.

Richard
