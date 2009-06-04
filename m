Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 15:29:58 +0100 (WEST)
Received: from h155.mvista.com ([63.81.120.155]:22605 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20022294AbZFDO3u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 15:29:50 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C45FF3EC9; Thu,  4 Jun 2009 07:29:47 -0700 (PDT)
Message-ID: <4A27DAAD.5000303@ru.mvista.com>
Date:	Thu, 04 Jun 2009 18:31:09 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/8] add lib/gcd.c
References: <200906041615.10467.florian@openwrt.org>
In-Reply-To: <200906041615.10467.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> This patch adds lib/gcd.c which contains a greatest
> common divider implementation taken from
> sound/core/pcm_timer.c

> Signed-off-by: Florian Fainelli <florian@openwrt.org>

[...]

> diff --git a/lib/gcd.c b/lib/gcd.c
> new file mode 100644
> index 0000000..fbf81a8
> --- /dev/null
> +++ b/lib/gcd.c
> @@ -0,0 +1,20 @@
> +#include <linux/gcd.h>
> +#include <linux/module.h>
> +
> +/* Greatest common divisor */
> +unsigned long gcd(unsigned long a, unsigned long b)
> +{
> +	unsigned long r;
> +
> +	if (a < b) {
> +		r = a;
> +		a = b;
> +	b = r;

    Fix indentation please.

> +	}
> +	while ((r = a % b) != 0) {
> +		a = b;
> +		b = r;
> +	}
> +	return b;
> +}
> +EXPORT_SYMBOL(gcd);

WBR, Sergei
