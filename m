Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 22:14:54 +0200 (CEST)
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35900 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeJLUOqQ01fp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 22:14:46 +0200
Received: by mail-ot1-f68.google.com with SMTP id x4so12120208otg.3;
        Fri, 12 Oct 2018 13:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiuyprSBtwCZvTcg0gjXzWG3a7ixhh5nKD3WMvStGmE=;
        b=AjdprDquqUyOlOd5+Yus1ffcO5NiO6ntuTTgqTj4hG+tT4LdbO1S0uGjH8xOhIxreg
         N0grgJePikW7I+BFyd2hiaON34VqEuC1Zskr2n3AM3Ux84JIBTkg3XQCnqcbWo4Qmn/5
         mjOxg+7BKD/6dlvLVXZe2adkc4lcToWuIMxIopMO3SPb1QqlEk5KlDz31HST1Yw7suqU
         6KzwSJViTeQq0Xk8CT5vhV3p2Y6pjfvpQj1uMdSM9WgzaSxaqMCMaKBYgjRsf/UxaZno
         hHJORyL4/SwDPfVZhbIQrR+9gz1vWFhnNfxv4o23vzixwlQoYZW3ltDwB3AobaU0NAMt
         8ijw==
X-Gm-Message-State: ABuFfohyxhS+qDQsEgd6uuqGngfNNVkNJSet9Wrt4uaRXM+Tznlwbe0w
        Dm01mwXbgiCvePUyO8b/SQ==
X-Google-Smtp-Source: ACcGV6247K4GCNZ4FAk1swkUAfUOCEEXFCbOLdhsMXuedYNviD4hEid2TfagCQfj2CX5VXkevWUnVA==
X-Received: by 2002:a9d:8a4:: with SMTP id 33mr4434060otf.269.1539375280219;
        Fri, 12 Oct 2018 13:14:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w37sm648318oti.77.2018.10.12.13.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:14:39 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:14:38 -0500
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
        devicetree@vger.kernel.org,
        Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 4/7] dt-binding: timer: Document RTL8186 SoC DT bindings
Message-ID: <20181012201438.GA21356@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-5-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102952.7913-5-yasha.che3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66794
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

On Mon,  1 Oct 2018 13:29:49 +0300, Yasha Cherikovsky wrote:
> This patch adds device tree binding doc for the
> Realtek RTL8186 SoC timer controller.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../bindings/timer/realtek,rtl8186-timer.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
