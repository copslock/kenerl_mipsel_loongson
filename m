Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 16:12:54 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18651 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123253AbSJPOMx>; Wed, 16 Oct 2002 16:12:53 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA22148;
	Wed, 16 Oct 2002 16:13:07 +0200 (MET DST)
Date: Wed, 16 Oct 2002 16:13:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alexandre Oliva <aoliva@redhat.com>
cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <ork7kiy083.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.GSO.3.96.1021016160858.19873D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 16 Oct 2002, Alexandre Oliva wrote:

> >  Too bad.  But the marking could get disabled if ".set nomacro" was on for
> > a branch, couldn't it?
> 
> Err...  Yes, indeed, this is already the case, now that I think of
> it.  Only when the branch is a relaxation candidate does it become the
> end of a variable-sized frag.  Branches within nomacro sections are
> not relaxed in the current implementation, so we handle them just as
> before.

 OK then.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
