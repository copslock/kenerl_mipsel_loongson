Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 23:35:59 +0200 (CEST)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35559 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992145AbdFGVfwEzlpe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 23:35:52 +0200
Received: by mail-ot0-f196.google.com with SMTP id t31so2100580ota.2;
        Wed, 07 Jun 2017 14:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKFu2jMI1ju/CIDreO7lCDlk7Lnlj/kVatItHpmUEnM=;
        b=ez/52Kv0FU8H/LJGQL+Cvz3i4liV05HJsh3NecU7M/oTJHaQAlFRoUdBmPd4NCcZJy
         oGVV9IcIeJ2u2FrS/tJf3pNKitHk6VD/jCOVQ5w4n05oVKEyGmWu0GJAfUVZM9ADbB7G
         J03krYwAklRi/B+AYn3e7lBTFR5frGPdjoOmgz7rMEI6uuWdfzUbLUVo2o0HRTUurXTa
         jF5NSy9C26y9tyRi01uuioEaW1FFeGf/Mz0fTQANt26RgV/G8f8K8eqF95XXUJPgfvdu
         RoVqIZ1ISwqcF15boOicIw8uPjsbF3JzrCEO9QlfUCKidqZDDoqrmSUOoO+ehQxWmowo
         ss3Q==
X-Gm-Message-State: AKS2vOwU1rzgwxA+8sOyr1UGvaPrH3BXzFd7uiDAH1bDBvWEk6bAFTof
        8Tx6NvrBEbwpXw==
X-Received: by 10.157.50.41 with SMTP id t41mr17023867otc.70.1496871346232;
        Wed, 07 Jun 2017 14:35:46 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id b9sm1537752oth.4.2017.06.07.14.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Jun 2017 14:35:45 -0700 (PDT)
Date:   Wed, 7 Jun 2017 16:35:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     ralf@linux-mips.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] MIPS: NI 169445 board support
Message-ID: <20170607213544.rvgxhd7dwh56les2@rob-hp-laptop>
References: <1496259237-9524-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496259237-9524-1-git-send-email-nathan.sullivan@ni.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58290
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

On Wed, May 31, 2017 at 02:33:57PM -0500, Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
> 
> Changes from v4:
> 
> - Address Rob Herring's device tree feedback
> 
> I'm still unclear on the vmlinux.its.S changes.  The linux-mti tree has a
> config in the image tree for each board it supports, and I followed that
> pattern here.  Rob was concerned about how the configs would scale wrt
> the number of bootloaders around, but it's really just one per board/dt,
> right?

It was more just a comment if I was MIPS maintainer, but I'm not so for 
the DT parts:

Acked-by: Rob Herring <robh@kernel.org>

> 
> ---
>  Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
>  MAINTAINERS                                     |   8 ++
>  arch/mips/boot/dts/Makefile                     |   1 +
>  arch/mips/boot/dts/ni/169445.dts                | 100 ++++++++++++++++++++++++
>  arch/mips/boot/dts/ni/Makefile                  |   7 ++
>  arch/mips/configs/generic/board-ni169445.config |  27 +++++++
>  arch/mips/generic/Kconfig                       |   6 ++
>  arch/mips/generic/vmlinux.its.S                 |  25 ++++++
>  8 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
>  create mode 100644 arch/mips/boot/dts/ni/169445.dts
>  create mode 100644 arch/mips/boot/dts/ni/Makefile
>  create mode 100644 arch/mips/configs/generic/board-ni169445.config
