Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2003 12:51:28 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:53908 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225197AbTFRLvZ>; Wed, 18 Jun 2003 12:51:25 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA11490;
	Wed, 18 Jun 2003 13:52:19 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 18 Jun 2003 13:52:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ladislav Michl <ladis@linux-mips.org>,
	Juan Quintela <quintela@trasno.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <Pine.GSO.3.96.1030617175552.22214K-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1030618134958.10426A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Maciej W. Rozycki wrote:

> > More or less. The caveat is that console->write() is not called with a
> > NULL-terminated string, but with a pointer and a length.
> 
>  Well, I can't remember if the DEC's printf() supports "%<width>s", but
> even if it doesn't, we can use a helper local buffer.

 FYI, by the spec it does support the width modifier, but I can't verify
it at the run time right now.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
