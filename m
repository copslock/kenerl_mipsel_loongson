Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 15:31:47 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56238 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122123AbSKUObq>; Thu, 21 Nov 2002 15:31:46 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA27620;
	Thu, 21 Nov 2002 15:32:04 +0100 (MET)
Date: Thu, 21 Nov 2002 15:32:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [RFT] DEC SCSI driver clean-up
In-Reply-To: <Pine.GSO.4.21.0211211422360.18129-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1021121152229.24541C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 21 Nov 2002, Geert Uytterhoeven wrote:

> On Thu, 21 Nov 2002, Maciej W. Rozycki wrote:
> >  Following is a patch that removes SCp.have_data_in references -- the
> > member is initialized by the NCR53C9x.c core and by the dec_esp.c
> > front-end, but used by neither.  I believe it's some leftover cruft from
> > the days there were no front-ends -- it's actually used by esp.c.  There
> > are a few less significant clean-ups here and there as well. 
> 
> BTW, it's also used by jazz_esp, oktagon_esp, and sun3_exp (the last 2 are
> m68k).

 Yes, I know.  Of these jazz_esp.c and sun3x_esp.c actually make use of
SCp.have_data_in and properly initialize it.  OTOH, oktagon_esp.c
initializes the field similarly to the NCR53C9x.c core, but it doesn't use
it afterwards at all and should be fixed similarly.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
