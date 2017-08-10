Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 18:25:36 +0200 (CEST)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33888 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdHJQZYI6Bqh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 18:25:24 +0200
Received: by mail-pg0-f68.google.com with SMTP id y192so999069pgd.1;
        Thu, 10 Aug 2017 09:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoS4yOeWmAko7FidGyVyBvkklDN6eizoFw2jhH/q1ts=;
        b=qZFV4emXRxN9LkFG2czwdyJJFlDvbfHFPf+C98rk7+LcrCPRRkd/MY9qVKzzI8njcn
         KAOeXfXJfzk6V+W1GDHxswwW2g1VCo4SmssxeLqJ1nQGRoKtaQ4jlLfTO3o4BqyaaATG
         bHwQ20swffvquXAmAO5Y9WbuPnpoH3Y3TAtFYmR2T+ykMBeboDNBvqTqVMpfAJnTT0jD
         EiqRAU04eJQVHuS4/lKx9krzDvs5IwFH4CSHDVyQ2Ei3zXX4aVlirnofwpmCcwls14rD
         uDtWUcjQxIZhyp+bIKir2xzMCW9htGZOGUhbtiAMNJF3oJyHMhhHlVsse2i7XlpR807F
         HFqw==
X-Gm-Message-State: AHYfb5jYfDw552uIGiEj495wpkh1RCEHT14NkcfgCFa35+jXHpFaJne6
        xSuu+zJHfzpfaQ==
X-Received: by 10.84.164.165 with SMTP id w34mr13852493pla.119.1502382317120;
        Thu, 10 Aug 2017 09:25:17 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id s14sm12790921pfj.124.2017.08.10.09.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Aug 2017 09:25:16 -0700 (PDT)
Date:   Thu, 10 Aug 2017 11:25:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
Message-ID: <20170810162515.qkmhcnsaoh4wjrzs@rob-hp-laptop>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
 <20170802093429.12572-5-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802093429.12572-5-jonas.gorski@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59475
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

On Wed, Aug 02, 2017 at 11:34:25AM +0200, Jonas Gorski wrote:
> Codify using a named clock for the refclk of the uart. This makes it
> easier if we might need to add a gating clock (like present on the
> BCM6345).
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
>  drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
