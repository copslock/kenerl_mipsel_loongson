Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2003 13:23:02 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:40087 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTLVNXB>; Mon, 22 Dec 2003 13:23:01 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 6E4944AF7D; Mon, 22 Dec 2003 14:22:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 0BF3D4AE0D; Mon, 22 Dec 2003 14:22:55 +0100 (CET)
Date: Mon, 22 Dec 2003 14:22:55 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pete Popov <ppopov@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: defconfigs
In-Reply-To: <1072069822.1927.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.55.0312221420510.27237@jurand.ds.pg.gda.pl>
References: <1072069822.1927.9.camel@localhost.localdomain>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 21 Dec 2003, Pete Popov wrote:

> How about if I create an arch/mips/configs directory and move all
> defconfig files there?  I know we've talked about this in the past and I
> don't remember any good reasons for not doing it?

 Except the plain "defconfig" file wants to keep sitting in arch/mips to
be picked up by configuration scripts.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
