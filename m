Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 01:18:24 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:27940 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993354AbeGUXSVPSaUR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 01:18:21 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 4DAAA413F2;
        Sun, 22 Jul 2018 01:18:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id yClWGsUpp9hu; Sun, 22 Jul 2018 01:18:13 +0200 (CEST)
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
To:     John Crispin <john@phrozen.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de>
 <4f39ca41-bcad-4b04-65dd-3570cb3ce804@phrozen.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <617da78b-e5c6-24c8-cf9b-d923da10028c@hauke-m.de>
Date:   Sun, 22 Jul 2018 01:18:12 +0200
MIME-Version: 1.0
In-Reply-To: <4f39ca41-bcad-4b04-65dd-3570cb3ce804@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 07/21/2018 10:25 PM, John Crispin wrote:
> 
> 
> On 21/07/18 21:13, Hauke Mehrtens wrote:
>> + * Copyright (C) 2012 John Crispin<blogic@openwrt.org>
> that is not my mail addr :-)
>     John

Thanks for the information, I fixed your mail address.

Hauke
