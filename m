Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5RDZRY13798
	for linux-mips-outgoing; Wed, 27 Jun 2001 06:35:27 -0700
Received: from dea.waldorf-gmbh.de (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id f5RDZPV13794
	for <linux-mips@oss.sgi.com>; Wed, 27 Jun 2001 06:35:26 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5RDY1p02536;
	Wed, 27 Jun 2001 15:34:01 +0200
Date: Wed, 27 Jun 2001 15:34:01 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "John D. Davis" <johnd@Stanford.EDU>
Cc: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: I few questions
Message-ID: <20010627153401.A2241@bacchus.dhis.org>
References: <Pine.GSO.4.31.0106261114300.3423-100000@myth1.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0106261114300.3423-100000@myth1.Stanford.EDU>; from johnd@Stanford.EDU on Tue, Jun 26, 2001 at 11:20:33AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 26, 2001 at 11:20:33AM -0700, John D. Davis wrote:

> I have a few simple questions that I have been wondering about.  I am
> currently running the debian verison of Linux with 2.4.0 kernel on an
> Indy.
> 
> 1) What is the difference between the Redhat and debian verison of linux?
> Should I use one over the other for my Indy?

That's a mostly a question of your personal preference.

> 3) Is there something that is available to replace sash, another
> bootloader?

You don't need sash at all unless you want to boot a kernel from a XFS
filesystem.  You can write the kernel intot the volumeheader using either
the Linux or IRIX version of dvhtool or boot it from NFS.  If your
Indy has a very old PROM which doesn't accept ELF binaries you have to
convert it to ECOFF.

  Ralf
