Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 19:04:42 +0200 (CEST)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33460 "EHLO
        out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491105Ab1FLREj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 19:04:39 +0200
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
        by gateway1.messagingengine.com (Postfix) with ESMTP id EBE6821EEC;
        Sun, 12 Jun 2011 13:04:37 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Sun, 12 Jun 2011 13:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=M0AP1GzGLMOKkbaG+H33OcnB9uA=; b=q9I0t8mWHMLL9mTGS04hyBbJm5tIll3VaC1SnlDkQoDxp9by+lvJD+OG2c2AJ7C4cfgAjD/vS9xEXMrbMxB5VGE0BrxQu+xoySrM6H1vTg6KP3aQNN7/no8SoN0uFhwbbmxQf0K6ty8N4/sZzx5e0T5A7v+wGfw/3z48jhNzDbc=
X-Sasl-enc: /AxE48cvaDfxpMUyhcdK1d2PsHJ98QsVKlCDQuuZw/bu 1307898277
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
        by mail.messagingengine.com (Postfix) with ESMTPSA id 76F1F40209E;
        Sun, 12 Jun 2011 13:04:37 -0400 (EDT)
Date:   Sun, 12 Jun 2011 10:04:19 -0700
From:   Greg KH <greg@kroah.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: Re: [stable] [PATCH 3/5 v2] WATCHDOG: mtx1-wdt: fix GPIO toggling
Message-ID: <20110612170419.GA20289@kroah.com>
References: <201106121856.28934.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106121856.28934.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10187

On Sun, Jun 12, 2011 at 06:56:28PM +0200, Florian Fainelli wrote:
> Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
> changed the way the GPIO was toggled. Prior to this patch, we would
> always actively drive the GPIO output to either 0 or 1, this patch
> drove the GPIO active to 0, and put the GPIO in tristate to drive it
> to 1, unfortunately this does not work, revert back to active driving.
> 
> Using a signed variable (gstate) to hold the gpio state and using a bit-
> wise operation on it also resulted in toggling value from 1 to -2 since
> the variable is signed. This value was then passed on to gpio_direction_
> output, which always perform a if (value) ... to set the value to the
> gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1 ...
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes since v1:
> - use gpio_set_value() instead of gpio_direction_output(.., value)
> 
> Stable: [2.6.39+]
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
