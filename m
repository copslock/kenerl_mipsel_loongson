Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 23:46:59 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:1513 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225322AbUCQXq6>; Wed, 17 Mar 2004 23:46:58 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 0709D4B05E; Thu, 18 Mar 2004 00:46:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 8AC234AC7D; Thu, 18 Mar 2004 00:46:51 +0100 (CET)
Date: Thu, 18 Mar 2004 00:46:51 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
In-Reply-To: <4058DAE2.8000902@gentoo.org>
Message-ID: <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org>
 <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 17 Mar 2004, Kumba wrote:

> Hmm, so would removing the patch function as a temporary workaround 
> until the real problem is fixed, or not recommended (meaning unbootable 
> kernels till it's fixed)?

 A simpler workaround (no need to rebuild binutils) might be setting:

LOADADDR := 0x88010000

for CONFIG_SGI_IP22 in arch/mips/Makefile.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
