Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 13:47:01 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:18334 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDNMrA>; Mon, 14 Apr 2003 13:47:00 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA25600;
	Mon, 14 Apr 2003 14:47:26 +0200 (MET DST)
Date: Mon, 14 Apr 2003 14:47:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: ralf@linux-mips.org, nemoto@toshiba-tops.co.jp,
	linux-mips@linux-mips.org
Subject: Re: End c-tx49.c's misserable existence
In-Reply-To: <20030414.152903.41628304.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030414144637.24742C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 14 Apr 2003, Atsushi Nemoto wrote:

> One more request.  Please enclose R4600_V1_HIT_CACHEOP_WAR and
> R4600_V2_HIT_CACHEOP_WAR with appropriate CONFIG_CPU_XXX.  I do not
> know what CPUs need this workaround... (at least TX49 does not need
> this)

 Obviously R4600 CPUs only. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
