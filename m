Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 00:29:19 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:3644
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225192AbUGSX3P>; Tue, 20 Jul 2004 00:29:15 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BmhZK-0008WO-00; Tue, 20 Jul 2004 01:29:14 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BmhZI-0002qd-00; Tue, 20 Jul 2004 01:29:12 +0200
Date: Tue, 20 Jul 2004 01:29:12 +0200
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: binutils@sources.redhat.com, cgd@broadcom.com, ddaney@avtrex.com,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@redhat.com>
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
Message-ID: <20040719232912.GB965@rembrandt.csv.ica.uni-stuttgart.de>
References: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com> <Pine.LNX.4.55.0407191612160.3667@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0407191612160.3667@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> opcodes/:
> 2004-07-19  Maciej W. Rozycki  <macro@linux-mips.org>
> 
> 	* mips-opc.c (mips_builtin_opcodes): Remove the MIPS32
> 	ISA-specific "break" encoding.
> 
> gas/testsuite/:
> 2004-07-19  Maciej W. Rozycki  <macro@linux-mips.org>
> 
> 	* gas/mips/mips32.s: Adjust for the unified "break" syntax.  Add 
> 	another "break" case.  Update the comment accordingly.
> 	* gas/mips/set-arch.s: Likewise.
> 	* gas/mips/mips32.d: Adjust for the new output.
> 	* gas/mips/set-arch.d: Likewise.
> 
>  OK to apply?

Ok.


Thiemo
