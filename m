Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA126590; Thu, 31 Jul 1997 11:35:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA09700 for linux-list; Thu, 31 Jul 1997 11:34:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA09637 for <linux@cthulhu.engr.sgi.com>; Thu, 31 Jul 1997 11:34:17 -0700
Received: from swan.ml.org (eerandy.swan.ac.uk [137.44.4.77]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA29185
	for <linux@cthulhu.engr.sgi.com>; Thu, 31 Jul 1997 11:34:14 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (surd [137.44.10.205]) by swan.ml.org (8.7.4/8.7.3) with SMTP id TAA07149; Thu, 31 Jul 1997 19:31:51 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0wu104-0005FiC; Thu, 31 Jul 97 20:35 BST
Message-Id: <m0wu104-0005FiC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: An update...
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 31 Jul 1997 20:35:04 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970724230351.22084H-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jul 24, 97 11:15:26 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> - My root partition isn't being mounted read/write.  I can't figure it
> out.  /proc/mounts does indicate that it's rw, and I'm sure the NFS export
> is setup correctly.

Are you remounting root after startup and do you have our export set not
to map root to nobody ?

(try mount -o remount,rw -n /)


Alan
