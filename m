Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2008 17:16:51 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:20004 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20040685AbYDUQQs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2008 17:16:48 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id AA7773EC9; Mon, 21 Apr 2008 09:16:43 -0700 (PDT)
Message-ID: <480CBDC8.9090500@ru.mvista.com>
Date:	Mon, 21 Apr 2008 20:16:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] Pb1200: do register SMC 91C111
References: <200804152226.18762.sshtylyov@ru.mvista.com>
In-Reply-To: <200804152226.18762.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Pb1200 does have SMC 91C111 Ethernet chip on board but the platform code did
> not register it, so one couldn't mount NFS...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> This is definitely a bad place for the board #ifdef's, so I'm going to submit
> a patch moving IDE and 91C111 registration into arch/mips/au1000/pb1200/...

    Err, Ralf, since these 2 patches haven't got merged and haven't got into 
2.6.25 anyway, maybe it makes sense to ignore them, so that I do these change 
along with moving the code into arch/mips/au1000/pb1200/platform.c?

WBR, Sergei
