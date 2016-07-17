Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jul 2016 14:28:49 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33539 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992420AbcGQM2mpEwp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jul 2016 14:28:42 +0200
Received: by mail-pa0-f65.google.com with SMTP id q2so9219163pap.0
        for <linux-mips@linux-mips.org>; Sun, 17 Jul 2016 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofmoSTaH3EWurezsGH2E5hkWxTsiu997YDddrbAopEc=;
        b=cmPCCOo/1l48ojNuSO50vDUhmLDx+CdqML3PsOPZWeTjprLK+JgnTqlAlP7sCrHQBt
         JDA26CALuOgQGAs0uQ9bd/MB+JMRngBdgW9Hu6fhnK/vnVOMjcNNqhyeA74ur4CUTXSq
         IYLYb+1C991B6nPO8bJOs/rw1kTTxInex17vRd9IHLwGATKHMzJZK52GNphRaeuImTAg
         a/omi5qpXdPAZRDRSvaqSCnPxBxtUS7crqvRr8Sya13S0fxW1b39KMBh+5eNzOtUp/lB
         iLhR5OFuCS+7IPB0GhjKkTl2PfQhfc8fqCFatpSsfDF6KhnnmGLkZMNdEw7sP3OmPHLU
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofmoSTaH3EWurezsGH2E5hkWxTsiu997YDddrbAopEc=;
        b=HZLVr7aeuyGboofnqQbFTt4Ot6OALh/krWKG+iHSknSVX/bmNEo7fY4uFzZNq+W7Zy
         iykHKZoIbRxb+UVxbs5fbmAaPaWRd0Tn6b+Fv3i0S40iZhFDKtzLbC8J7gL2hFkp8qyH
         X6ANHgHFKHYCvsvYssI8GfXNc9HZy+PI0OIxx1ixZqNhaXtB+d1c/pXPlQpwfZKtZa+O
         gDymPOJYe+Ep0Vk5hlxBHLAXrVo1ggKyyZb5mzmH9d6plMD9ymFNBeLjAWHlJY8Z60/g
         gBqJjoDuunJoLxLPjCtf/QxxXqgSnUssqFEsARULtGYYTm/GOZu007LmXvoq/P6Hui5e
         eCAw==
X-Gm-Message-State: ALyK8tLUISRJxHUYaGLT6FMLQxg2DismmTzbiaCWRHJRZc6JamU9wMw4tNGLSGw6OFqssA==
X-Received: by 10.66.76.132 with SMTP id k4mr47606855paw.22.1468758516342;
        Sun, 17 Jul 2016 05:28:36 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:8448:14f3:f178:f083? ([2601:645:c200:33:8448:14f3:f178:f083])
        by smtp.gmail.com with ESMTPSA id zk7sm2608962pac.41.2016.07.17.05.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2016 05:28:35 -0700 (PDT)
Message-ID: <1468758512.6100.10.camel@chimera>
Subject: Re: [PATCH v2 2/2] MIPS: store the appended dtb address in a
 variable
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>
Date:   Sun, 17 Jul 2016 05:28:32 -0700
In-Reply-To: <1466414857-30456-3-git-send-email-jogo@openwrt.org>
References: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
         <1466414857-30456-3-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Mon, 2016-06-20 at 11:27 +0200, Jonas Gorski wrote:
> Instead of rewriting the arguments to match the UHI spec, store the
> address of a appended or UHI supplied dtb in fw_supplied_dtb.
> 
> That way the original bootloader arugments are kept intact while still
> making the use of an appended dtb invisible for mach code.
> 
> Mach code can still find out if it is an appended dtb by comparing
> fw_arg1 with fw_supplied_dtb.
> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
> v1 -> v2:
>  * no changes
> 
>  arch/mips/ath79/setup.c          |  4 ++--
>  arch/mips/bmips/setup.c          |  4 ++--
>  arch/mips/include/asm/bootinfo.h |  4 ++++
>  arch/mips/kernel/head.S          | 21 ++++++++++++++-------
>  arch/mips/kernel/setup.c         |  4 ++++
>  arch/mips/lantiq/prom.c          |  4 ++--
>  arch/mips/pic32/pic32mzda/init.c |  4 ++--
>  7 files changed, 30 insertions(+), 15 deletions(-)
[snip]
> -       else if (fw_arg0 == -2) /* UHI interface */
> -               dtb = (void *)fw_arg1;
> +       else if (fw_passed_dtb) /* UHI interface */
> +               dtb = (void *)fw_passed_dtb;

I just now realized that this is also incorrect, on each platform. The
check for fw_passed_dtb should be in addition (prior) to checking for
UHI via fw_arg0 == -2, not instead of it.

A side effect of correcting this would be that the original questionable
line for pic32 could be left intact, with an unrelated check for
fw_passed_dtb before it that doesn't look at fw_arg2.
