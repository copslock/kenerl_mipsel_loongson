Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 14:07:34 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14227 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225360AbTJBNHb>; Thu, 2 Oct 2003 14:07:31 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA15362;
	Thu, 2 Oct 2003 15:07:21 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 2 Oct 2003 15:07:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: linux-mips@linux-mips.org
Subject: Re: time(2) for mips64
In-Reply-To: <20031002.144508.122621824.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1031002150528.15189A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 2 Oct 2003, Atsushi Nemoto wrote:

> Should mips64 kernel support time(2) system call for n32/n64 ABI?

 time(2) is obsolete (by gettimeofday(2)) and should be removed for new
implementations.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
