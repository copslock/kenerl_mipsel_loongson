Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 09:52:34 +0100 (BST)
Received: from paris5.amen.fr ([62.193.203.10]:23306 "EHLO paris5.amen.fr")
	by ftp.linux-mips.org with ESMTP id S8133452AbVJQIwR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2005 09:52:17 +0100
Received: from firewall (77.237.98-84.rev.gaoland.net [84.98.237.77])
	by paris5.amen.fr (8.10.2/8.10.2) with ESMTP id j9H8q7B21592
	for <linux-mips@linux-mips.org>; Mon, 17 Oct 2005 10:52:08 +0200
Message-ID: <4353656E.8070601@avilinks.com>
Date:	Mon, 17 Oct 2005 10:48:46 +0200
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: sti() freezes the kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm actually trying to start a 2.4 kernel on our new card.
The kernel freezes when enabling interrupts with sti() in start_kernel() 
(just before calculating BogoMips...).
This looks like an interrupts is up when enabling so that it stops the 
MIPS and freezes the kernel.
I'm looking after this interrupt but I would like to know if there could 
be any others reasons for my kernel to freeze when doing a call to sti();

Many thanks in advance for your suggestions...

@+ Yoann
