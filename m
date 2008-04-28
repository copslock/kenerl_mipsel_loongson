Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 14:04:30 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:527 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20167487AbYD1NE1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2008 14:04:27 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 340F63EC9; Mon, 28 Apr 2008 06:04:24 -0700 (PDT)
Message-ID: <4815CB32.4040605@ru.mvista.com>
Date:	Mon, 28 Apr 2008 17:03:46 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1200/DBAu1200: move platform code to its proper place
 (take 2)
References: <200804262321.46298.sshtylyov@ru.mvista.com>
In-Reply-To: <200804262321.46298.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Since both the IDE interface and SMC 91C111 Ethernet chip are on-board devices,
> move the platform device registration form the common to board specific code.

> While at it, do some renaming:

> - change 'au1200_ide0_' variable name prefix to the mere 'ide_';

> - change 'smc91x_' variable name prefix to 'smc91c111_';

> - drop 'AU1XXX_' prefix from the macro names;

> - change 'SMC91C111_' to 'SMC91C111_', change 'IRQ' to 'INT' for consistency
>   in the Ethernet chip macro names;

   Oops, that should read "change 'SMC91111_' to 'SMC91C111_'", thanks to 
Miachel Wood for spotting that

> - change 'ATA_' to 'IDE_' and 'OFFSET' to 'SHIFT' (since this value is indeed
>   a shift count) in the IDE interface macro names.

    Additionally, I've removed semicolon from IDE_DDMA_REQ which didn't break 
things only because the macro wasn't ever used in aggregate initializer.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Oops, needed one more rename. :-)
> This patch is atop of my two recent SMC 91C1111 platform device fixes.

    It's 91C111, dammit...

WBR, Sergei
