Received:  by oss.sgi.com id <S305195AbQD1MuV>;
	Fri, 28 Apr 2000 05:50:21 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36405 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305175AbQD1MuK>; Fri, 28 Apr 2000 05:50:10 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA06899; Fri, 28 Apr 2000 05:54:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA94075
	for linux-list;
	Fri, 28 Apr 2000 05:43:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA63170;
	Fri, 28 Apr 2000 05:43:31 -0700 (PDT)
	mail_from (nop@nop.com)
Received: from chmls05.mediaone.net (ne.mediaone.net [24.128.1.70]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA07681; Fri, 28 Apr 2000 05:43:17 -0700 (PDT)
	mail_from (nop@nop.com)
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.252.183])
	by chmls05.mediaone.net (8.8.7/8.8.7) with SMTP id IAA10786;
	Fri, 28 Apr 2000 08:43:05 -0400 (EDT)
Message-ID: <22a801bfb10f$5d7c5b80$0a00000a@decoy>
From:   "Jay Carlson" <nop@nop.com>
To:     "Jay Carlson" <nop@place.org>, "Ralf Baechle" <ralf@oss.sgi.com>,
        "Andreas Jaeger" <aj@suse.de>
Cc:     "Jun Sun" <jsun@mvista.com>,
        "Ulf Carlsson" <ulfc@calypso.engr.sgi.com>,
        <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>
References: <Pine.LNX.4.21.0004241837420.1735-100000@calypso.engr.sgi.com> <3904ED75.209AFD22@mvista.com> <u8og6xi6p9.fsf@gromit.rhein-neckar.de> <20000426130603.E757@uni-koblenz.de> <228c01bfb107$fb22c2f0$0a00000a@decoy>
Subject: Re: failed to compile glibc 2.1.2 - BFD_RELOC_16_PCREL_S2 problem
Date:   Fri, 28 Apr 2000 08:43:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I wrote:

> 2.0 may still be the better choice on very space-constrained platforms
until
> there are good options for reducing the size of 2.2.  I mean, 2.2 is not
> huge, but on devices with 2M non-volatile store *total*, it's an obvious
> target.

To which I should add: I am very grateful for the work on 2.2.  It needs to
be done.  Many people will benefit from it, including me.  Great thanks to
Andreas!

The problems with code size are not Andreas's fault... :-)

Jay
