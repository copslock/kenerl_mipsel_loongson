Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 18:40:28 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:40076 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6839460Ab3HUQkYebzJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 18:40:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 392C64024F6;
        Wed, 21 Aug 2013 18:40:19 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GUERWo2s+jCi; Wed, 21 Aug 2013 18:40:19 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 0ABA74024D0;
        Wed, 21 Aug 2013 18:40:18 +0200 (CEST)
Message-ID: <5214ED85.1030804@openwrt.org>
Date:   Wed, 21 Aug 2013 18:40:37 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: ath79: Avoid using unitialized 'reg' variable
References: <1377082042-4219-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1377082042-4219-1-git-send-email-markos.chandras@imgtec.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37631
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

2013.08.21. 12:47 keltezéssel, Markos Chandras írta:
> Fixes the following build error:
> arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
> arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
> In file included from arch/mips/ath79/common.c:20:0:
> arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
> arch/mips/include/asm/mach-ath79/ath79.h:139:20:
> error: 'reg' may be used uninitialized in this function
> [-Werror=maybe-uninitialized]
> arch/mips/ath79/common.c:90:6: note: 'reg' was declared here
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Acked-by: Gabor Juhos <juhosg@openwrt.org>

Thanks!

-Gabor
