Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 23:35:23 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35298 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994895AbdHQVfMTec8u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 23:35:12 +0200
Received: by mail-oi0-f65.google.com with SMTP id q70so7651936oic.2;
        Thu, 17 Aug 2017 14:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIPWGgd+GedE+eGM4Y/i7x63PPV8OnY/ZQSRVju5CXI=;
        b=cjDHa2guu/ngKZMoTiw+WNxhQD1VoOJqFFK7jZw4CT0lhPJb3M8g4xnKBryHipsh7c
         Qoozy0MXof7lO9dcTHPahT11BxBkr9f6HHlDP9ndEwRX1adFo8kRDimJkddeyPmHJNF8
         5z8gOOgbNkO0lNA1PSY56fnrO6JZEzscQkk/YAsjWYINsSyHE0L4XPkcHH4SZUKFWhLn
         OAY1sQRQfvTrf2dBzmjRh49zjTkOd7iQtRFs5TiYiXhOpy6pcQk7BGg+v3rYJE09W+Ue
         Q/EuwhuSnBbHeYAU71jspsAsX7YIxJxF2BUjt8gvRjf4cDkLO4xSTRjG8vbawFGKbH0a
         NsOQ==
X-Gm-Message-State: AHYfb5gfbcyHLkVpnUppRMIsk2urWOTbk33ptk5I5QQ+aXStVMt1DFsm
        OI7UEgWhh8O/cw==
X-Received: by 10.202.226.13 with SMTP id z13mr8179342oig.49.1503005706721;
        Thu, 17 Aug 2017 14:35:06 -0700 (PDT)
Received: from localhost (mobile-166-173-60-17.mycingular.net. [166.173.60.17])
        by smtp.gmail.com with ESMTPSA id t72sm4953343oih.55.2017.08.17.14.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2017 14:35:04 -0700 (PDT)
Date:   Thu, 17 Aug 2017 16:35:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     mark.rutland@arm.com, ralf@linux-mips.org, john@phrozen.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] dt-bindings: vendors: Add VoCore as a vendor
Message-ID: <20170817213503.5n2mjuk5fm7fu2gp@rob-hp-laptop>
References: <1502814773-40842-1-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502814773-40842-1-git-send-email-harvey.hunt@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59638
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

On Tue, Aug 15, 2017 at 05:32:51PM +0100, Harvey Hunt wrote:
> VoCore are a manufacturer of devices such as the VoCore2.
> 
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
