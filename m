Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2012 08:05:27 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45696 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901760Ab2ESGFT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 May 2012 08:05:19 +0200
Received: by pbbrq13 with SMTP id rq13so5508621pbb.36
        for <linux-mips@linux-mips.org>; Fri, 18 May 2012 23:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=BAyftTa5binHCTAUlkQhBLgnGU8EuZ2kRPfkl8XtRvM=;
        b=aoCkCGLTe4TxlEdQEy4Oek6ji9QfAQpCWkeaIdl1xogcMVAVHI5BFD+xCEh1jyF1iI
         zrzwd7SVuRBFI68DUjuRTNDVcq26Et+JTLaIHtQtz/S4o0niI6PP9ZSslf7JzR5XO1nN
         YDqoYhL+jq72YcQ5RDnORYma7+WSt6inGW7Yr1A2RhQphlIaljU70vdvgm0xIz0yK1yf
         ly6xtoFsEHg2ZFU3dgc1G6HlBSOqGGxOIcevmAqoNDhRSK/A/vKPW8+IFdOCYsNm3tL5
         mGlZpp7ECIyw904FhA7v75XkVfvzF+PfmuJ9eYDWCk6uOwaolYyxgxocq3ke7vqvyX7Y
         f2CA==
Received: by 10.68.220.100 with SMTP id pv4mr46887236pbc.116.1337407513284;
        Fri, 18 May 2012 23:05:13 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id rs3sm15250067pbc.47.2012.05.18.23.05.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 23:05:10 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id DAD0F3E046E; Sat, 19 May 2012 00:05:09 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/5] i2c: Convert i2c-octeon.c to use device tree.
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>,
        linux-i2c@vger.kernel.org
In-Reply-To: <1335489630-27017-2-git-send-email-ddaney.cavm@gmail.com>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com> <1335489630-27017-2-git-send-email-ddaney.cavm@gmail.com>
Date:   Sat, 19 May 2012 00:05:09 -0600
Message-Id: <20120519060509.DAD0F3E046E@localhost>
X-Gm-Message-State: ALoCoQk2QUvids2s0HszoOXK61E+tQgsJjL3gzv3IfG6s5dm7cA4vq5mCGhsrr1+MNkBGLJPVOKz
X-archive-position: 33371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 26 Apr 2012 18:20:26 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> There are three parts to this:
> 
> 1) Remove the definitions of OCTEON_IRQ_TWSI and OCTEON_IRQ_TWSI2.
>    The interrupts are specified by the device tree and these hard
>    coded irq numbers block the used of the irq lines by the irq_domain
>    code.
> 
> 2) Remove platform device setup code from octeon-platform.c, it is
>    now unused.
> 
> 3) Convert i2c-octeon.c to use device tree.  Part of this includes
>    using the devm_* functions instead of the raw counterparts, thus
>    simplifying error handling.  No functionality is changed.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Is the DT binding for this device documented?

Otherwise the code looks good.  Please make sure the binding
documentation is in place before merging.

g.
