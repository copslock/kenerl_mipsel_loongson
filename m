Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 14:50:04 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:35579 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225294AbTDPNuD>; Wed, 16 Apr 2003 14:50:03 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA02253;
	Wed, 16 Apr 2003 15:46:54 +0200 (MET DST)
Date: Wed, 16 Apr 2003 15:46:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: kevink@mips.com, linux-mips@linux-mips.org, source@mvista.com
Subject: Re: wbflush() abuse for TOSHIBA_RBTX4927
In-Reply-To: <20030416.205256.63134579.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030416153600.2017A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Apr 2003, Atsushi Nemoto wrote:

> macro> I suppose that's unrelated, since I'm specifically referring to
> macro> the way the buffer is handled in the TOSHIBA_RBTX4927 code --
> macro> the __wbflush() backend is not invoked by wbflush() and calls
> macro> like mb() (used by portable drivers) unless the kernel is
> macro> configured in an unobvious way and then there is duplicate
> macro> "sync" (but maybe that's needed, thus my question among
> macro> others).
> 
> I suppose it's just because the code was written before
> CONFIG_CPU_HAS_SYNC was introduced.

 It doesn't look so -- it appeared in the tree only a few days ago and
CONFIG_CPU_HAS_SYNC is there for almost a year now.  Even if maintained
privately since before CONFIG_CPU_HAS_SYNC, there was a lot of time to get
it fixed before merging.

> AFAIK TX49's SYNC instruction correctly flushes the write buffer.

 That would be an overkill; we only need to enforce strong ordering here.

> No bc0f loop is required.

 But an external buffer may be attached to a TX49 core, IIRC, so if it is
the case for TOSHIBA_RBTX4927, it's obviously needed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
