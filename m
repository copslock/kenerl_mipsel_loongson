Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 18:00:54 +0200 (CEST)
Received: from p508B7CE7.dip.t-dialin.net ([80.139.124.231]:37761 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122978AbSIBQAx>; Mon, 2 Sep 2002 18:00:53 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g82H0c828716;
	Mon, 2 Sep 2002 19:00:38 +0200
Date: Mon, 2 Sep 2002 19:00:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: PATCH: linux_2_4: add support for the Ocelot-G board
Message-ID: <20020902190038.F15618@linux-mips.org>
References: <NEBBLJGMNKKEEMNLHGAIKEJOCIAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIKEJOCIAA.mdharm@momenco.com>; from mdharm@momenco.com on Tue, Aug 27, 2002 at 04:00:51PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 27, 2002 at 04:00:51PM -0700, Matthew Dharm wrote:

> The attached two patches and small tar archive (I can't figure out how
> to make CVS do the equivalent of a diff -N) add support to the 2.4
> branch for the Ocelot-G board (RM7000 processor with GT-64240 bridge).
> 
> I've gone ahead and created an linux/arch/mips/momenco directory, as
> we've got another board almost ready to add to the repository (the
> Ocelot-C and -CS), and we've got concrete plans to port to our
> RM9000x2 board (Jaguar), which has at least a couple of varieties.  I
> figured getting all this organized under one directory would be wise.
> 
> Presuming this gets accepted, there are a few more patches in this
> series... some updates to the MTD probing address for these boards, as
> well as a new ethernet driver for the GT-64240 on-board ethernet.
> 
> Ralf, please apply these to the CVS repository.

As a note - most boards are now selectable for the 32-bit and 64-bit kernel.
For a board like the Ocelot having a 64-bit kernel certainly makes sense ...

   Ralf
