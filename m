Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:26:36 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:5132
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225951AbUDXI0f>; Sat, 24 Apr 2004 09:26:35 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BHIUb-0004NQ-00
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 10:26:33 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BHIUb-0003HK-00
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 10:26:33 +0200
Date: Sat, 24 Apr 2004 10:26:33 +0200
To: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424082633.GQ22147@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040424081405.GA26165@linux-mips.org> <Pine.GSO.4.10.10404241015150.15622-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404241015150.15622-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek wrote:
> > The first kernel was built with the stock Makefile; the second was modified
> > to use 64-bit ELF using gcc 2.95.4 / binutils 2.13.2.1.  So I'd call those
> > 817559 bytes kernel obesity ;)
> 
> Yeah, true. It's really appalling. Make it a config option then, default
> 'n'. I will set it to 'y' for SGI_IP30. The Octane firmware has no
> problems booting ELF64 (don't know about ELF32 though).

The IP28 firmware refuses to boot ELF32.


Thiemo
