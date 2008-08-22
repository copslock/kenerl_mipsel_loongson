Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 15:45:56 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:58308 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28588426AbYHVOpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 15:45:49 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 14885FE2EB2;
	Fri, 22 Aug 2008 16:45:44 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id EDF853F08C8;
	Fri, 22 Aug 2008 16:45:24 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id A55AC90004;
	Fri, 22 Aug 2008 16:45:24 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] rb532: do not KSEG1ADDR an already virtual address
Date:	Fri, 22 Aug 2008 16:45:21 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf@linux-mips.org
References: <200808220014.39030.florian@openwrt.org> <48AE89BC.3070204@ru.mvista.com>
In-Reply-To: <48AE89BC.3070204@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808221645.21878.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: EDF853F08C8.770AB
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Sergei,

Le Friday 22 August 2008 11:41:16 Sergei Shtylyov, vous avez écrit :
>    Why not just leave RC32434_REG_BASE + RC32434_RST and remove
> KSEG1ADDR? BTW, the cast could be removed as well, since it's already a
> part of RC32434_REG_BASE...

In fact,I need to cleanup other headers, so I will just drop this one for now.
