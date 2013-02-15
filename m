Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 18:14:06 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:59787 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827496Ab3BOROFqa3Mv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 18:14:05 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7ye8o7HZGIAh for <linux-mips@linux-mips.org>;
        Fri, 15 Feb 2013 18:13:54 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8B8142801AE
        for <linux-mips@linux-mips.org>; Fri, 15 Feb 2013 18:13:54 +0100 (CET)
Message-ID: <511E6CD6.8050503@openwrt.org>
Date:   Fri, 15 Feb 2013 18:13:58 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 08/11] MIPS: ath79: add WMAC registration code for the
 QCA955X SoCs
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-9-git-send-email-juhosg@openwrt.org> <511E5BE9.7010400@openwrt.org>
In-Reply-To: <511E5BE9.7010400@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 35771
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013.02.15. 17:01 keltezéssel, John Crispin írta:
> On 15/02/13 15:38, Gabor Juhos wrote:
>> +    ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
>> +    ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
> Hi,
> 
> second line should read .stop ?

Yes. Although it does not cause problems because only the .start field is used
by ath9k, but it must be fixed of course. Will do it in the next version.

-Gabor
