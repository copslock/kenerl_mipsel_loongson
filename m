Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 05:50:52 +0100 (WEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35266 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021466AbZFBEup (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 05:50:45 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n524oYtt008736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2009 21:50:35 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n524oYqJ020206;
	Mon, 1 Jun 2009 21:50:34 -0700
Date:	Mon, 1 Jun 2009 21:50:34 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/9] kernel: export sound/core/pcm_timer.c gcd
 implementation
Message-Id: <20090601215034.7352ddca.akpm@linux-foundation.org>
In-Reply-To: <200906011357.09966.florian@openwrt.org>
References: <200906011357.09966.florian@openwrt.org>
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
X-archive-position: 23162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Mon, 1 Jun 2009 13:57:09 +0200 Florian Fainelli <florian@openwrt.org> wrote:

> This patch exports the gcd implementation from
> sound/core/pcm_timer.c into include/linux/kernel.h.
> AR7 uses it in its clock routines.
> 
> ...
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 883cd44..878a27a 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -147,6 +147,22 @@ extern int _cond_resched(void);
>  		(__x < 0) ? -__x : __x;		\
>  	})
>  
> +/* Greatest common divisor */
> +static inline unsigned long gcd(unsigned long a, unsigned long b)
> +{
> +        unsigned long r;
> +        if (a < b) {
> +                r = a;
> +                a = b;
> +                b = r;
> +        }
> +        while ((r = a % b) != 0) {
> +                a = b;
> +                b = r;
> +        }
> +        return b;
> +}

a) the name's a bit sucky.   Is there some convention for this name?

b) It looks too large to be inlined.  lib/gdc.c?

b) there's an implementation of gcd() in
   net/netfilter/ipvs/ip_vs_wrr.c.  I expect that this patch broke the
   build.
