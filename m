Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34BIKD11287
	for linux-mips-outgoing; Wed, 4 Apr 2001 04:18:20 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34BIIM11282
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 04:18:19 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5EC877F8; Wed,  4 Apr 2001 13:18:17 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A9F20F035; Wed,  4 Apr 2001 13:18:10 +0200 (CEST)
Date: Wed, 4 Apr 2001 13:18:10 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Re: sgiwd93 multiple disk problem
Message-ID: <20010404131810.D25870@paradigm.rfc822.org>
References: <20010403174749.B4135@paradigm.rfc822.org> <20010403190458.C4135@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403190458.C4135@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Apr 03, 2001 at 07:04:58PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 07:04:58PM +0200, Florian Lohoff wrote:
> On Tue, Apr 03, 2001 at 05:47:49PM +0200, Florian Lohoff wrote:
> > Hi,
> > i guess Ryan Murray has stumbled over the multiple disk problem
> > on one of my machines again - I would like to fix that bug if i am able to.

Another one - After speaking to a couple of people on IRC i got to
the conclusion that we are possibly dealing with 3 different problems.

I/Ryan have/has seen data corruption. The files md5sum gets broken the fses
Metadata stays intact what an fsck shows.

Spock and Ian see "I/O" errors when copying a sourcetree from
a disk to a different one (even on the same bus) with "cp -dR".
Afterwards the filesystems metadata is corrupt.

Karel sees complete hangs on copy

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
