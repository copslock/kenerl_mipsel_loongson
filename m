Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2004 19:34:55 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:20689 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225781AbUFXSev>; Thu, 24 Jun 2004 19:34:51 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 84E3D475C0; Thu, 24 Jun 2004 20:34:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 794424622B; Thu, 24 Jun 2004 20:34:44 +0200 (CEST)
Date: Thu, 24 Jun 2004 20:34:44 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: cgd@broadcom.com, David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <87y8mdgryp.fsf@redhat.com>
Message-ID: <Pine.LNX.4.55.0406242031020.8569@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
 <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl> <87y8mdgryp.fsf@redhat.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 24 Jun 2004, Richard Sandiford wrote:

> >  Or should we get rid of the 20-bit "break" completely?  The two-argument
> > version provides the same functionality, although the 10-bit codes to be
> > used do not map to the 20-bit equivalent "optically" very well.  
> > Especially if decimal notation is used.
> 
> I notice no-one's really responded to this question yet.  FWIW, on gut
> instinct, I'd personally prefer to drop the 20-bit break than introduce
> a new, non-standard name for it.

 Well, this is essentially what the patch does.  Or do you mean: "drop it
and if anyone screams, consider an alternative?"  I'd find it acceptable,
actually, but it's not my opinion that really matters here.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
