Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 16:50:35 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:16370 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225214AbTGUPu3>; Mon, 21 Jul 2003 16:50:29 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17133;
	Mon, 21 Jul 2003 17:50:10 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 21 Jul 2003 17:50:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <02a701c34f81$4f32ca50$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1030721172805.13489C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 21 Jul 2003, Kevin D. Kissell wrote:

> >  Any justifiable reason for getting rid of arch/mips64?
> 
> In my opinion, it should never have existed.  The vast majority
> of MIPS-specific kernel code can be identical for 32-bit and 64-bit
> versions of the architecture.  Creating arch/mips64 (as opposed
> to arch/mips/mips64 or Ralf's arch/mips/mm-64) caused duplication 
> of modules that then needed to be maintained in parallel - but which 
> often were not.

 Well, duplication is certainly undesireable, but is it the result of
separate arch/mips and arch/mips64 trees or is it a side effect only? 
These separate trees have an advantage of a clear distinction between
these architectures.  And arch/sparc vs arch/sparc64 were the first case
of such a split and they seem to feel quite well. 

 I'd rather keep arch/mips/{lib,mm} and arch/mips64/{lib,mm} where they
used to be and add, say, arch/mips/{lib,mm}-generic for common stuff. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
