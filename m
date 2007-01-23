Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 18:31:40 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:42228 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20044768AbXAWSbe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 18:31:34 +0000
Received: by nf-out-0910.google.com with SMTP id l24so323393nfc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 10:30:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=N8YVcbn00gEAgmmvc86BmLnMgQmcIaPiHycYESwDw5ZnMdkEWN1IRKpZLJToeiYI+IObAMMC8lSc2Nxh9BMy9TpvMjoxmxyRFRxfIzX99ZDSAa4soVuiyrqXseccLVKJdiHxC3IT2ck9SPsEy+o6OfKspGVLW8n4IDbiK1tfulY=
Received: by 10.49.90.4 with SMTP id s4mr1547765nfl.1169577028623;
        Tue, 23 Jan 2007 10:30:28 -0800 (PST)
Received: from gmail.com ( [217.67.117.64])
        by mx.google.com with ESMTP id a23sm3516680nfc.2007.01.23.10.30.27;
        Tue, 23 Jan 2007 10:30:28 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Tue, 23 Jan 2007 21:30:20 +0300 (MSK)
Date:	Tue, 23 Jan 2007 21:30:14 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	akpm@osdl.org, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] mips: there is no __GNUC_MAJOR__
Message-ID: <20070123183014.GB5535@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

gcc major version number is in __GNUC__. As side effect fix checking with
sparse if sparse was built with gcc 4.1 and mips cross-compiler is 3.4.

sparse will inherit version 4.1, __GNUC__ won't be filtered from
"-dM -E -xc" output, sparse will pick only new major, effectively becoming
gcc version 3.1 which is unsupported.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -623,7 +623,8 @@ LDFLAGS			+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(CFLAGS) -dM -E -xc /dev/null | \
-	egrep -vw '__GNUC_(MAJOR|MINOR|PATCHLEVEL)__' | \
+	egrep -vw '__GNUC__' | \
+	egrep -vw '__GNUC_(MINOR|PATCHLEVEL)__' | \
 	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
 ifdef CONFIG_64BIT
 CHECKFLAGS		+= -m64
