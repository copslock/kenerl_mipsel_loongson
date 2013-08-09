Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 17:09:20 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43980 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815858Ab3HIPJNANTVo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 17:09:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id B12A842192F;
        Fri,  9 Aug 2013 17:09:07 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AZntTaL3tL1j; Fri,  9 Aug 2013 17:09:07 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 5FF5A42192E;
        Fri,  9 Aug 2013 17:09:07 +0200 (CEST)
Message-ID: <52050633.8010806@openwrt.org>
Date:   Fri, 09 Aug 2013 17:09:39 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/2] GPIO: MIPS: ralink: add gpio driver for ralink SoC
References: <1375954733-30675-1-git-send-email-blogic@openwrt.org> <1375954733-30675-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375954733-30675-2-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37496
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

2013.08.08. 11:38 keltezéssel, John Crispin írta:
> Add gpio driver for Ralink SoC. This driver makes the gpio core on
> RT2880, RT305x, rt3352, rt3662, rt3883, rt5350 and mt7620 work.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-gpio@vger.kernel.org

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
