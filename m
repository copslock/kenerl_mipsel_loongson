Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 22:15:17 +0200 (CEST)
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44282 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994542AbeJLUPNgM6Pp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 22:15:13 +0200
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so10785686oia.11;
        Fri, 12 Oct 2018 13:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBZ7jCAtzPfYr+mQBWV6NZ+CVjza3RJgUPpy7ZDZzHs=;
        b=RK0xkVFaKyln5npgBIt6fUoXxYiUBaLDk8sJYzd4k5ZFvKKUFh2U+HEP7ill5k+KnN
         fDMbgbBl9FLvYtc8KSiuc41AGOBpTv7PNZQEKSaxG4OdyNoOvX1NzKwTtNRUXWDmrtVv
         MFW33hYeFoWjEaHhon9V7PrmmmyRuLzQ2N4SdKvzsBGzDEBt99LNjhqpKpw7c2V5VGUo
         KRgx6GSzSASxQHM+gJwioaE066SaFklu46HeNFD4oFJR7UwQqOo0dwHv7RJvXqxZp44d
         JYpI+s/Ciedp9DXzPbLxnE89d1aKRjY8cjs6vtrwOWTahqaBUcWQ7GHSQUsMycNMKnYX
         iDIw==
X-Gm-Message-State: ABuFfoh3B4IMusGfUyAJCcjPlH+RX1h1fi1r2QzqeVMD1dN9aVrVXp6m
        ehoJQS8/6PhS9SLNQ8deZg==
X-Google-Smtp-Source: ACcGV611ZeCjuMsKrnmBRPGSoT+AUq2BkV+vQD9dfjfl36AV5SxGQtlbGbHzneeWGsHcBveXmxlIBg==
X-Received: by 2002:aca:3f43:: with SMTP id m64-v6mr1145435oia.46.1539375307489;
        Fri, 12 Oct 2018 13:15:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y63-v6sm665393oia.39.2018.10.12.13.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:15:06 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:15:06 -0500
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
Subject: Re: [RFC v2 6/7] dt-binding: mips: Document Realtek SoC DT bindings
Message-ID: <20181012201506.GA22059@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-7-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102952.7913-7-yasha.che3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66795
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

On Mon,  1 Oct 2018 13:29:51 +0300, Yasha Cherikovsky wrote:
> This patch adds device tree binding doc for Realtek MIPS SoCs.
> 
> It includes a compatible string for the Realtek RTL8186 SoC.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mips/realtek.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
