Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 14:44:16 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:46825 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224901AbUGUNoL>; Wed, 21 Jul 2004 14:44:11 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id C30F947777; Wed, 21 Jul 2004 15:44:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B4B1B47485; Wed, 21 Jul 2004 15:44:03 +0200 (CEST)
Date: Wed, 21 Jul 2004 15:44:03 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
Subject: Re: simple assembler program
In-Reply-To: <20040721065644.GI4690@lug-owl.de>
Message-ID: <Pine.LNX.4.55.0407211541370.17940@jurand.ds.pg.gda.pl>
References: <002701c46ee1$feeb7fc0$cc20bdd3@roman> <20040721065644.GI4690@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 21 Jul 2004, Jan-Benedict Glaw wrote:

> > #sde-as test.S -o testtest.S: Assembler messages:
> > test.S:9: Error: absolute expression required `li'
> > test.S:10: Error: absolute expression required `li'
> > 
> > When I eliminate #define and use just 'li $3, 1' and so on - everything is
> > compiled correctly. Where is my problem?
> 
> Assembler sources aren't commonly fed through a preprocessor, so your
> assembler just ignores the comments (your defines) and uses "a" and "b"
> as-is.

 However, they would be, based on the file name suffix, which is .S for
assembly to be preprocessed or .s for one not to, if fed to the assembler
via the gcc driver.

  Maciej
