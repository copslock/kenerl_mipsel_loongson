Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 14:15:01 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:52397 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225073AbTE0NO7>; Tue, 27 May 2003 14:14:59 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25379;
	Tue, 27 May 2003 15:15:33 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 27 May 2003 15:15:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <20030527054649.GA19562@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030527150418.24408B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 27 May 2003, Ralf Baechle wrote:

> >  Hmm, if the PC/AT keyboard translation is needed by other devices beside
> > pc_keyb.c, then why isn't the common part put into a separate file to be
> > used by all devices depending on this translation as needed?  I think
> > dummy_keyb.c should be kept plain and simple as it is now. 
> 
> You're right but for 2.4 this looks like an acceptable solution for now so
> I'm going to apply this until somebody comes up with a better solution.

 Hmm, as I've understood that's a 2.4-only problem as 2.5 has it solved
differently.  And I do think the translation really belong to the drivers
that use it -- why can't it be included with the USB keyboard driver or as
a library file?  Why an unrelated driver has to be cluttered? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
