Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2002 15:31:15 +0200 (CEST)
Received: from p508B7868.dip.t-dialin.net ([80.139.120.104]:5261 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122976AbSISNbP>; Thu, 19 Sep 2002 15:31:15 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8JDV1n17203;
	Thu, 19 Sep 2002 15:31:01 +0200
Date: Thu, 19 Sep 2002 15:31:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: memcpy
Message-ID: <20020919153101.A17133@linux-mips.org>
References: <3D805119.5A9E3C42@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D805119.5A9E3C42@mips.com>; from carstenl@mips.com on Thu, Sep 12, 2002 at 10:32:25AM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 12, 2002 at 10:32:25AM +0200, Carsten Langgaard wrote:

> I have found another bug in the 64-bit memcpy function, so I figured it
> was time to use the 32-bit version (as it's more or less are prepared
> for 64-bit).
> With a few fixes the memcpy.S file can now be shared between the 32-bit
> and 64-bit kernel (the only difference is the definition of USE_DOUBLE).
> 
> I have attached the patch for arch/mips/lib/memcpy.S and the full file
> for the arch/mips64/lib/memcpy.S

Will apply.

  Ralf

PS: Same please as to everybody else - always send patches, never send files.
    Even worse, tarballs.  Yet worse, compressed stuff.  All a waste of time.
