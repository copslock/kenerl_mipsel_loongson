Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 14:01:27 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:24492 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225344AbUDENB0>; Mon, 5 Apr 2004 14:01:26 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 251A0478A4; Mon,  5 Apr 2004 15:01:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 0E72E47831; Mon,  5 Apr 2004 15:01:20 +0200 (CEST)
Date: Mon, 5 Apr 2004 15:01:19 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] swarm-cs4297a: Support little-endian configuration
In-Reply-To: <20040405125436.GA2741@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.55.0404051457010.31851@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
 <20040405125436.GA2741@deprecation.cyrius.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 5 Apr 2004, Martin Michlmayr wrote:

> Are you using their boot loader (sibyl), and did you notice it has
> problems in little-endian?  (IF so, do you have patches?  ;-)  Also,
> have you been able to compile sibyl against a normal e2fslibs rather
> than their custom version?

 I boot kernels directly (a bit dissatisfied with no ELF64 support in CFE,
but that can be fixed, I suppose) over the network, so I can't help you
with your problems, sorry.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
