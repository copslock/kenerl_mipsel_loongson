Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA39493 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 13:56:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA30302
	for linux-list;
	Wed, 10 Feb 1999 13:55:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA32299
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Feb 1999 13:55:19 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA04468
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 13:55:15 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id QAA22472;
	Wed, 10 Feb 1999 16:58:25 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 10 Feb 1999 16:58:25 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Chris Chiapusio <chipper@llamas.net>
cc: linux@cthulhu.engr.sgi.com, Richard Hartensveld <richard@infopact.nl>
Subject: Re: Challange S question..
In-Reply-To: <Pine.LNX.4.05.9902101630540.769-100000@chipsworld.llamas.net>
Message-ID: <Pine.LNX.3.96.990210165646.26706F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 10 Feb 1999, Chris Chiapusio wrote:
> Adv: done running setup()
> Freeing unused kernel memory: 44k freed
> and freezes there.

Yup.  The thing is the machine's actually working well, but you don't have
the graphics console to show anything.  That kernel doesn't have the
ability to handle serial consoles. :(

I really need to rebuild a kernel for installation that includes R4400
support and serial console.  I just wish I could find a serial console
cable somewhere.

- Alex
-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
