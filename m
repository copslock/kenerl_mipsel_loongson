Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:39:02 +0100 (CET)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44938 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeABPiyCf7Q1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:38:54 +0100
Received: by mail-oi0-f66.google.com with SMTP id g6so17499777oib.11
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 07:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X/U+k3Ny2XOo388OUNhKt4uH11BkrwwmcEvGm7IOkQw=;
        b=cFWkdj3LmXU2evnSj74TpcWahZmRVQhnPYOuECHSwp6mXjOsnuk2jzNXeB/QJJfNCi
         +HMJELGOtZBCU6n5XZwsbs8VipuXOKHmRkGuP4xthQSdRldzVCFQkYHzOXSKkT5AHrme
         C4TpdcbGx3bB46CEeIFaIgMTTX+cOfL9ZAuoM3G9FMR4Kg5MrKMPY0z5dqtOsU/SGI/Z
         U4wddHzjujuVHeOvQoo1BtLXA/SNhs7JeiTDhia5gFmVFdS6zWq0hQ+W98JOL8LN6unS
         Bulrgacv3pIsZNk2/7obfmrE8FIC4YndhtfzzdYUKr7WIehD5Z87W+698elUwQOQNKm1
         THEw==
X-Gm-Message-State: AKGB3mLLhq9HgcaO0U5dFbTSFC1IEhTWc50bz0yK7XbQpZFJSrAO7oqR
        Kzf09DnHToVc2kVpjIwcQQ==
X-Google-Smtp-Source: ACJfBouQcdiGccMmtqJ9+DbnYGJKH+18bmEEzL8719bcOu/QHCIj118sKP9nyHSR2xyTNJUs4TtEmA==
X-Received: by 10.202.102.13 with SMTP id a13mr26990306oic.69.1514907527853;
        Tue, 02 Jan 2018 07:38:47 -0800 (PST)
Received: from localhost ([166.137.104.41])
        by smtp.gmail.com with ESMTPSA id l66sm18853326oia.24.2018.01.02.07.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 07:38:47 -0800 (PST)
Date:   Tue, 2 Jan 2018 09:38:46 -0600
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
Subject: Re: [PATCH v3 1/2] dt-bindings: Document mti,mips-cpc binding
Message-ID: <20180102153846.luphqiy7zn5nl4x6@rob-hp-laptop>
References: <1514385475-23921-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1514385475-23921-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514385475-23921-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61843
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

On Wed, Dec 27, 2017 at 03:37:51PM +0100, Aleksandar Markovic wrote:
> From: Paul Burton <paul.burton@mips.com>
> 
> Document a binding for the MIPS Cluster Power Controller (CPC) that
> allows the device tree to specify where the CPC registers are located.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  Documentation/devicetree/bindings/power/mti,mips-cpc.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
