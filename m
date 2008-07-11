Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 14:51:38 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:5514 "EHLO smtp4.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20029797AbYGKNvg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jul 2008 14:51:36 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 6F3C5FE3A37;
	Fri, 11 Jul 2008 15:51:30 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 923123ED0F5;
	Fri, 11 Jul 2008 15:51:05 +0200 (CEST)
Received: from lenovo.local (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 83C8490001;
	Fri, 11 Jul 2008 15:51:05 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH][MIPS] MTX-1 flash partition setup move to platform devices registration
Date:	Fri, 11 Jul 2008 15:50:56 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-mtd <linux-mtd@lists.infradead.org>
References: <20080711223448.f5826678.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080711223448.f5826678.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200807111550.57481.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 923123ED0F5.DEF56
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hello Yoichi,

Le Friday 11 July 2008 15:34:48 Yoichi Yuasa, vous avez écrit :
> MTX-1 flash partition setup move to platform devices registration.

Thanks for doing this.

>
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Acked-by: Florian Fainelli <florian.fainelli@telecomint.eu>
-- 
Cordialement, Florian Fainelli
------------------------------
