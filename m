Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32MVCK09728
	for linux-mips-outgoing; Mon, 2 Apr 2001 15:31:12 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32MVBM09725
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 15:31:11 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 62F947F8; Tue,  3 Apr 2001 00:31:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B57BAF035; Tue,  3 Apr 2001 00:30:59 +0200 (CEST)
Date: Tue, 3 Apr 2001 00:30:59 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010403003059.E25228@paradigm.rfc822.org>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <017801c0bbc3$78c706a0$0deca8c0@Ulysses>; from kevink@mips.com on Tue, Apr 03, 2001 at 12:22:48AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 12:22:48AM +0200, Kevin D. Kissell wrote:
> 
> I'm not sure exactly what you mean here.  That no one would
> consider using your Debian cross environment?  That no one

I am not building cross, i am not building the debian cross
toolchain. Just for completeness.

> would consider doing cross-development?   What part of it 
> seems to you to be a show-stopper?

A major problem get the thing in which the configure try to 
begin to build executables and guess on the behaviour of the
OS to run on. This ends to be a hack and reminds me on
"pre gnu configure" times where one had to deal
with hundrets of "config.h" or "os.h" files. 

If you are going to use anything like a package format
might it be "rpm" or "deb" the dependencies tend to be
utterly broken as the dependcies are guessed by stuff like
"ldd" output and friends.

If you have a 90Meg source tarball and build a 4Meg Ramdisk
for a Nino out of it. Fine. 

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
