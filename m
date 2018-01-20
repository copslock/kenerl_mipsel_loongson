Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 01:34:30 +0100 (CET)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36607 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeATAeSAJwoP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 01:34:18 +0100
Received: by mail-ot0-f194.google.com with SMTP id f100so2913773otf.3;
        Fri, 19 Jan 2018 16:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=alXz67szX2ODQwl4rySFL3siZQ/+tciETg1KnMFWYP4=;
        b=YRkTxzA0R/LTUDPJHs7apekR+uyiMTpV35Hha1wLOGtkhtbhaeYE0Gd53lPhVeLIJZ
         kvlsqeT0v15m8b3XXCnGil8ODcEiyEjKZW6bBRK5F8EIXdlZpKF4oQi9y4/EeDqDdLrx
         5QzHoKakbqAG6Ti0gyf4iLXBoGRMp+I/JRhuLSbunmbJLQ8eOn1lbAaw75wAd7MvbtAj
         H6du8s2yuL7gF9kFqOoyEEZ6CnlYC2jeTb+JOoU0twV947v8maL/JYsNXgO8GeCSUkxX
         O72HjzHFHa7ebNq+YTGFjN6EJS05F8qX4USGbY1xtIeGhkxlS4zD3Nyw0LHPq7uQEIhH
         dGng==
X-Gm-Message-State: AKwxytdRGS2qVYv8vfRDQrzbVj9DCmotKGFU5oxifLoXW9slCq4VTyKG
        w6z5Ao8xseLIowhcZvc4HQ==
X-Google-Smtp-Source: AH8x22766ZIM1VDRt1lxUyLcqZ+lNUJkN83uUrfOEPmuf3OgwtXA4mKWvg45vHurz/kCzRjLdxMA1w==
X-Received: by 10.157.13.76 with SMTP id 70mr155686oti.97.1516408451551;
        Fri, 19 Jan 2018 16:34:11 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id i49sm4984007ote.21.2018.01.19.16.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jan 2018 16:34:11 -0800 (PST)
Date:   Fri, 19 Jan 2018 18:34:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: power: reset: Document ocelot-reset
 binding
Message-ID: <20180120003410.gewxntrzlkurkfgk@rob-hp-laptop>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-3-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-3-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62256
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

On Tue, Jan 16, 2018 at 11:12:34AM +0100, Alexandre Belloni wrote:
> Add binding documentation for the Microsemi Ocelot reset block.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/power/reset/ocelot-reset.txt       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt

Reviewed-by: Rob Herring <robh@kernel.org>
