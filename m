Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 17:34:16 +0100 (CET)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46899 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeAEQeHnX7TG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 17:34:07 +0100
Received: by mail-oi0-f65.google.com with SMTP id t81so3433208oih.13;
        Fri, 05 Jan 2018 08:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5frxPVyUZ+yqbP1Sutc+tiIMs93PfO6Lv12JfoV+CY=;
        b=l3vuHFF5f9oTEy6GJpB125adizAXxGVgMs+1D+NbAso3epXnFfi5Zz3lK3dK4hOWZV
         OeGC57R5NnwZmQrUqDvv59WpWPUec1b7SWThdc3xO4M3GCXLIgF2dwdXSrONA6N5/sr3
         EUhNR4EA5ooOKOMuddtSbCJA29Y/C/gPETrelFmxqzdrGzn2hqKIxMg5bKt1/ttLH/o8
         bl7+/xBg/02/2+XOF03mLhEGkz7el9sqk81k0v5TSd55vfbMo4xBrXOAFTcS+/EEei4/
         IHNsJSX8X2AQpPhgAwHbm0vhIDRRU9lXap+tcpjoDKtNxYmpt4U4GFB2agu2lc/EkXeC
         97zg==
X-Gm-Message-State: AKGB3mKUvomiH+HQZTgi2KENcQT5DTYmimmlwtV85FwmqoE3/9h1gBSG
        0j6eHdotmoruc39BpSed4w==
X-Google-Smtp-Source: ACJfBovX7/I4HcPQB6rFCVCS9xLWcBa0Cz0cl7v168abbbfFsG4a2suptv1v0L0LRmM1EUO8KF1nAw==
X-Received: by 10.202.74.80 with SMTP id x77mr1940941oia.199.1515170041526;
        Fri, 05 Jan 2018 08:34:01 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id w11sm1899744otg.29.2018.01.05.08.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 08:34:00 -0800 (PST)
Date:   Fri, 5 Jan 2018 10:34:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 05/15] dt-bindings: clock: Add jz4770-cgu.h header
Message-ID: <20180105163400.qg6q7znrv4s5wrfd@rob-hp-laptop>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180102150848.11314-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180102150848.11314-5-paul@crapouillou.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61911
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

On Tue, Jan 02, 2018 at 04:08:38PM +0100, Paul Cercueil wrote:
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4770-cgu driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  include/dt-bindings/clock/jz4770-cgu.h | 58 ++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 include/dt-bindings/clock/jz4770-cgu.h

Reviewed-by: Rob Herring <robh@kernel.org>
