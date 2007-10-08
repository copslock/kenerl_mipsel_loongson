Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 16:26:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:55987 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022468AbXJHP0Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 16:26:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l98FQPA7005456;
	Mon, 8 Oct 2007 16:26:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l98FQPU8005452;
	Mon, 8 Oct 2007 16:26:25 +0100
Date:	Mon, 8 Oct 2007 16:26:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071008152625.GB1317@linux-mips.org>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64.0710051102300.32066@anakin> <470A4673.30604@gmail.com> <Pine.LNX.4.64.0710081720550.1416@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710081720550.1416@anakin>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 08, 2007 at 05:21:56PM +0200, Geert Uytterhoeven wrote:

> > If for some platforms we could generate the TLB handlers at compile
> > time, we could do it for all platforms, specially if the handler only
> > depends on the cpu type, no ?
> 
> Can't you currently compile a kernel that run on e.g. all O2s,
> irrespective of the actual CPU type?

Sortof.  There are O2s with R5000, RM523x, RM7000, R10000 and R12000
processors.  Supporting all from a single kernel would be trivial if
the R1x000 processors were not such bitches in non-coherent systems,
so the latter are still unsupported, not even in special kernel configs.

  Ralf
