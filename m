Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 16:58:21 +0100 (WEST)
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2555 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022567AbZFDP6O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 16:58:14 +0100
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id IAA05642;
	Thu, 4 Jun 2009 08:57:15 -0700
Subject: Re: [PATCH 1/8] add lib/gcd.c
From:	Joe Perches <joe@perches.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <200906041639.04868.florian@openwrt.org>
References: <200906041615.10467.florian@openwrt.org>
	 <4A27DAAD.5000303@ru.mvista.com>  <200906041639.04868.florian@openwrt.org>
Content-Type: text/plain
Date:	Thu, 04 Jun 2009 08:57:24 -0700
Message-Id: <1244131044.3631.14.camel@Joe-Laptop.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-06-04 at 16:39 +0200, Florian Fainelli wrote:
> diff --git a/lib/gcd.c b/lib/gcd.c
> new file mode 100644
> index 0000000..6634741
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
> +		b = r;
	swap(a, b)
> +	}
> +	while ((r = a % b) != 0) {
> +		a = b;
> +		b = r;
> +	}
> +	return b;
> +}
> +EXPORT_SYMBOL_GPL(gcd);

Shouldn't a generic gcd protect against a div0
if gcd(0,0)?
