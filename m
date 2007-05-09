Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 13:06:53 +0100 (BST)
Received: from assei1bl6.telenet-ops.be ([195.130.133.68]:44187 "EHLO
	assei1bl6.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20023079AbXEIMGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 May 2007 13:06:51 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by assei1bl6.telenet-ops.be (Postfix) with SMTP id 7755A22008D;
	Wed,  9 May 2007 14:06:50 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by assei1bl6.telenet-ops.be (Postfix) with ESMTP id 4F5BD220079;
	Wed,  9 May 2007 14:06:50 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l49C6nDi008195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 May 2007 14:06:49 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l49C6nT2008192;
	Wed, 9 May 2007 14:06:49 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 9 May 2007 14:06:49 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: PCI video card on SGI O2
In-Reply-To: <200705091212.32061.eckhardt@satorlaser.com>
Message-ID: <Pine.LNX.4.64.0705091406260.5466@anakin>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu> 
 <876473x0jx.wl@betelheise.deep.net>  <Pine.LNX.4.64.0705080920150.24717@anakin>
 <200705091212.32061.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 9 May 2007, Ulrich Eckhardt wrote:
> On Tuesday 08 May 2007 09:22, Geert Uytterhoeven wrote:
> > It's a pity the Millenium doesn't fit, as matroxfb is about the only
> > frame buffer device that can initialize a graphics card from scratch,
> > without help from the BIOS...
> 
> I'm not sure if this is the same thing you are referring to, but I have a G4 
> Mac Mini which has a Radeon 9200 chip. The autodetection does not find a BIOS 
> ROM (is that what you meant?) but it works nonetheless, both with FB and 
> X.org. From reading the sources, it seems that this is even normal, in 
> particular for embedded graphic chips as typically found in laptops.

Open Firmware in your Mac Mini has F-code to initialize the Radeon 9200.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
