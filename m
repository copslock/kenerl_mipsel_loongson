Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA53635 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 12:49:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA98618
	for linux-list;
	Wed, 25 Nov 1998 12:49:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA91012;
	Wed, 25 Nov 1998 12:49:03 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06891; Wed, 25 Nov 1998 12:49:01 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id UAA01776; Wed, 25 Nov 1998 20:48:40 GMT
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0zimlz-0007U1C; Wed, 25 Nov 98 21:46 GMT
Message-Id: <m0zimlz-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: help offered
To: ariel@cthulhu.engr.sgi.com
Date: Wed, 25 Nov 1998 21:46:54 +0000 (GMT)
Cc: galibert@pobox.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199811252037.MAA37649@oz.engr.sgi.com> from "Ariel Faigon" at Nov 25, 98 12:37:36 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> :Linux 2.1.* is very preemtible, even if there are  stil some things to
> :do.

Umm

> :
> 
> Interesting.  Could you elaborate on:
> 
> 	0) What was changed in recent Linux kernels
> 	   to support preemtibility in kernel space?

Nothing

> 	1) Which "serious" (i.e not 'getpid') system calls are
> 	   now reentrant ?

signals, scheduling related stuff

> 	2) What still remains to be done so Linux can really
> 	   scale before it gets bottlenecked by kernel locks ?

Actually it scales fine to 4 CPUs for most stuff on Intel. The pieces that
dont scale are memory intensive and the intel hardware doesnt scale either 8)

But from a theoretical point of view the page cache, vm and fs layers
dont scale.

Alan
