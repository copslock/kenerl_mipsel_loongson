Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA29653 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 08:34:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA53002
	for linux-list;
	Mon, 22 Jun 1998 08:34:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA53552
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 08:33:58 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id IAA17943
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 08:33:52 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA28375;
	Mon, 22 Jun 1998 11:33:07 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 22 Jun 1998 11:33:07 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Leon Verrall <leon@reading.sgi.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@cthulhu.engr.sgi.com
Subject: Re: 5.1 installation fun & games...
In-Reply-To: <Pine.SGI.3.96.980622161123.20040A-100000@wintermute.reading.sgi.com>
Message-ID: <Pine.LNX.3.95.980622112953.26734B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 22 Jun 1998, Leon Verrall wrote:
> Ah, a chicken and egg thing. You can nfsroot an SG linux box as long as you
> have a linux box to do it from...

Assuming that people have an i386/Linux box kicking around may be an
invalid assumption.

The Real Solution to this is to get initrds working, so that you don't
have to have any other machine to boot from, just a local Irix filesystem. 
Leon, in time this will all be taken care of. 

I wonder how the initrd that the DEC MIPS folks are talking about works... 

- Alex
