Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 17:58:01 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:26158
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225472AbTISQ54>; Fri, 19 Sep 2003 17:57:56 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A0OZo-0003IA-00; Fri, 19 Sep 2003 18:57:48 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A0OZn-0003e6-00; Fri, 19 Sep 2003 18:57:47 +0200
Date: Fri, 19 Sep 2003 18:57:47 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Eric Christopher <echristo@redhat.com>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030919165747.GI13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com> <Pine.GSO.3.96.1030919182314.9134K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030919182314.9134K-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> > two different things. I believe that for a 64-bit kernel either -mabi=64
> > or -mabi=n32 (-mlong64) are the right long term answer, part of Daniel's
> > problem was that his bootloader couldn't deal with ELF64.
> 
>  I've successfully converted ELF64 Linux images to o32 ELF32, with
> `objcopy' and then to COFF even, with `elf2ecoff' (provided with the Linux
> sources). The resulting COFF image used to work with the DECstation's
> firmware.  I suppose the intermediate ELF32 one would work with
> ELF-capable firmware, too.

I booted the ELF32 file via the delo bootloader and it worked.


Thiemo
