Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34BIRt11301
	for linux-mips-outgoing; Wed, 4 Apr 2001 04:18:27 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34BIIM11281
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 04:18:19 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 409847F7; Wed,  4 Apr 2001 13:18:17 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 337B0F035; Wed,  4 Apr 2001 13:02:26 +0200 (CEST)
Date: Wed, 4 Apr 2001 13:02:26 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010404130226.C25870@paradigm.rfc822.org>
References: <20010404120211.C11161@paradigm.rfc822.org> <Pine.GSO.4.10.10104041213260.17324-100000@escobaria.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.10.10104041213260.17324-100000@escobaria.sonytel.be>; from Geert.Uytterhoeven@sonycom.com on Wed, Apr 04, 2001 at 12:15:59PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 12:15:59PM +0200, Geert Uytterhoeven wrote:
> > We already had the discussion on parts of that implementation. Honestly - 
> > I dont like the stuff - Rolling out mips packages as "noarch" is
> > simply broken - And the argument that one would want to install
> > it on a i386 nfs root is simply an excuse for a broken rpm or missing
> > installer.
> 
> What about modifying dpkg so it can install the lib and include parts of
> non-native packages for arch $ARCH in /usr/$ARCH-linux/? Thay way you can
> easily install *-dev packages for cross-development.

Even with rpm or dpkg different arch packages can be extracted and installed.
On rpm you could do it with "rpm2cpio" or with dpkg you could do it
with "ar x <*.deb>" and then extract the data.tar.gz

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
