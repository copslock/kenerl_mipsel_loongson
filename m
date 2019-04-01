Return-Path: <SRS0=1rl1=SD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF127C43381
	for <linux-mips@archiver.kernel.org>; Mon,  1 Apr 2019 07:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AAB20896
	for <linux-mips@archiver.kernel.org>; Mon,  1 Apr 2019 07:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfDAHVc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:21:32 -0400
Received: from nbd.name ([46.4.11.11]:52262 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfDAHVc (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 1 Apr 2019 03:21:32 -0400
Received: from p548c8605.dip0.t-ipconnect.de ([84.140.134.5] helo=[192.168.45.69])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hArG6-0000oH-6q; Mon, 01 Apr 2019 09:21:30 +0200
Subject: Re: [RFC 0/5] MIPS: ralink: peripheral clock gating driver
To:     NOGUCHI Hiroshi <drvlabo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
References: <20190330123317.16821-1-drvlabo@gmail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <7df016e7-afad-2345-a4e6-e527bc578c59@phrozen.org>
Date:   Mon, 1 Apr 2019 09:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190330123317.16821-1-drvlabo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 30/03/2019 13:33, NOGUCHI Hiroshi wrote:
> This series introduce Mediatek/Ralink SoC's clock gating driver.
> The gating clock items are different at individual SoCs.
> Driver loads gating clock item table defined in individual SoC source files,
> via OF device id data.

Hi,

I am not an expert on clk drivers but looks good at first glance. should 
the main driver not go into drivers/clk/ ?

     John



> NOGUCHI Hiroshi (5):
>    mips: ralink: add rt2880-clock driver
>    mips: ralink: add dt-binding document for rt2880-clock driver
>    mips: ralink: mt7620/76x8 use clk framework and rt2880-clock driver
>    mips: ralink: mt7628: add nodes for clock provider
>    mips: ralink: mt7620: add nodes for clock provider
>
>   .../bindings/clock/ralink,rt2880-clock.txt    |  20 +++
>   arch/mips/boot/dts/ralink/mt7620a.dtsi        |  34 ++++-
>   arch/mips/boot/dts/ralink/mt7628a.dtsi        |  37 +++++
>   arch/mips/ralink/Kconfig                      |   6 +
>   arch/mips/ralink/Makefile                     |   2 +
>   arch/mips/ralink/clk.c                        |  30 ++++
>   arch/mips/ralink/common.h                     |   3 +
>   arch/mips/ralink/mt7620.c                     | 132 ++++++++++++++---
>   arch/mips/ralink/rt2880-clk_internal.h        |  21 +++
>   arch/mips/ralink/rt2880-clock.c               | 134 ++++++++++++++++++
>   include/dt-bindings/clock/mt7620-clk.h        |  17 +++
>   11 files changed, 411 insertions(+), 25 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
>   create mode 100644 arch/mips/ralink/rt2880-clk_internal.h
>   create mode 100644 arch/mips/ralink/rt2880-clock.c
>   create mode 100644 include/dt-bindings/clock/mt7620-clk.h
>
