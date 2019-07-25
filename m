Return-Path: <SRS0=prOJ=VW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC77C76194
	for <linux-mips@archiver.kernel.org>; Thu, 25 Jul 2019 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF6922BED
	for <linux-mips@archiver.kernel.org>; Thu, 25 Jul 2019 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564042909;
	bh=+kIc8WrpgZ5JjOndGs0FKKn9vlsF9xtpjf3kfBTYGTk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jEY0G8hFAx6SKuYml+E2kVQVYoQKbtL3QmM7Y+yh70dz6+57IBpB6pnjTvZB7+Rqu
	 R+pNzyWRm2iAR4K1Ayy7t+VDfurUxCuy+a8r7nHzhhD6LwXke/nOhQn67BFF7GQxvn
	 7l8J/zGNxr42XYnyA9avHT5meElIHfYoV6OoXX4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbfGYIVo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:21:44 -0400
Received: from foss.arm.com ([217.140.110.172]:53574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389405AbfGYIVo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 25 Jul 2019 04:21:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8A8344;
        Thu, 25 Jul 2019 01:21:43 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FEB3F694;
        Thu, 25 Jul 2019 01:21:40 -0700 (PDT)
Subject: Re: [PATCH v15 06/13] irqchip: Add irq-ingenic-tcu driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
References: <20190724171615.20774-1-paul@crapouillou.net>
 <20190724171615.20774-7-paul@crapouillou.net>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <2872522f-c172-849d-81d4-0e573ff52ea8@kernel.org>
Date:   Thu, 25 Jul 2019 09:21:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190724171615.20774-7-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 24/07/2019 18:16, Paul Cercueil wrote:
> This driver handles the interrupt controller built in the Timer/Counter
> Unit (TCU) of the JZ47xx SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Marc Zyngier <maz@kernel.org>

Given the various dependencies, I assume the series will get routed via
the MIPS tree.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
