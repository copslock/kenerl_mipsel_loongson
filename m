Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 16:26:01 +0100 (BST)
Received: from p508B7959.dip.t-dialin.net ([IPv6:::ffff:80.139.121.89]:27078
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTDAP0A>; Tue, 1 Apr 2003 16:26:00 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h31FPFc17170;
	Tue, 1 Apr 2003 17:25:15 +0200
Date: Tue, 1 Apr 2003 17:25:15 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brian Murphy <brm@tt.dk>,
	"Neeraj Garg, Noida" <ngarg@noida.hcltech.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Linux-MIPS compilation
Message-ID: <20030401172515.A17111@linux-mips.org>
References: <3E899ABF.3070704@tt.dk> <Pine.GSO.4.21.0304011657130.23134-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0304011657130.23134-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Apr 01, 2003 at 04:58:43PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2003 at 04:58:43PM +0200, Geert Uytterhoeven wrote:

> Nope, I actually tried it yesterday with a 3.2.2. mips-elf-gcc I had lying
> around from some other project, and it complained about the missing __linux__
> and _MIPS_SZLONG.

mips-elf is not mips-linux.

  Ralf
