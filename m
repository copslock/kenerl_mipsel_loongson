Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FEK88d025557
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 07:20:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FEK8nf025555
	for linux-mips-outgoing; Mon, 15 Apr 2002 07:20:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FEK48d025542
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 07:20:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA23682;
	Mon, 15 Apr 2002 16:21:11 +0200 (MET DST)
Date: Mon, 15 Apr 2002 16:21:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@sgi.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped? 
In-Reply-To: <22260.1018660471@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.3.96.1020415161148.19735M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 13 Apr 2002, Keith Owens wrote:

> The rules for stripping a module are "unusual".  Some symbols have to
> be kept even if they are static, because even static symbols can be
> exported.  The combination of strip -g to remove all debugging data

 Hmm, that looks weird to me.  If exporting static symbols is permitted,
shouldn't the symbols be marked global by EXPORT_SYMBOL() then? 

 The following code seems to mark a static symbol global just fine:

static int test = 0; asm(".global test");

so there should be no problem with doing the same in EXPORT_SYMBOL().

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
