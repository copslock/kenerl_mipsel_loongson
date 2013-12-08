Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Dec 2013 19:27:14 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41639 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817179Ab3LHS1M41aD- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Dec 2013 19:27:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 5BC6D8F67;
        Sun,  8 Dec 2013 19:27:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QQVDmFDv20iB; Sun,  8 Dec 2013 19:27:04 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:609b:6857:e4ae:c4e9] (unknown [IPv6:2001:470:1f0b:447:609b:6857:e4ae:c4e9])
        by hauke-m.de (Postfix) with ESMTPSA id 133CC8F66;
        Sun,  8 Dec 2013 19:27:03 +0100 (CET)
Message-ID: <52A4B9F6.3050001@hauke-m.de>
Date:   Sun, 08 Dec 2013 19:27:02 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: MIPS: BCM47XX patch status?
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38681
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

Hi,

there are some long lending patches for BCM47xx which I would like to
see in mainline linux some time. This is the list of patches for the
BCM47xx SoCs I came up with. I haven't seen them in the upstream git
repository [0].

Are there any problems and if so, how can I help with them?


Hauke

[0]: git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git


MIPS: BCM47XX: Fix some very confused types and data corruption
http://patchwork.linux-mips.org/patch/6211/

bcma: gpio: add own IRQ domain
http://patchwork.linux-mips.org/patch/6174/

MIPS: BCM47XX: Prepare support for LEDs
http://patchwork.linux-mips.org/patch/6109/

MIPS: BCM47XX: move constant array from stack
http://patchwork.linux-mips.org/patch/6044/

MIPS: BCM47XX: add asmlinkage to plat_irq_dispatch()
http://patchwork.linux-mips.org/patch/6043/

MIPS: BCM47XX: add EARLY_PRINTK_8250 support
http://patchwork.linux-mips.org/patch/5889/

MIPS: BCM47XX: Remove CFE support
http://patchwork.linux-mips.org/patch/5888/

MIPS: BCM47XX: print board name in machine entry in cpuinfo
http://patchwork.linux-mips.org/patch/5864/

MIPS: BCM47XX: only print SoC name in system type in cpuinfo
http://patchwork.linux-mips.org/patch/5865/

MIPS: BCM47XX: update defconfig
http://patchwork.linux-mips.org/patch/5930/
