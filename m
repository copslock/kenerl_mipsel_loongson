Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Apr 2004 12:50:26 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:23230 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224991AbUDSLuZ>; Mon, 19 Apr 2004 12:50:25 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id C516A4AD2E; Mon, 19 Apr 2004 13:50:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B157047855; Mon, 19 Apr 2004 13:50:13 +0200 (CEST)
Date: Mon, 19 Apr 2004 13:50:13 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: "Bradley D. LaRonde" <brad@laronde.org>, linux-mips@linux-mips.org,
	Eric Christopher <echristo@redhat.com>,
	Daniel Jacobowitz <dan@debian.org>
Subject: Re: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" intime.c
In-Reply-To: <4081EA5F.5000802@realitydiluted.com>
Message-ID: <Pine.LNX.4.55.0404191344520.23098@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl>
 <20040412231309.GA702@linux-mips.org> <03f301c420e7$d8de2d70$8d01010a@prefect>
 <048e01c420f1$ad4ae3b0$8d01010a@prefect> <1081818125.19719.14.camel@dzur.sfbay.redhat.com>
 <04d501c420f3$6c836a30$8d01010a@prefect> <20040413010732.GA7560@nevyn.them.org>
 <04f501c420f4$5563f620$8d01010a@prefect> <053c01c420f5$ec230190$8d01010a@prefect>
 <Pine.LNX.4.55.0404131451200.15949@jurand.ds.pg.gda.pl>
 <4081EA5F.5000802@realitydiluted.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 17 Apr 2004, Steven J. Hill wrote:

> Works fine for gcc-3.1.1 and my Swarm board boots just fine with this
> change and it seems stable. I vote for you to go ahead and commit the
> fixes to CVS. Thanks Maciej.

 I'm worried more about 2.95.  And even if it works now, it may stop after
some changes, if the compiler decides it's safe to keep something in
"accum" across the asm.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
