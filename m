Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 16:29:47 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:33995 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225329AbSLRQ3q>; Wed, 18 Dec 2002 16:29:46 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA09232;
	Wed, 18 Dec 2002 17:29:50 +0100 (MET)
Date: Wed, 18 Dec 2002 17:29:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: config1 is only used by MIPS32 and MIPS64
In-Reply-To: <m2n0n4qezp.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021218172525.5977A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

>         subject told everything

 The code is broken anyway -- it shouldn't use #ifdef in the first place
-- that's what PRId is there for.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
