Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2012 12:38:24 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42296 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901164Ab2ALLiO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2012 12:38:14 +0100
Received: by bkty8 with SMTP id y8so1941641bkt.36
        for <multiple recipients>; Thu, 12 Jan 2012 03:38:09 -0800 (PST)
Received: by 10.204.156.17 with SMTP id u17mr1016317bkw.57.1326368289316;
        Thu, 12 Jan 2012 03:38:09 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-80-144.pppoe.mtu-net.ru. [91.79.80.144])
        by mx.google.com with ESMTPS id t23sm10117116bkv.10.2012.01.12.03.38.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 03:38:08 -0800 (PST)
Message-ID: <4F0EC5E0.4060700@mvista.com>
Date:   Thu, 12 Jan 2012 15:37:04 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH RESEND 16/17] MIPS: make oprofile use cp0_perfcount_irq
 if it is set
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org> <1326314674-9899-16-git-send-email-blogic@openwrt.org>
In-Reply-To: <1326314674-9899-16-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 12-01-2012 0:44, John Crispin wrote:

> The patch makes the oprofile code use the performance counters irq.

> This patch is written by Felix Fietkau.

    Perhaps you should have marked it as "From: Felix Fietkau 
<nbd@openwrt.org>" in the first line of the mail?

> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> Signed-off-by: John Crispin <blogic@openwrt.org>

WBR, Sergei
