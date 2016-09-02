Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:34:34 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35293 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991344AbcIBMe10JqRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 14:34:27 +0200
Received: by mail-oi0-f68.google.com with SMTP id 2so4238326oif.2;
        Fri, 02 Sep 2016 05:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJeGOS+6e1HV4Oy7MRfhVmhn9ZPUAoaE5ok4Qn/OhtQ=;
        b=b+MUqcZBmk0NFGnhlR6h6LgUiscRltA5VjQ7MHnfdq7efCE0f8T/XomP2dtzvF/xIs
         t7Fc7hrPtYCmFTQlDrBysJf4pOoS39fRkZOQMSMmWdGBEVn0mWQ91gpGnBNSqvIxmNJz
         2QIoFE9GiA2RIB0LXkk1bVmBQksVGFF1rrbm/NxyR7jZbnX5OntXSstdH6cLqgky886r
         Ct0jWUzWAZAvAfsNugQkXyK3lojNTS3RA12vfuoIH1gg3DylV8mz+Te6+TptDsNWmgWo
         Sf3iCI97tZZ1RibMCeLxVubBzH2EvzC5zCr64TysE4SciT7OV/vwDr/Y6TU76XzbHGxr
         WQ7A==
X-Gm-Message-State: AE9vXwNcjl/O3yWDxkHujgBxqL/4Goms0hwCKvPhKerI0mNhjkP6ybJXFKne4eOBNUzeqA==
X-Received: by 10.202.199.150 with SMTP id x144mr1708742oif.50.1472819660304;
        Fri, 02 Sep 2016 05:34:20 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id g7sm3513416otb.6.2016.09.02.05.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 05:34:19 -0700 (PDT)
Date:   Fri, 2 Sep 2016 07:34:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/26] dt-bindings: Document mti,mips-cpc binding
Message-ID: <20160902123419.GA31627@rob-hp-laptop>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-12-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826153725.11629-12-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54988
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

On Fri, Aug 26, 2016 at 04:37:10PM +0100, Paul Burton wrote:
> Document a binding for the MIPS Cluster Power Controller (CPC) which
> simply allows the device tree to specify where the CPC registers should
> be mapped.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  Documentation/devicetree/bindings/misc/mti,mips-cpc.txt | 8 ++++++++

This is for power domains, right? Move to bindings/power.

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
> +
> +Required properties:
> +compatible : Should be "mti,mips-cpc".
> +regs: Should describe the address & size of the CPC register region.

Also needs #power-domain-cells property.

> -- 
> 2.9.3
> 
