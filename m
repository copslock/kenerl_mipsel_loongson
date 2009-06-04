Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 20:04:36 +0100 (WEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60054 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022443AbZFDTE2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 20:04:28 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n54J3gW1017673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2009 12:03:43 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n54J3ehd005383;
	Thu, 4 Jun 2009 12:03:41 -0700
Date:	Thu, 4 Jun 2009 12:03:40 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Joe Perches <joe@perches.com>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/8] add lib/gcd.c
Message-Id: <20090604120340.079f6cdf.akpm@linux-foundation.org>
In-Reply-To: <1244131044.3631.14.camel@Joe-Laptop.home>
References: <200906041615.10467.florian@openwrt.org>
	<4A27DAAD.5000303@ru.mvista.com>
	<200906041639.04868.florian@openwrt.org>
	<1244131044.3631.14.camel@Joe-Laptop.home>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 04 Jun 2009 08:57:24 -0700 Joe Perches <joe@perches.com> wrote:

> On Thu, 2009-06-04 at 16:39 +0200, Florian Fainelli wrote:
> > diff --git a/lib/gcd.c b/lib/gcd.c
> > new file mode 100644
> > index 0000000..6634741
> > --- /dev/null
> > +++ b/lib/gcd.c
> > @@ -0,0 +1,20 @@
> > +#include <linux/gcd.h>
> > +#include <linux/module.h>
> > +
> > +/* Greatest common divisor */
> > +unsigned long gcd(unsigned long a, unsigned long b)
> > +{
> > +	unsigned long r;
> > +
> > +	if (a < b) {
> > +		r = a;
> > +		a = b;
> > +		b = r;
> 	swap(a, b)

yup

> > +	}
> > +	while ((r = a % b) != 0) {
> > +		a = b;
> > +		b = r;
> > +	}
> > +	return b;
> > +}
> > +EXPORT_SYMBOL_GPL(gcd);
> 
> Shouldn't a generic gcd protect against a div0
> if gcd(0,0)?

nope.  It's a caller bug, there's nothing the callee can do to fix it,
so an oops is a fine response.
