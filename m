Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 15:19:58 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:52964 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225210AbTFMOTz>;
	Fri, 13 Jun 2003 15:19:55 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5DEJkpI014325;
	Fri, 13 Jun 2003 16:19:46 +0200 (MEST)
Date: Fri, 13 Jun 2003 16:19:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030613135835Z8225250-1272+2544@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0306131617210.13821-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 13 Jun 2003 ralf@linux-mips.org wrote:
> 	Consolidate all the MIPS PCI code in arch/mips/pci.

Is this really a good idea? You moved board-specific code (`everything related
to one board in a single dir') into one directory? So for a new port, you now
have to add a arch/mips/<board>/ directory, and add files to arch/mips/pci/.

I agree that extracting common parts and cleaning up the code is a good idea,
though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
