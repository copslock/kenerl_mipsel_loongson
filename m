Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2007 15:01:22 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:27742 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021617AbXGYOBU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2007 15:01:20 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4E2D33EC9; Wed, 25 Jul 2007 07:01:17 -0700 (PDT)
Message-ID: <46A75827.4060801@ru.mvista.com>
Date:	Wed, 25 Jul 2007 18:03:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ths@networkno.de, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] tx49xx: add some mach specific headers
References: <20070725.015008.78730579.anemo@mba.ocn.ne.jp>	<46A6302A.5010105@ru.mvista.com>	<20070724212034.GA26960@networkno.de> <20070725.123236.97297895.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070725.123236.97297895.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>>+#define cpu_has_mips32r1	0
>>>>+#define cpu_has_mips32r2	0
>>>>+#define cpu_has_mips64r1	0
>>>>+#define cpu_has_mips64r2	0

>>>   Hm, really?

    I'm not good at arch generations, so forgive me a silly complaint. ;-)

>>IIRC it is MIPS IV. (tx99 is MIPS64R1).

> It is MIPS III.

    "Upward compatible" with it as the manual says.

> ---
> Atsushi Nemoto

WBR, Sergei
