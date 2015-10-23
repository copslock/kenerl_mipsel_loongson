Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:10:25 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33786 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWVKTr0bEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:10:19 +0200
Received: by pabrc13 with SMTP id rc13so127526421pab.0;
        Fri, 23 Oct 2015 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h52OtTeuKYY7ummxRKlWbKDC6AvdnucHjTkhs/a6bPQ=;
        b=nnouxYYF9ByzY/HyeopZggZScI1orD/udDODJGjJCCYvZV/Q2OCMvgcBy4iaOSCv3W
         3tMEM3zj74NxC9LlN3bSZ4dEhXpM0xsPdgUSAiXuGG0swvP1WKecpdmFKSiEdmrVegsT
         1WlDAkjBypA3C2oL4D5RRSNZtvGQY20GnqVmpNv9OqNvvvGH7xL/DQi181iwZlsqq3Oq
         vgdnVzZXC3K5grL8lOuehNKARaZbotb8GfC9n34maF/EH8Sm9ayI8Yglbc7ECmgDVQzb
         huozt4A1UjiAOns+EgMifLlZy5BFf6duw4JkU0t+K6GrVvxqN/JNMiiD/erAp1DyqELb
         x8Kw==
X-Received: by 10.68.200.35 with SMTP id jp3mr7296442pbc.122.1445634613918;
        Fri, 23 Oct 2015 14:10:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id iy1sm20557693pbb.85.2015.10.23.14.10.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 14:10:13 -0700 (PDT)
Date:   Fri, 23 Oct 2015 14:10:11 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable
 on BMIPS_GENERIC
Message-ID: <20151023211011.GR13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49670
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

On Fri, Oct 23, 2015 at 10:44:17AM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3 PHY.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>
