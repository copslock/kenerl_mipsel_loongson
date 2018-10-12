Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 22:13:58 +0200 (CEST)
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42560 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeJLUNyTgjAp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 22:13:54 +0200
Received: by mail-ot1-f68.google.com with SMTP id c23so11738386otl.9;
        Fri, 12 Oct 2018 13:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pb24OT3MmhkEwfOGe+akcrfqOtfS8yAJxlq21mGbhw=;
        b=o1I+RNexpT7iM0ZJCbkhr1SRH9K0AgYdfOQzrw2Ga00IcrxiMXcleCzmoEbVI0u6XI
         qi97eb+k35tFSa2TL3lwjcGMD2eErue/ZdDe7VI7GQf+WkAKr6CaEuQ234H3SB8Tln7y
         81uYRO/Mmj/VzRaXNVv9hzsOZXht1XAx5wrnRXtmkbQRPt7E4zRQUh2S7EzZWQHVoDHr
         MdAuagPSfGwDZ66KoFn5bROBXOoakxq/m4ndBAZqOmv+x7b+QyjzwSSYE6C5XIqY/fgo
         WbkKSIf8ddlAJCTvG/0VfZkAGEJP76VT3R6065jNQjsnwYsbck5RQde/Ow3HZ1IJ4OAg
         Xjrg==
X-Gm-Message-State: ABuFfojp+9z3OEv/L0LGxXHG9LZ+ZZLCp0LZFfMQnfSmA5dvPP7UL4hY
        miv1HEk9thJIncpmFhdlVA==
X-Google-Smtp-Source: ACcGV61ZV8COptgRqkrHjfLnUJXSQTnHWjVswrTYiOfKOM5D3AYSrnN8US+GWIYhr5qrTzoY4hkcVw==
X-Received: by 2002:a9d:4359:: with SMTP id y25mr4968896oti.80.1539375228035;
        Fri, 12 Oct 2018 13:13:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w128-v6sm540977oiw.15.2018.10.12.13.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:13:47 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:13:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/7] dt-binding: interrupt-controller: Document RTL8186
 SoC DT bindings
Message-ID: <20181012201346.GA17471@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-3-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102952.7913-3-yasha.che3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66793
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

On Mon, Oct 01, 2018 at 01:29:47PM +0300, Yasha Cherikovsky wrote:
> This patch adds device tree binding doc for the
> Realtek RTL8186 SoC interrupt controller.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../interrupt-controller/realtek,rtl8186-intc  | 18 ++++++++++++++++++

.txt

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
