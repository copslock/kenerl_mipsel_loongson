Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 14:58:11 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:63195 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225344AbTJ0O6H>;
	Mon, 27 Oct 2003 14:58:07 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1AE8ol-00070b-OX; Mon, 27 Oct 2003 09:58:03 -0500
Date: Mon, 27 Oct 2003 09:58:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Relocation errors
Message-ID: <20031027145803.GA26911@nevyn.them.org>
References: <Pine.GSO.4.44.0310270852380.19642-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310270852380.19642-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2003 at 08:55:19AM -0500, David Kesselring wrote:
> I'm getting the error "Unhandled relocation of type xx" on insmod. Are the
> "types" documented somewhere? I am I correct that these "types" are
> architecture specific?

Yes.  Try an ELF specification - there's a MIPS processor supplement
(psABI) floating around.  What's the "xx"?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
