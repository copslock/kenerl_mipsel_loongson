Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34Cpa816006
	for linux-mips-outgoing; Wed, 4 Apr 2001 05:51:36 -0700
Received: from haliga.physik.tu-cottbus.de (haliga.physik.TU-Cottbus.De [141.43.75.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34CpYM16002
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 05:51:34 -0700
Received: by haliga.physik.tu-cottbus.de (Postfix, from userid 7215)
	id B01E68D93; Wed,  4 Apr 2001 14:51:29 +0200 (MET DST)
Date: Wed, 4 Apr 2001 14:51:28 +0200
To: linux-mips@oss.sgi.com
Subject: Re: sgiwd93 multiple disk problem
Message-ID: <20010404145128.A28922@physik.tu-cottbus.de>
Mail-Followup-To: heinold@physik.tu-cottbus.de,
	linux-mips@oss.sgi.com
References: <20010403174749.B4135@paradigm.rfc822.org> <20010403190458.C4135@paradigm.rfc822.org> <20010404131810.D25870@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010404131810.D25870@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Apr 04, 2001 at 01:18:10PM +0200
From: heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 01:18:10PM +0200, Florian Lohoff wrote:
> On Tue, Apr 03, 2001 at 07:04:58PM +0200, Florian Lohoff wrote:
> > On Tue, Apr 03, 2001 at 05:47:49PM +0200, Florian Lohoff wrote:
> > > Hi,
> > > i guess Ryan Murray has stumbled over the multiple disk problem
> > > on one of my machines again - I would like to fix that bug if i am able to.
> 
> Another one - After speaking to a couple of people on IRC i got to
> the conclusion that we are possibly dealing with 3 different problems.
> 
> I/Ryan have/has seen data corruption. The files md5sum gets broken the fses
> Metadata stays intact what an fsck shows.
> 
> Spock and Ian see "I/O" errors when copying a sourcetree from
> a disk to a different one (even on the same bus) with "cp -dR".
> Afterwards the filesystems metadata is corrupt.
> 
> Karel sees complete hangs on copy
> 

Hi,

I saw cp hanged as I want copy the kernel-tree between two disks
on resume(the indgio2 from flo, which is online).

-- 

Henning
