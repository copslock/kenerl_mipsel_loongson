Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 20:55:05 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:49912 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225482AbSLSUzE>; Thu, 19 Dec 2002 20:55:04 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA10594;
	Thu, 19 Dec 2002 21:54:51 +0100 (MET)
Date: Thu, 19 Dec 2002 21:54:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]:
In-Reply-To: <m2smwtixsh.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021219215031.27339S-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 19 Dec 2002, Juan Quintela wrote:

>         - pte_val() returs a long, print it directly.
[...]
> -	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, (unsigned int) pte_val(page));
> +	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, pte_val(page));

 Well, I guess you need "%08lx" then.  For both formats, actually.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
