Received:  by oss.sgi.com id <S42259AbQIZWs1>;
	Tue, 26 Sep 2000 15:48:27 -0700
Received: from u-146.karlsruhe.ipdial.viaginterkom.de ([62.180.10.146]:16137
        "EHLO u-146.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42229AbQIZWsI>; Tue, 26 Sep 2000 15:48:08 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869537AbQIZWrX>;
        Wed, 27 Sep 2000 00:47:23 +0200
Date:   Wed, 27 Sep 2000 00:47:22 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000927004722.B8644@bacchus.dhis.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org> <39D05E8B.A7F4A2D9@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39D05E8B.A7F4A2D9@niisi.msk.ru>; from raiko@niisi.msk.ru on Tue, Sep 26, 2000 at 12:30:03PM +0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 12:30:03PM +0400, Gleb O. Raiko wrote:

> BTW, what should we use as system headers with glibc nowadays ? Should
> it be old HardHat kernel-headers-2.1.100 or newer 2.2.x ?

Definately not the old hardhat kernel headers.  I'm using 2.2 header and
recommend doing the same for best success with packages for current
distributions based on this kernel.  Building some packages may actually
require a newer version but in general the lastest 2.2 headers are the
best.

> > I week of CPU time on an Origin building packages:  No problems ...  I'm
> > actually fairly close to get a RH 6.2 built - as far as that is possible
> > with glibc 2.0.
> 
> Do you have the packages somewhere on the net ? I am personally
> interested in disk packages (fdisk, msdostools &co.) and the packages
> required in order to run 2.2 kernels. Old HardHat cfdisk, for example,
> seems to create partitions in the big endian format. At least, the rest
> see garbage after cfdisk creates a partition table.

I've got a hacked utils-linux package, I think it's in the redhat-6.0
packages that are on oss.  I don't really intend to upload all the stuff
to oss, they're just a big test for the changed compile environment which
I'm using, that is binutils-current and gcc-current.  Before I even fiddle
with stuff like glibc 2.2 etc. I want to know that the tools are reasonably
solid.  So far they seem to be good after applying a few minor but essential
patches.  Still need to test building a kernel.

  Ralf
