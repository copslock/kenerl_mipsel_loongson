Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 17:52:38 +0100 (BST)
Received: from p508B586D.dip.t-dialin.net ([IPv6:::ffff:80.139.88.109]:31117
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225193AbTGWQwg>; Wed, 23 Jul 2003 17:52:36 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6NGqXpG006282;
	Wed, 23 Jul 2003 18:52:34 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6NGqWde006281;
	Wed, 23 Jul 2003 18:52:32 +0200
Date: Wed, 23 Jul 2003 18:52:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: odd link error
Message-ID: <20030723165231.GA5851@linux-mips.org>
References: <Pine.GSO.4.44.0307230844470.17973-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307230844470.17973-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 23, 2003 at 08:48:03AM -0400, David Kesselring wrote:

> I know my build for a custom board isn't right but it got through the
> compiles only to get this link error. Does anyone know what it might point
> to?

Seems the SEAD bits in your Makefile are incomplete, arch/mips64/Makefile
should contain this:

[...]
#
# MIPS SEAD board
#
ifdef CONFIG_MIPS_SEAD
LIBS            += arch/mips/mips-boards/sead/sead.o \
                   arch/mips/mips-boards/generic/mipsboards.o
SUBDIRS         += arch/mips/mips-boards/generic arch/mips/mips-boards/sead
LOADADDR        := 0x80100000
endif
[...]

  Ralf
