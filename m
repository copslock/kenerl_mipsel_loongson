Received:  by oss.sgi.com id <S42285AbQEaJWk>;
	Wed, 31 May 2000 02:22:40 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:42049 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42263AbQEaJWa>;
	Wed, 31 May 2000 02:22:30 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA22995; Wed, 31 May 2000 02:17:38 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA71027
	for linux-list;
	Wed, 31 May 2000 02:14:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA48620
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 31 May 2000 02:14:36 -0700 (PDT)
	mail_from (csr6702@grace.rit.edu)
Received: from mailout2-0.nyroc.rr.com (mailout2-0.nyroc.rr.com [24.92.226.121]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA01939
	for <linux@cthulhu.engr.sgi.com>; Wed, 31 May 2000 02:07:59 -0700 (PDT)
	mail_from (csr6702@grace.rit.edu)
Received: from hork (d185d0f95.rochester.rr.com [24.93.15.149])
	by mailout2-0.nyroc.rr.com (8.9.3/8.9.3) with ESMTP id FAA18746;
	Wed, 31 May 2000 05:01:58 -0400 (EDT)
Received: from molotov (helo=localhost)
	by hork with local-esmtp (Exim 3.12 #1 (Debian))
	id 12x3nD-000050-00; Wed, 31 May 2000 04:23:59 -0400
Date:   Wed, 31 May 2000 04:23:59 -0400 (EDT)
From:   Chris Ruvolo <csr6702@grace.rit.edu>
X-Sender: molotov@hork
To:     fisher@sgi.com
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Problems booting Indigo...
In-Reply-To: <200005310410.VAA00290@hollywood.engr.sgi.com>
Message-ID: <Pine.LNX.4.21.0005310417570.274-100000@hork>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, 30 May 2000, William Fisher wrote:

>	Ok, I looked at the ARCS prom code for the Indy series machine
>aka an IP22
>	in SGI hardware speak.
>
>This code is from the BSD 4.3 distribution with some minor additions to support
>one of the last RFC's which added a few more options to the tftp protocol.

>I looked at both tftp and tftpd and nowhere is there any checks for
>the UDP packet arriving on port 69. Are you sure this is the underlying
>cause of the problem? I didn't look at your packet trace in gory details.
>
>You can look at the stand BSD 4.X release for the nearly identical source
>code that is used in the SGI proms.

Bill,
	Thanks for looking this up for us.  The port 69 issue was
speculation on our part.  I've been talking with someone that has the boot
PROM working with tftp, and it doesn't use port 69 exclusively.  Unless
the tftp code changed with different PROM versions, I think we can rule
that out.

	Any other ideas?

Thanks,
Chris
