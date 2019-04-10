Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA72C10F11
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41E5204FD
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 08:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vdorst.com header.i=@vdorst.com header.b="nJ1thTEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfDJIS7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:18:59 -0400
Received: from mx.0dd.nl ([5.2.79.48]:43986 "EHLO mx.0dd.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbfDJIS7 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 10 Apr 2019 04:18:59 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2019 04:18:58 EDT
Received: from mail.vdorst.com (mail.vdorst.com [IPv6:fd01::250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.0dd.nl (Postfix) with ESMTPS id 0E1585FA71;
        Wed, 10 Apr 2019 10:11:25 +0200 (CEST)
Authentication-Results: mx.0dd.nl;
        dkim=pass (2048-bit key; secure) header.d=vdorst.com header.i=@vdorst.com header.b="nJ1thTEk";
        dkim-atps=neutral
Received: from www (www.vdorst.com [192.168.2.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.vdorst.com (Postfix) with ESMTPSA id B7AA118B9448;
        Wed, 10 Apr 2019 10:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.vdorst.com B7AA118B9448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdorst.com;
        s=default; t=1554883884;
        bh=nTWMAyfYpQ7F05eBkGusqktjM8nl1QGebhyGL+m7WBc=;
        h=Date:From:To:Cc:Subject:From;
        b=nJ1thTEka4eQ03pG6ERb0MpuCiajX887+LbVITM6acVt5lWTF84OmwsIhQHk/nSWH
         vaZEfOtiysvgBSJKJMyjWp8Hh0/M3idgdfJHQjvpyu5Ijo6XNyCCAlw3FSpvSHpIuE
         T2q0BE3jttV5xbdnFh71My2hQ5wC4UPigAZyHEBk8PZhnd+QYFWhK5doS1/K42K+R3
         uq0dzo6Q3oYA1thgiBjutVMmfPXeA86OFeLnA+B79hoC00cgoWOCKCBmKtKH6bQeAu
         aTyZpBfAZ8fwoHASPSQOVpiDk4+A+0Vj63sGJ3pOHctfSrNz1sVu/hoPfVIk0k/CCA
         muBM4UPKB652g==
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by
 www.vdorst.com (Horde Framework) with HTTPS; Wed, 10 Apr 2019 08:11:24 +0000
Date:   Wed, 10 Apr 2019 08:11:24 +0000
Message-ID: <20190410081124.Horde.6-W5VZY62-uScLlme86cCYa@www.vdorst.com>
From:   =?utf-8?b?UmVuw6k=?= van Dorst <opensource@vdorst.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices,
 mt7621-clk.h is missing
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Chuanhong,

I tried your patch but include/dt-bindings/clock/mt7621-clk.h is missing.

See the original patch.  
https://github.com/lede-project/source/blob/master/target/linux/ramips/patches-4.14/102-mt7621-fix-cpu-clk-add-clkdev.patch#L205

Can you send an other patch to fix that?

Greats,

René

