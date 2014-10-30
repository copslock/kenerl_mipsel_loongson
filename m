Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 05:17:14 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46221 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010223AbaJ3ERIszkIT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 05:17:08 +0100
Received: by mail-pa0-f50.google.com with SMTP id eu11so4655777pac.9
        for <multiple recipients>; Wed, 29 Oct 2014 21:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1u2upSM6tjE3aN6e5V3UG1rfYS4lMhb4iQ8zBdfdMTM=;
        b=ly+gOdPvIs5cWW7GRYdFUnqmuxm8vijXw+zGMX73l0JTMhSnZ0bwsEWaIfb2iKo4mG
         VYKYDETh/F5BzSjYPSH/BfhW0BLL/z7kSzE2uJXwDxvMoR7bfFUxcz/GLfcPcmvPRsGC
         0RW6clXyVwPlskU+he6mTY2oeQAkVBn9hQFgW7Nwwjxzw7hJbyIy1qvA17dS2eIE3ryx
         I5vaC4NwM4V7jrbd6ifKSFqY4WaFJrL1IKrFabgr95OnyEWxzulbwRUeUjZV1Q2NqBqk
         h6ywBL0lRXZVjdc+iUjEfNauqTtVWRdQnArhFrC6K/11sYu64sp1Ta20qCuNcY3i55z/
         pS6g==
X-Received: by 10.68.68.132 with SMTP id w4mr14488356pbt.93.1414642622295;
        Wed, 29 Oct 2014 21:17:02 -0700 (PDT)
Received: from brian-ubuntu (cpe-76-173-170-164.socal.res.rr.com. [76.173.170.164])
        by mx.google.com with ESMTPSA id nq2sm5689531pdb.74.2014.10.29.21.17.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 21:17:01 -0700 (PDT)
Date:   Wed, 29 Oct 2014 21:16:58 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 06/15] genirq: Generic chip: Optimize for fixed-endian
 systems
Message-ID: <20141030041658.GB29070@brian-ubuntu>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
 <1414635488-14137-7-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414635488-14137-7-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Oct 29, 2014 at 07:17:59PM -0700, Kevin Cernekee wrote:
> @@ -19,7 +20,14 @@ static DEFINE_RAW_SPINLOCK(gc_lock);
>  
>  static int is_big_endian(struct irq_chip_generic *gc)
>  {
> -	return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&
> +	    !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
> +		return 0;
> +	else if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE) &&
> +		 !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP))
> +		return 1;

Would XOR make this any easier to read? e.g.:

	if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) ^
	    IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
		return IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE);
	else
		...

> +	else
> +		return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
>  }
>  
>  static void irq_reg_writel(struct irq_chip_generic *gc,

Brian
