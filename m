Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 22:28:35 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19128 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJOU2e>; Tue, 15 Oct 2002 22:28:34 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA24825;
	Tue, 15 Oct 2002 22:28:43 +0200 (MET DST)
Date: Tue, 15 Oct 2002 22:28:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Paul Koning <pkoning@equallogic.com>
cc: wilson@redhat.com, hjl@lucon.org, aoliva@redhat.com,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <15788.29802.865689.741487@pkoning.dev.equallogic.com>
Message-ID: <Pine.GSO.3.96.1021015221315.23692A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 15 Oct 2002, Paul Koning wrote:

>  Jim> them as soon as possible.  Gcc should emit .set
>  Jim> nomacro/noreorder/noat/etc at the begining of its assembly
>  Jim> output, and never turn them on.
> 
> Makes sense to me.  As an assembly language programmer, I do the same
> thing in handwritten code, for the same reasons.

 Hmm, how do you select right relocations that depend on the ABI selected? 
A common macro like "lw $2,foo" may expand in three different ways
depending on which one of "-mabi=<o32|n32|64>" is used and other three
ones for "-KPIC", plus possibly more depending on other options or "foo"
itself.  Good luck handling it with "ifdefs".

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
