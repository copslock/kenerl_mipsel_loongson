Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 18:14:07 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:63090 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S24207822AbYLUSOF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2008 18:14:05 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D9AA33ECA; Sun, 21 Dec 2008 10:14:02 -0800 (PST)
Message-ID: <494E8786.2040103@ru.mvista.com>
Date:	Sun, 21 Dec 2008 21:14:30 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/14] Alchemy: move development board code to common
 subdirectory
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net> <20081221170806.GA10532@linux-mips.org>
In-Reply-To: <20081221170806.GA10532@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>Move alchemy development board code to common subdirectory. This should
>>ease sharing of common devboard code.

>>Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

> You're submitting this for 2.6.28 please ensure your patches apply
> against the -queue tree.  There is already another patch in -queue touching

    I'm sure you meant to type 2.6.29. :-)

>   Ralf

WBR, Sergei
