Received:  by oss.sgi.com id <S553769AbRBUMie>;
	Wed, 21 Feb 2001 04:38:34 -0800
Received: from u-18-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.18]:33776
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553719AbRBUMiV>; Wed, 21 Feb 2001 04:38:21 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1L6kcV07687;
	Wed, 21 Feb 2001 07:46:38 +0100
Date:   Wed, 21 Feb 2001 07:46:38 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     <nick@snowman.net>
Cc:     cgut@calpoly.edu, linux-mips@oss.sgi.com
Subject: Re: Linux on Origin 200 (newbie)
Message-ID: <20010221074638.B7335@bacchus.dhis.org>
References: <H0005e15069dcdd2@MHS> <Pine.LNX.4.21.0102202007480.19261-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102202007480.19261-100000@ns>; from nick@snowman.net on Tue, Feb 20, 2001 at 08:08:03PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 20, 2001 at 08:08:03PM -0500, nick@snowman.net wrote:

> Yes.  It may or may not work . It does not work on my O200.

Latest theory is that we have a problem which is related to different
versions of various chips of the system.  When it's actually running on
an Origin 200 / 2000 then it's also very reliable.

Aside of that the current list of open bugs for the Origin 200 / 2000 is:

 - we don't have FPU emulation code
 - the performance of the ioc3-eth driver is weak to say the least
 - ioc3-eth doesn't handle autonegotiation correctly
 - the binary compatibility code for running 32-bit apps is less than perfect.
 - we crash on systems with more than 64 processors.  Yes dudes, that's
   tested on real world hardware :-)

  Ralf
