Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 06:51:48 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:33394
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeDWEvmMQzCx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Apr 2018 06:51:42 +0200
Received: by mail-wr0-x241.google.com with SMTP id z73-v6so37353272wrb.0;
        Sun, 22 Apr 2018 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FZzbnIfmEocSgPlmvl6hPpRbV7o9w/ayXyBPE99Ql/c=;
        b=SrSLUg4PZjPyNpxOMNnk1HP/qNwaPf3JtepGuVMg+2knBgEFO5zEsOMwXEl7lUvuTA
         B4o7fIF2tZhKcizeW+nQ6Jy3b29M61gawpSmmhXz7HrblC9OHPvsZLfz1NxdEoSKRXzV
         dR03plC+w0A2QYc/7UzGf4K+A2o/VwH29puM8Zl6LIXH3LUqTI9IsHNuRFKfY3bN0P1l
         AQsABJNcUS9QRYy49H8ChFFKsd47FEuY32hToPTpXlhtJd4YsxhxTBx2u46EKHR4OEk0
         qKPlus6l4PzsH/ir8sB9c+VMbJVuIDE25y3QfmticFUpuLa19t6bgnL+wzLwGnJ50H8r
         RzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FZzbnIfmEocSgPlmvl6hPpRbV7o9w/ayXyBPE99Ql/c=;
        b=KL4RiTECxp3APj1OAJlirVYTDkH6UamF0ZpbdcQEMRFKXw0cfibhgk9Q7/R3R76Klo
         wRYE0UQ07cUWdp53q6eZWpvZzQP+z27wOVwtGJArt4FEaQBbBIYsemNAbBVeC8COPTdA
         Xez0nB5d33Jcn7bWIJWUbXwF08zLNCzz6Ze2yPzQzq8HgENYrVZqT8yfj456yXvEBghw
         bF19gIEpBIQChSLvFj2NSxZaO3OZCHejYE8iUQfsUcv9IujaMmL6sJYS7HGKawQJNScM
         5yo2emmZ8EidFL1K0Yn4w9FlyZVk5nfdL3RENGNCzt0W2zWUlvAB94Lhl8colRM4R/VP
         nVPg==
X-Gm-Message-State: ALQs6tCJMZfADyfbSctsdgWhpcy690KQWdOJgLsS8n2HWMTvd4N29m2V
        +U9WJzypcyaTrim89LhszwVRLuW7UXX1pehlDXc=
X-Google-Smtp-Source: AIpwx4+Kh9GOiaDmvDcV/hICFhyXTIpZrLpTxXq6BVjkWsPBdEN7t6WvZ/xdZ0EUxAM2aqr2jUdyCFQsz2yqKg+gprU=
X-Received: by 10.28.213.198 with SMTP id m189mr7991869wmg.28.1524459096410;
 Sun, 22 Apr 2018 21:51:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.181.1 with HTTP; Sun, 22 Apr 2018 21:51:35 -0700 (PDT)
In-Reply-To: <20180323225807.13386-1-zajec5@gmail.com>
References: <20180323225807.13386-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 23 Apr 2018 06:51:35 +0200
Message-ID: <CACna6ryoYs75Pt7qXSuozZsEt27YMyJAhvF21QRLQVuryn_dZA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Use __initdata for the bcm47xx_leds_pdata
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, James Hogan <jhogan@kernel.org>,
        Dan Haab <riproute@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 23 March 2018 at 23:58, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
>
> This struct variable is used during init only. It gets passed to the
> gpio_led_register_device() which creates its own data copy. That allows
> using __initdata and saving some minimal amount of memory.
>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

James, would you care to take this trivial patch?
