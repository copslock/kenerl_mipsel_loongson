Received:  by oss.sgi.com id <S42241AbQGIWRx>;
	Sun, 9 Jul 2000 15:17:53 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:63551 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42185AbQGIWRb>; Sun, 9 Jul 2000 15:17:31 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA07444; Sun, 9 Jul 2000 15:23:08 -0700 (PDT)
	mail_from (smash@sgi.com)
Received: from greywolf.engr.sgi.com (greywolf.engr.sgi.com [198.29.76.67])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA43260;
	Sun, 9 Jul 2000 15:17:20 -0700 (PDT)
	mail_from (smash@sgi.com)
Received: from sgi.com (localhost [127.0.0.1]) by greywolf.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA26575; Sun, 9 Jul 2000 15:34:17 -0700 (PDT)
Message-ID: <3968FDE8.3443ED5@sgi.com>
Date:   Sun, 09 Jul 2000 15:34:17 -0700
From:   Bryan Manternach <smash@sgi.com>
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "J. Scott Kasten" <jsk@tetracon-eng.net>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Kernel boot tips.
References: <Pine.SGI.4.10.10007070952190.6663-100000@thor.tetracon-eng.net> <20000709062927.A5609@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Fri, Jul 07, 2000 at 10:10:59AM -0300, J. Scott Kasten wrote:
>
> > I learned 3 slick booting tips for booting an Indy from disk without a
> > regular Linux boot loader that might be useful to some of the newbies.

A fourth means is to change the nvram to boot the file you want.
Leave /unix there,and call your linux kernel something like /linux2.2.0
and change the "kernname" nvram.

kernname=pci(0)scsi(0)disk(2)rdisk(0)partition(0)/unix
becomes

kernname=pci(0)scsi(0)disk(2)rdisk(0)partition(0)/linux2.2.0

This should work on the IRIX efs/xfs filesystem on the IRIX
partition.  Then you can create a script that resets the NVRAM
variable before reboot.

All we would need to make back and forth boots of IRIX/LINUX
is an "nvram" tool that runs under LInux.  (Which would be handy
for other porposes as well.


>
> >--
> THE USE OF EMAIL FOR THE TRANSMISSION OF UNSOLICITED COMMERICAL
> MATERIAL IS PROHIBITED UNDER FEDERAL LAW (47 USC 227). Violations may
> result in civil penalties and claims of $500.00 PER OCCURRENCE
> (47 USC 227[c]).  Commercial spam WILL be forwarded to postmasters.
