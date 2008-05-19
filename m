Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2008 14:27:33 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:54447 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023274AbYESN1b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 May 2008 14:27:31 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0727F3ECB; Mon, 19 May 2008 06:27:28 -0700 (PDT)
Message-ID: <4831802B.7060409@ru.mvista.com>
Date:	Mon, 19 May 2008 17:27:07 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	drzeus@drzeus.cx
Subject: Re: [PATCH 9/9] au1xmmc: Add back PB1200/DB1200 MMC activity LED
 support
References: <20080519080339.GA21985@roarinelk.homelinux.net> <20080519080837.GJ21985@roarinelk.homelinux.net>
In-Reply-To: <20080519080837.GJ21985@roarinelk.homelinux.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Add back PB1200/DB1200 MMC activity LED support just the way
> it was done in the original driver source.

> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

   For the reason of "bisectability" you'd better merge this with patch 3.

WBR, Sergei
