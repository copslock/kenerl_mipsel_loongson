Received:  by oss.sgi.com id <S42246AbQGIXAW>;
	Sun, 9 Jul 2000 16:00:22 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:40199 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42185AbQGIW76>;
	Sun, 9 Jul 2000 15:59:58 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C31DA938; Mon, 10 Jul 2000 01:00:05 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id BE36D8F73; Mon, 10 Jul 2000 00:59:54 +0200 (CEST)
Date:   Mon, 10 Jul 2000 00:59:54 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Bryan Manternach <smash@sgi.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "J. Scott Kasten" <jsk@tetracon-eng.net>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Kernel boot tips.
Message-ID: <20000710005954.D968@paradigm.rfc822.org>
References: <Pine.SGI.4.10.10007070952190.6663-100000@thor.tetracon-eng.net> <20000709062927.A5609@bacchus.dhis.org> <3968FDE8.3443ED5@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3968FDE8.3443ED5@sgi.com>; from smash@sgi.com on Sun, Jul 09, 2000 at 03:34:17PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jul 09, 2000 at 03:34:17PM -0700, Bryan Manternach wrote:
> A fourth means is to change the nvram to boot the file you want.
> Leave /unix there,and call your linux kernel something like /linux2.2.0
> and change the "kernname" nvram.
> 
> kernname=pci(0)scsi(0)disk(2)rdisk(0)partition(0)/unix
> becomes

The problem with the nvram vars is the non-availability on
the Indigo2 which is not capable of storing arbitrary vars
or arbitrary content in existing vars.

I would prefer a "SILO" the Sparc Linux LOader which is capable
of reading an ext2 filesystem, getting its config from there
and loading the kernel from an ext2.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
     "If you're not having fun right now, you're wasting your time."
