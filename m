Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J9WGnC013576
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 02:32:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J9WGQg013575
	for linux-mips-outgoing; Wed, 19 Jun 2002 02:32:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-131.ka.dial.de.ignite.net [62.180.196.131])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J9WBnC013572
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 02:32:12 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5J9Wii22209;
	Wed, 19 Jun 2002 11:32:44 +0200
Date: Wed, 19 Jun 2002 11:32:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Justin Carlson <justin@cs.cmu.edu>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: 64-bit kernel
Message-ID: <20020619113244.B22048@dea.linux-mips.net>
References: <3D0F28AE.7B0D822B@mips.com> <1024416198.1166.1.camel@xyzzy.rlson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1024416198.1166.1.camel@xyzzy.rlson.org>; from justin@cs.cmu.edu on Tue, Jun 18, 2002 at 09:03:18AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 18, 2002 at 09:03:18AM -0700, Justin Carlson wrote:

> On Tue, 2002-06-18 at 05:33, Carsten Langgaard wrote:
> > I don't know if anymore has a interest in the 64-bit kernel, but I just
> > found this bug (see patch below).
> > It would be nice to know, how many are interested in the 64-bit kernel
> > and who actually got something running.
> > So please rise you voice.
> 
> Been running 64-bit stuff here, but nothing even remotely fpu intensive.
> It's quite possible we'd never run into this case.

At this time probably most 64-bit kernels are running on a certain 64-bit
CPU with it's hardware fp disabled so nobody ever saw this one.

  Ralf
