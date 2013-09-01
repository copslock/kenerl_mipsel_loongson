Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Sep 2013 20:43:49 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:49573 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823068Ab3IASnqqO48W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Sep 2013 20:43:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 19085440265;
        Sun,  1 Sep 2013 20:43:41 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yKOnpSUPpxqF; Sun,  1 Sep 2013 20:43:41 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id CB2594401F8;
        Sun,  1 Sep 2013 20:43:39 +0200 (CEST)
Message-ID: <52238B08.3020408@openwrt.org>
Date:   Sun, 01 Sep 2013 20:44:24 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ralink: add RESET_CONTROLLER to the defconfig
References: <1378057127-21984-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1378057127-21984-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37732
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

2013.09.01. 19:38 keltezéssel, John Crispin írta:
> Without this symbol being set, we get an undefined symbol compile error.

The reset framework is unconditionally used by the ralink platform code. So I
assume that the compile error is also present on rt288x, rt3883 and mt7620.

Maybe it would be better to add a 'select RESET_CONTROLLER' for the RALINK
symbol in 'arch/mips/Kconfig'?

BTW, I have looked into your 'MIPS: ralink: add support for reset-controller
API' patch [1] again. That adds a 'select ARCH_HAS_RESET_CONTROLLER' to the
MACH_VR41XX symbol instead of RALINK.

-Gabor

1. https://patchwork.linux-mips.org/patch/5668/
