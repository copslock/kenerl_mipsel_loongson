Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA72353 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 15:36:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA57601
	for linux-list;
	Wed, 17 Jun 1998 15:36:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA97462
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 15:36:18 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id PAA14817
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 15:36:15 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA24996; Wed, 17 Jun 1998 23:35:58 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0ymnOa-000aOnC; Thu, 18 Jun 98 23:43 BST
Message-Id: <m0ymnOa-000aOnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Stuff that needs to be done.
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 18 Jun 1998 23:43:04 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jun 17, 98 02:19:02 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> modutils
>      Easy, just need to package the functional modutils that's in
>      the CVS on linus.

What happened there. My 4.9.1 modutils built fine

> mawk
>     This dies on compile with floating point errors.

Those look like kernel problems

> mars-nwe
>      Architecture specific.

Forget it - its very very non portable.

> aout-libs
>      I'm not sure.

Not needed

> bin86
>      Too difficult to do.

The Red Hat supplied bin86 isnt portable. It'll build on mips and write
invalid code. Get the Dev86 kit for ELKS. That one is portable

> xdosemu
> dosemu
>       Emulate DOS on a MIPS?  Not right away.

0.99 has CPU emulation in progress. So "soon"

alan
