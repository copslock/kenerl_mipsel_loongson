Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 13:06:13 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56532 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJPLGM>; Wed, 16 Oct 2002 13:06:12 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA16489;
	Wed, 16 Oct 2002 13:06:30 +0200 (MET DST)
Date: Wed, 16 Oct 2002 13:06:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alexandre Oliva <aoliva@redhat.com>
cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <ork7kjqluf.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.GSO.3.96.1021016130338.14774E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 15 Oct 2002, Alexandre Oliva wrote:

> Except that, with the current implementation of branch relaxation,
> when you enable it, each branch will mark the end of a frag, so the
> assembler will be effectively unable to fill delay slots anyway, since
> it won't bring instructions from the previous frag to the beginning of
> the new frag.

 Too bad.  But the marking could get disabled if ".set nomacro" was on for
a branch, couldn't it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
