Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2017 19:26:55 +0100 (CET)
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42223 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdLPS0qymYCa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Dec 2017 19:26:46 +0100
Received: by mail-ot0-f193.google.com with SMTP id i1so10375187oth.9
        for <linux-mips@linux-mips.org>; Sat, 16 Dec 2017 10:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aoguokzR/G0j2rr0u4cJzPxvSkESzMw1PsI40gsVIa0=;
        b=O83kPKmVYBNs/5NiN6UANMJlQo6Dwskj8DgRP1DA1OcDSwUbdzc6tjkMlDujDQiz58
         KKdNnE8jrLD0oY5DmzoBK2wwQsL0gwtuwzHVddNt8vg0bi42ca3SgzZ1w1lnNPZrBf3C
         CFPuAhwI5hZqV04Wrf0wmTMPVP+ASUBVmg9ce4Ei5VPC21Agn4Y90DVfUt1hTCIj/O0d
         fAcirW/yi15P5cIhCywiYYv4OOfYOUbnay3Si5TqZOTi0zyCzNcIaONpoHEVHRGa+FmG
         JctDIEmlwN08CQ+KYmedWoGKiaGGWaCHp94v8QyELACiCa8uP/oXFiRyrWPo4HCB7kwX
         hpew==
X-Gm-Message-State: AKGB3mKrU7PjmHrY4rYsZbgsXWwaCKoagVfSAdG0WBF6vehOPVGbZd/i
        SycMF6S6CS5TdndyEfBp5Q==
X-Google-Smtp-Source: ACJfBouQkHgkKD3hBtrOP4RaW8J9Km8sTwzILVZkqzHZis9APDyGLCx64mCK1AsIoITt9KraA8FEpw==
X-Received: by 10.157.14.151 with SMTP id 23mr10349420otj.234.1513448800775;
        Sat, 16 Dec 2017 10:26:40 -0800 (PST)
Received: from localhost (mobile-107-107-190-84.mycingular.net. [107.107.190.84])
        by smtp.gmail.com with ESMTPSA id j50sm4395620otb.30.2017.12.16.10.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Dec 2017 10:26:40 -0800 (PST)
Date:   Sat, 16 Dec 2017 12:26:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        devicetree@vger.kernel.org, Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document mti,mips-cpc binding
Message-ID: <20171216182638.3vd2rbkyos74e4jo@rob-hp-laptop>
References: <1513356723-7393-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1513356723-7393-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513356723-7393-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Dec 15, 2017 at 05:51:59PM +0100, Aleksandar Markovic wrote:
> From: Paul Burton <paul.burton@mips.com>
> 
> Document a binding for the MIPS Cluster Power Controller (CPC) which
> simply allows the device tree to specify where the CPC registers should
> be mapped.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  Documentation/devicetree/bindings/misc/mti,mips-cpc.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> new file mode 100644
> index 0000000..92eb08f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> @@ -0,0 +1,8 @@
> +Binding for MIPS Cluster Power Controller (CPC).
> +
> +This binding allows a system to specify where the CPC registers should be
> +mapped using device tree.

Not really where you map registers, but where they are located.

> +
> +Required properties:
> +compatible : Should be "mti,mips-cpc".

Only one version of the block?

> +regs: Should describe the address & size of the CPC register region.
> -- 
> 2.7.4
> 
