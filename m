Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 16:24:21 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35366 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993929AbdFIOYLnnfwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 16:24:11 +0200
Received: by mail-oi0-f65.google.com with SMTP id v74so4671408oie.2;
        Fri, 09 Jun 2017 07:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qVJjFYwAdu5LTd9j2dVAVowia78PexGfLYqMzIledg=;
        b=bQnqPq/7FRE80iQLScfEqkAp6mp+ME9TdOZPutu9DJvgY7s3ri6Fk9jtaD5p3+Re1d
         ON/e8u0aS1bs6/LZX9xuT1PKNTwBe+4L3DiARXFWCCw/A6heoQBgzA8thUt/OIcKF0cu
         8ak8fRykTEE0eC4jMvC5ONPTT0NW1q9ahFAdQ7FMncETJ2yJyObRfrNZrOKACdzin/J1
         WYB97EPeclBLnIfruCqADoS6yoatf3Ek1a7vLnB5szJ1UMOTXtogFluG1UoN7huQJ9h1
         X/poDm+BmcStxWNq2zLU2fjt/0AV4pIqjIF8B/qW+i8EAnUNNVWf41eESfJg5dIx/I8r
         ax1w==
X-Gm-Message-State: AODbwcDulp7JE3txrLPdcnX/xkknKkqn5QUvLl95rJA3Bm3aHJchhYm8
        O06x7r2ehzFKog==
X-Received: by 10.202.217.198 with SMTP id q189mr2767441oig.121.1497018245443;
        Fri, 09 Jun 2017 07:24:05 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id s141sm498866oie.40.2017.06.09.07.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Jun 2017 07:24:05 -0700 (PDT)
Date:   Fri, 9 Jun 2017 09:24:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 14/15] devicetree/bindings: Add GCW vendor prefix
Message-ID: <20170609142404.xmr5jcuq5vh2mwpp@rob-hp-laptop>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607200439.24450-15-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58384
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

On Wed, Jun 07, 2017 at 10:04:38PM +0200, Paul Cercueil wrote:
> Games Consoles Worldwide, mostly known under the acronym GCW, is the
> creator of the GCW Zero open-source video game system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
