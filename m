Return-Path: <SRS0=qONA=ZD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F2C43331
	for <linux-mips@archiver.kernel.org>; Mon, 11 Nov 2019 10:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2028D20856
	for <linux-mips@archiver.kernel.org>; Mon, 11 Nov 2019 10:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573469340;
	bh=6qF9lfGqcAEtaITcpF6AnIe4UGdU10sDt/eR/ySEBFE=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=zAbZUS/ITm6cCGMeUZcN9pU5fvY1z5GkAVNXxHdwMdN1q11ybBF9NRw/kIKyOtzn3
	 O3C6HddUxONeJEHz1dpi1jxlpjgvgrFmmOt0i8k+eK7YgjE2UYc2LEtPtjwV4bgF7R
	 QW0/Gx0VNd60PwQE38JLGrAFcjODEVerUSgG2Cjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKKs7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:48:59 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:44170 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbfKKKs7 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 11 Nov 2019 05:48:59 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iU7Fg-0008M4-IU; Mon, 11 Nov 2019 11:48:56 +0100
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Subject: Re: [PATCH 1/5 v6] irqchip: ingenic: Drop redundant  =?UTF-8?Q?irq=5Fsuspend=20/=20irq=5Fresume=20functions?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Nov 2019 11:58:17 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jason@lakedaemon.net>, <paul.burton@mips.com>,
        <allison@lohutok.net>, <syq@debian.org>, <rfontana@redhat.com>,
        <tglx@linutronix.de>, <paul@crapouillou.net>
In-Reply-To: <1570859630-50942-2-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
 <1570859630-50942-1-git-send-email-zhouyanjie@zoho.com>
 <1570859630-50942-2-git-send-email-zhouyanjie@zoho.com>
Message-ID: <3b0cfb0e2cc41d8c7aeaa5d732ffc600@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: zhouyanjie@zoho.com, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, jason@lakedaemon.net, paul.burton@mips.com, allison@lohutok.net, syq@debian.org, rfontana@redhat.com, tglx@linutronix.de, paul@crapouillou.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 2019-10-12 07:03, Zhou Yanjie wrote:
> From: Paul Cercueil <paul@crapouillou.net>
>
> The same behaviour can be obtained by using the 
> IRQCHIP_MASK_ON_SUSPEND
> flag on the IRQ chip.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>

Series applied to irqchip-next.

         M.
-- 
Jazz is not dead. It just smells funny...
