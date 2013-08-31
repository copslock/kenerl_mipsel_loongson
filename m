Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Aug 2013 11:40:36 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:51581 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503Ab3HaJkd5542G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Aug 2013 11:40:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E99DA26144F;
        Sat, 31 Aug 2013 11:40:26 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PpOQ2uWbtsDt; Sat, 31 Aug 2013 11:40:26 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7DC0B26143E;
        Sat, 31 Aug 2013 11:40:26 +0200 (CEST)
Message-ID: <5221BA2E.6020002@openwrt.org>
Date:   Sat, 31 Aug 2013 11:41:02 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/6] MIPS: ath79: simplify platform_get_resource_byname/devm_ioremap_resource
References: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr> <1376902316-18520-7-git-send-email-Julia.Lawall@lip6.fr> <52164F54.2070209@openwrt.org> <5221A4C1.90703@phrozen.org>
In-Reply-To: <5221A4C1.90703@phrozen.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.08.31. 10:09 keltezéssel, John Crispin írta:

<snip>

> should this patch go upstream via the lmo tree ?

Yes, I think.

-Gabor
