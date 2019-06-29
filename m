Return-Path: <SRS0=b6Em=U4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A97C4321A
	for <linux-mips@archiver.kernel.org>; Sat, 29 Jun 2019 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0AB214DA
	for <linux-mips@archiver.kernel.org>; Sat, 29 Jun 2019 09:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF2JHp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 29 Jun 2019 05:07:45 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:29448 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfF2JHo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 29 Jun 2019 05:07:44 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C8E2C4F5FD;
        Sat, 29 Jun 2019 11:07:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id pYrem8_esLLX; Sat, 29 Jun 2019 11:07:40 +0200 (CEST)
Subject: Re: [PATCH 5/8 v2] MIPS: ralink: mt7628a.dtsi: Add I2C controller DT
 node
To:     Paul Burton <paul.burton@mips.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        John Crispin <john@phrozen.org>
References: <20190527091323.4582-1-sr@denx.de>
 <20190527091323.4582-5-sr@denx.de>
 <20190528204119.g7kvutxcprhwo56d@pburton-laptop>
 <96f6564a-e45b-a082-4682-c81dde8d22d5@denx.de>
 <20190624212431.lopvs57iondijlyh@pburton-laptop>
 <20190624220729.GA8885@kunai>
From:   Stefan Roese <sr@denx.de>
Message-ID: <a0300e23-4b81-a9a1-a481-255368c7eccc@denx.de>
Date:   Sat, 29 Jun 2019 11:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190624220729.GA8885@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

On 25.06.19 00:07, Wolfram Sang wrote:
> 
>> OK, I don't see the driver queued up yet so in the meantime I've applied
>> patches 1-4 & 6-7. If you could ping me or resend this one once the I2C
>> binding is in-tree, that would be wonderful.
> 
> I was waiting for Rob's ack for the driver, but with the merge window
> coming, I will apply it tomorrow. The bindings are simple enough.

The I2C driver is now available in linux-next. Could you please
push this patch too?

Thanks,
Stefan
