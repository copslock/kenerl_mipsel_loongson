Received:  by oss.sgi.com id <S553775AbQKOUcK>;
	Wed, 15 Nov 2000 12:32:10 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53976 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553736AbQKOUby>;
	Wed, 15 Nov 2000 12:31:54 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA17243;
	Wed, 15 Nov 2000 21:31:41 +0100 (MET)
Date:   Wed, 15 Nov 2000 21:31:41 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
In-Reply-To: <3A12EF72.980C8E92@mvista.com>
Message-ID: <Pine.GSO.3.96.1001115211935.5687L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 15 Nov 2000, Jun Sun wrote:

> I did not doubt the non-zero value of k0.  I really doubted the
> approach: a userland primitive is based on non-documented,
> non-guarranteed kernel stack restoring code.  Once something changes in
> kernel, you will get really obscure bugs.

 We need not rely on a non-documented behaviour.  We may clobber k0
explicitly, e.g.:

#define RESTORE_SP_AND_RET			\
		.set	push;			\
		.set	noreorder;		\
		lw	k1, PT_EPC(sp);		\
		lw	sp, PT_R29(sp);		\
		nor	k0, zero, zero;		\
		jr	k1;			\
		 rfe;				\
		.set	pop

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
