Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34GG5j22954
	for linux-mips-outgoing; Wed, 4 Apr 2001 09:16:05 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34GG3M22945
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 09:16:04 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7A0A47F7; Wed,  4 Apr 2001 18:16:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 717F2EE85; Wed,  4 Apr 2001 18:05:38 +0200 (CEST)
Date: Wed, 4 Apr 2001 18:05:38 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   "\"MIPS/Linux List (SGI)\"" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010404180538.G25870@paradigm.rfc822.org>
References: <20010404120211.C11161@paradigm.rfc822.org> <E14klMh-0001kx-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14klMh-0001kx-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 04, 2001 at 12:22:16PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 12:22:16PM +0100, Alan Cox wrote:
> Or a flawed packaging tool. RPM allows you to force noarch and you can use it
> to get around this precise problem. Its also useful when you want to force
> an x86 package onto an Alpha with em86.
> 
> I find it hard to believe dpkg lacks such a feature.
> 

Just had a look - One can install them 

dpkg --force-architecture -i --root=/nfsexport

But i was arguing against compiling the packages as "noarch" not installing
them with noarch.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
