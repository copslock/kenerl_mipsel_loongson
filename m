Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 17:58:04 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:9190 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28581922AbYCXR6C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 17:58:02 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 42E628810; Mon, 24 Mar 2008 22:58:19 +0400 (SAMT)
Message-ID: <47E7EBFF.6020406@ru.mvista.com>
Date:	Mon, 24 Mar 2008 20:59:27 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: Where's C0 count/.compare IRQ is unmasked??
References: <47E559B6.9010001@ru.mvista.com>
In-Reply-To: <47E559B6.9010001@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi, I wrote:

>    I'm dazed and confused -- please forget my ignorance but I fail to 
> see where the count/compare interrupt is enabled by the most platforms 
> but Alchemy (which does it in arch_init_irq() -- which is causing me 
> trouble). I'd expected this to happev in cevr-r4k.c but no, it doesn't 
> (unlike cevt-sb1250.c for example).

    In fact, it does, via setup_irq(), so ignorant I am. :-[

WBR, Sergei
