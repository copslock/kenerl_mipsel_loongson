Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 18:34:12 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34974 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827496Ab3BOReIEGQkW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 18:34:08 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FNsfY4pkyuxG for <linux-mips@linux-mips.org>;
        Fri, 15 Feb 2013 18:33:57 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 112A22801AE
        for <linux-mips@linux-mips.org>; Fri, 15 Feb 2013 18:33:56 +0100 (CET)
Message-ID: <511E7188.6000208@openwrt.org>
Date:   Fri, 15 Feb 2013 18:34:00 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 11/11] MIPS: ath79: add support for the Qualcomm Atheros
 AP136-010 board
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-12-git-send-email-juhosg@openwrt.org> <511E5BF9.9070208@openwrt.org>
In-Reply-To: <511E5BF9.9070208@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 35773
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

2013.02.15. 17:02 keltezéssel, John Crispin írta:
> On 15/02/13 15:38, Gabor Juhos wrote:
>> +    ATH79_MACH_AP136_010,        /* Atheros AP136-010 reference board */
> 
> Hi,
> 
> just because i am curious ... why the AP136_010 the rest of the code uses AP136
> with no suffix

The rest of the code can be used as-is on the AP136-020 board as well. AFAIK,
the main difference between the two versions is that the ethernet switch is
connected differently to the SoC. Although we don't have ethernet support yet,
but once that is added the setup code for the two boards will be different.

Although it would be possible to remove the '010' part for now, but then it
should be added later again.

-Gabor
