Received:  by oss.sgi.com id <S553851AbRAPQsz>;
	Tue, 16 Jan 2001 08:48:55 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:17162 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553834AbRAPQsi>;
	Tue, 16 Jan 2001 08:48:38 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6C7957FE; Tue, 16 Jan 2001 17:48:26 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9B39EF597; Tue, 16 Jan 2001 17:49:05 +0100 (CET)
Date:   Tue, 16 Jan 2001 17:49:05 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116174905.D7327@paradigm.rfc822.org>
References: <20010116153618.A1347@paradigm.rfc822.org> <Pine.GSO.3.96.1010116162557.5546J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116162557.5546J-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 05:01:15PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 05:01:15PM +0100, Maciej W. Rozycki wrote:
> 
>  Meanwhile, could you please try to boot with "mem=0x07800000@0x08800000"
> command line option?  This will show if the non-contiguous memory is the
> problem or not -- you have a relatively small block at the beginning.
> 

Works

[...]
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0 root=/dev/sda2 mem=0x07800000@0x08800000
Calibrating system timer... 1250000 [250.00 MHz CPU]
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 124.51 BogoMIPS
Memory: 118480k/122880k available (1176k kernel code, 4408k reserved, 75k data, 56k init)
[...]

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
