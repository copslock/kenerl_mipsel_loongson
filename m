Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA79850 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 Jan 1999 16:23:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA77085
	for linux-list;
	Sun, 3 Jan 1999 16:22:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA03498
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 3 Jan 1999 16:22:02 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06243
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 Jan 1999 16:22:01 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA06435;
	Sun, 3 Jan 1999 19:23:58 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 3 Jan 1999 19:23:58 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "[Eazy|E]" <sniper@kibla.org>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: SGI Linux HardHat 5.1 Install problems
In-Reply-To: <Pine.LNX.3.95.990103235047.1494A-100000@server.kibla.org>
Message-ID: <Pine.LNX.3.96.990103192148.6009A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 3 Jan 1999, [Eazy|E] wrote:
> VFS: Mounted root (nfs filesysmte).
> Adv: done running setup()
> Freeing unused kernel memory: 44k freed
> Warning: unable to open an initial console.
> 
> I'm using SGI Indy R3000 and I dont have a clue what's going wrong, can
> You help me please with that, because I'd really like to have Linux
> running on my SGI which is in school and I admin it.

Alright.  The first thing is that it can't possibly be an R3000 CPU, it's
an R4x00 or R5000.

The 'unable to open console' means that the kernel doesn't have access to
a root filesystem; that's likely a problem with your NFS server. 

How do you have your root install fs exported?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
