Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 00:21:07 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:10904 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133893AbWG3XUs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 00:20:48 +0100
Received: from lagash (88-106-139-84.dynamic.dsl.as9105.com [88.106.139.84])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 51B2C44124; Mon, 31 Jul 2006 01:19:50 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G7KZ5-0005CB-LA; Mon, 31 Jul 2006 00:19:19 +0100
Date:	Mon, 31 Jul 2006 00:19:19 +0100
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, Roger Leigh <rleigh@debian.org>,
	380531-silent@bugs.debian.org
Subject: Re: Bug#380531: linux-2.6: mips and mipsel personality(2) support is broken
Message-ID: <20060730231919.GD15011@networkno.de>
References: <20060730183939.7119.48747.reportbug@hardknott.home.whinlatter.ukfsn.org> <20060730224137.GP17134@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730224137.GP17134@deprecation.cyrius.com>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> FYI, but report tht "mips and mipsel personality(2) support is broken"

This patch fixes sys_personality for the o32 emulation by
 a) killing the sign extension bits
 b) tighten the bitmask match for current->personality (like it is done
    for x86_64)


Thiemo


Signed-off-by:  Thiemo Seufer <ths@networkno.de>


--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -1053,7 +1053,9 @@ asmlinkage long sys32_newuname(struct ne
 asmlinkage int sys32_personality(unsigned long personality)
 {
 	int ret;
-	if (current->personality == PER_LINUX32 && personality == PER_LINUX)
+	personality &= 0xffffffff;
+	if (personality(current->personality) == PER_LINUX32 &&
+	    personality == PER_LINUX)
 		personality = PER_LINUX32;
 	ret = sys_personality(personality);
 	if (ret == PER_LINUX32)
