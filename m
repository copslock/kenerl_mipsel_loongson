Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jun 2004 20:38:45 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:37089 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225743AbUFWTil>; Wed, 23 Jun 2004 20:38:41 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D3536474C5; Wed, 23 Jun 2004 21:38:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id C78C044CD0; Wed, 23 Jun 2004 21:38:32 +0200 (CEST)
Date: Wed, 23 Jun 2004 21:38:32 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Daney <ddaney@avtrex.com>
Cc: cgd@broadcom.com, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <40D9DA3E.3040107@avtrex.com>
Message-ID: <Pine.LNX.4.55.0406232136580.11815@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
 <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl> <40D9DA3E.3040107@avtrex.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 23 Jun 2004, David Daney wrote:

> Just out of curiosity, do you propose this patch in lieu of the patch to 
> Linux's traps.c?
> 
> Or would you do both?

 Both.

> It seems like both would be best, as there are already "broken" binutils 
> floating around out there.

 And broken binaries.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
