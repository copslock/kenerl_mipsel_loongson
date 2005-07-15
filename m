Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 11:59:32 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:16834
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226652AbVGOK7N>; Fri, 15 Jul 2005 11:59:13 +0100
Received: from pD95299FB.dip0.t-ipconnect.de [217.82.153.251] (helo=gaspode.madsworld.lan)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1DtNvg3WSE-00066d; Fri, 15 Jul 2005 13:00:28 +0200
Received: from mad by gaspode.madsworld.lan with local (Exim 4.50)
	id 1DtNvZ-00046Z-Qy; Fri, 15 Jul 2005 13:00:21 +0200
Date:	Fri, 15 Jul 2005 13:00:21 +0200
From:	Markus Dahms <mad@automagically.de>
To:	Mikael Nousiainen <turja@mbnet.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: New VINO video drivers for Indy
Message-ID: <20050715110021.GA15740@gaspode.automagically.de>
References: <42D4BF49.4040907@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D4BF49.4040907@mbnet.fi>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:896705dcda322f33ae3752a7fdb3dc09
Return-Path: <mad@automagically.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mad@automagically.de
Precedence: bulk
X-list: linux-mips

Hello Mikael,

> I've released new drivers for SGI Indy's VINO video input (for 2.6 kernels).

That's what I've already waited for. Slowly 2.6.x should get usable for
SGI machines :).

> Please test the driver and report the results so that bugs
> (yes, I can promise there are lots of them :) can be squashed.

I only get a bla[nc]k image using the patched camsource or xawtv from
from Debian Sarge with my IndyCam[1] :(. With the old driver for
2.4.x I got some more results (striped, but at least an image...).
I hope you could give me some hints where to start debugging...

| SGI VINO driver version 0.0.1
| VINO with chip ID 11, revision 0 found
| Philips SAA7191 driver version 0.0.1
| SAA7191 initialized
| SGI IndyCam driver version 0.0.1
| IndyCam v1.0 detected
| IndyCam initialized

What I noticed, too:

* you should really include a directory in your package, I (most people?)
  did 'cd src/; tar zxvf vino-0.0.1.tar.gz' and screwed up my source
  directory a bit.
* (not so important) I cross-compile all kernel-related stuff. Although
  'make -C $MIPSKERNELDIR SUBDIRS=`pwd`' is not as difficult, there
  COULD be support for cross-compiling in the Makefile.

Markus

[1] yes, I opened the cover ;). channel was correct, too.

> 
> 
> 
> 
