Return-Path: <SRS0=Zu9z=PB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB5C43613
	for <linux-mips@archiver.kernel.org>; Mon, 24 Dec 2018 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B9621850
	for <linux-mips@archiver.kernel.org>; Mon, 24 Dec 2018 13:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbeLXNmV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:42:21 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:38512 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbeLXNmV (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 24 Dec 2018 08:42:21 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 484874BE6C;
        Mon, 24 Dec 2018 14:42:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 4u73sO20wN8S; Mon, 24 Dec 2018 14:42:17 +0100 (CET)
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
To:     Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Cc:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
References: <20181223225224.23042-1-hauke@hauke-m.de>
 <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
Date:   Mon, 24 Dec 2018 14:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 12/24/18 10:03 AM, Kevin 'ldir' Darbyshire-Bryant wrote:
> 
> 
>> On 23 Dec 2018, at 22:52, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>
>> Many MIPS CPUs have optional CPU features which are not activates for
>> all CPU cores. Print the CPU options which are implemented in the core
>> in /proc/cpuinfo. This makes it possible to see what features are
>> supported and which are not supported. This should cover all standard
>> MIPS extensions, before it only printed information about the main MIPS
>> ASEs.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> 
> Hi Hauke (& lists)
> 
> Apologies if I speak out of turn and/or ignorance.
> 
> The problem I have with this is that cpu_has_foo macros can (and often are in openwrt) overridden in by cpu-feature-overrides.h (e.g. arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h) and thus the info shown represents features that the kernel is capable of using and not features that the cpu core is actually capable.
> 
> As you know we ended up printing cpu config registers to be sure of what the cpu was really (in theory) capable vs features that had been masked out due to overrides (and to cut a very long story short, found them to be the same in the end but they may not have been)

Hi Kevin,

Normally you should not deactivate any features in 
cpu-feature-overrides.h which are supported by the CPU, when you do not 
define any thing the kernel will use auto detection.

I think we should use the cpu_has_foo features as these are the features 
which could be used by user space applications, if it is only 
accidentally deactivated by the kernel, which should not happen, it 
could be that this feature is not fully set up by the kernel and will 
not work.

Hauke
