Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 17:30:14 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.199]:30523 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8135891AbVKHR3y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2005 17:29:54 +0000
Received: by nproxy.gmail.com with SMTP id l36so200011nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 09:31:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uFXdSiwcEiarq+C3uG4X0F8afpVDgA9S9XFA/aCI7sH1SnLhzAb7lJgc+IsRndeFaEs93tth+bwcUSVKelPf8186Bkf2RL5JzfeHwymau+uzMLx1KNjkOrSLBLZkAjCpWjdsMUUjI+bWPAi/rUfHIfO63F66k4Qf4O0uSBLynrc=
Received: by 10.48.234.16 with SMTP id g16mr2894993nfh;
        Tue, 08 Nov 2005 09:31:13 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id p45sm3501590nfa.2005.11.08.09.31.11;
        Tue, 08 Nov 2005 09:31:13 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Tue,  8 Nov 2005 20:44:40 +0300 (MSK)
Date:	Tue, 8 Nov 2005 20:44:37 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Andrew Morton <akpm@osdl.org>,
	Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] arch/mips/au1000/common/usbdev.c: don't concatenate __FUNCTION__ with strings
Message-ID: <20051108174437.GB7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Clemens Buchacher <drizzd@aon.at>

It's deprecated. Use "%s", __FUNCTION__ instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/arch/mips/au1000/common/usbdev.c
===================================================================
--- linux-kj.orig/arch/mips/au1000/common/usbdev.c	2005-11-08 12:33:24.000000000 +0300
+++ linux-kj/arch/mips/au1000/common/usbdev.c	2005-11-08 13:10:41.000000000 +0300
@@ -348,7 +348,7 @@ endpoint_stall(endpoint_t * ep)
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("%s", __FUNCTION__);
 
 	cs = au_readl(ep->reg->ctrl_stat) | USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
@@ -360,7 +360,7 @@ endpoint_unstall(endpoint_t * ep)
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("%s", __FUNCTION__);
 
 	cs = au_readl(ep->reg->ctrl_stat) & ~USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
