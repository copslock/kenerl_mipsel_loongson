Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JBDKnC015384
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 04:13:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JBDKE8015383
	for linux-mips-outgoing; Wed, 19 Jun 2002 04:13:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-69.ka.dial.de.ignite.net [62.180.196.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JBDEnC015380
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 04:13:16 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5JBDlW23563;
	Wed, 19 Jun 2002 13:13:47 +0200
Date: Wed, 19 Jun 2002 13:13:47 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Justin Carlson <justin@cs.cmu.edu>, linux-mips@oss.sgi.com
Subject: Re: 64-bit kernel
Message-ID: <20020619131347.A23495@dea.linux-mips.net>
References: <3D0F28AE.7B0D822B@mips.com> <1024416198.1166.1.camel@xyzzy.rlson.org> <20020619113244.B22048@dea.linux-mips.net> <3D106601.2347EECC@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D106601.2347EECC@mips.com>; from carstenl@mips.com on Wed, Jun 19, 2002 at 01:07:46PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 19, 2002 at 01:07:46PM +0200, Carsten Langgaard wrote:

> I'm trying to compile glibc natively using my 64-bit kernel, but it fails with
> the following message:
> 
> Out of Memory: Killed process 641 (qmgr).
> Out of Memory: Killed process 642 (tlsmgr).
> Out of Memory: Killed process 378 (portmap).
> Out of Memory: Killed process 9363 (cc1).
> Out of Memory: Killed process 9363 (cc1).
> 
> So there may be a memory leak problem in 64-bit kernel.
> Has anyone seen this ?

No.  The entire Redhat 7.0 stuff I built was done exclusivly on a 64-bit
kernel (with 2GB RAM however ...) and no such problem ever, even after
long uptimes.

  Ralf
