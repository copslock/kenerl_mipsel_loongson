Received:  by oss.sgi.com id <S553950AbRAPUF7>;
	Tue, 16 Jan 2001 12:05:59 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:38638 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553951AbRAPUFs>; Tue, 16 Jan 2001 12:05:48 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867057AbRAPUEo>; Tue, 16 Jan 2001 18:04:44 -0200
Date:	Tue, 16 Jan 2001 18:04:44 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116180444.C1379@bacchus.dhis.org>
References: <20010116172351.B1379@bacchus.dhis.org> <Pine.GSO.3.96.1010116204113.5546X-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116204113.5546X-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 08:47:20PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 08:47:20PM +0100, Maciej W. Rozycki wrote:

> > Indy kernels are linked to 0x88002000.
> 
>  Oh well, why can't it be done consistently in our linker script.  The
> script does ". = 0x80000000;" -- it's at least confusing, even if the
> "-Ttext" option has a priority (does it?).

It has; however the whole concept of how a linker script is interpreted
when used with -Ttext, -Tdata or -Tbss is undocumented.  It seems to be
working fine as long as the address passed to -Ttext is larger than the
address in the script, so the script is using the lowest possible
address which is KSEG0.

  Ralf
