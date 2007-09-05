Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 12:20:23 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:12247 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022655AbXIELUP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2007 12:20:15 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id EEB4EBAB72;
	Wed,  5 Sep 2007 13:11:22 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ISsn4-0007wZ-4C; Wed, 05 Sep 2007 12:11:22 +0100
Date:	Wed, 5 Sep 2007 12:11:22 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	bo y <byu1000@gmail.com>, linux-mips <linux-mips@linux-mips.org>,
	ralf@linux-mips.org
Subject: Re: tlbex.c
Message-ID: <20070905111121.GC9977@networkno.de>
References: <99ac6e0e0708270822w32f8a024gd18c5883c86c8713@mail.gmail.com> <Pine.LNX.4.64N.0708291302350.26167@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0708291302350.26167@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 27 Aug 2007, bo y wrote:
> 
> > Should the following instruction field masks to be 0x3f ?
> > 
> >    #define OP_MASK         0x2f
> >    #define FUNC_MASK       0x2f
> > 
> > I do not see OP_MASK is used but FUNC_MASK is used in the same file.
> 
>  Yes.  Send a patch.

Appended, please apply.


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4ec0964..9cb3964 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -78,7 +78,7 @@ enum fields
 	SET = 0x200
 };
 
-#define OP_MASK		0x2f
+#define OP_MASK		0x3f
 #define OP_SH		26
 #define RS_MASK		0x1f
 #define RS_SH		21
@@ -92,7 +92,7 @@ enum fields
 #define IMM_SH		0
 #define JIMM_MASK	0x3ffffff
 #define JIMM_SH		0
-#define FUNC_MASK	0x2f
+#define FUNC_MASK	0x3f
 #define FUNC_SH		0
 #define SET_MASK	0x7
 #define SET_SH		0
