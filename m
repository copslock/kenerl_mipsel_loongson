Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 15:26:54 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:59683 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
	with SMTP id S1492024AbZKXO0k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 15:26:40 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 468DE3ED3; Tue, 24 Nov 2009 06:26:30 -0800 (PST)
Message-ID: <4B0BED46.2030809@ru.mvista.com>
Date:	Tue, 24 Nov 2009 17:27:18 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 3/3] MIPS: Alchemy: irq: use runtime CPU type detection
References: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com> <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com> <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Use runtime CPU detection instead of relying on preprocessor symbols.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

[...]

> @@ -547,36 +549,9 @@ handle:
>  	do_IRQ(off);
>  }
>  
> -/* setup edge/level and assign request 0/1 */
> -static void __init setup_irqmap(struct au1xxx_irqmap *map, int count)
> +static void __init au1000_init_irq(struct au1xxx_irqmap *map)
>  {

    Perhaps au1xxx_inint_irq() would be a better name...

WBR, Sergei
