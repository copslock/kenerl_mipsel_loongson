Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 17:23:13 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:53152 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993004AbcKUQXGrusnv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 17:23:06 +0100
Received: from odin.home.local (p54B048AB.dip0.t-ipconnect.de [84.176.72.171])
        by h1.direct-netware.de (Postfix) with ESMTPA id 15128FF8BC;
        Mon, 21 Nov 2016 17:23:01 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.1])
        by odin.home.local (Postfix) with ESMTPSA id D8DD062C773;
        Mon, 21 Nov 2016 17:22:46 +0100 (CET)
From:   Tobias Wolf <t.wolf@vplace.de>
To:     linux-mips@linux-mips.org
Cc:     Mathias Kresin <dev@kresin.me>
Subject: [PATCH 0/2] Introduction of patches for CONFIG_MIPS_RAW_APPENDED_DTB (ralink)
Date:   Mon, 21 Nov 2016 17:22:45 +0100
Message-ID: <34413663.tGaeXtuGnb@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.8-2-ARCH; KDE/5.28.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <t.wolf@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: t.wolf@vplace.de
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

While trying to get a vanilla kernel 4.4 running with 
CONFIG_MIPS_RAW_APPENDED_DTB I noticed a hang while booting right after:
CPU0 revision is: 0001906c (MIPS 4KEc)
on a rt288x (ralink) based router (Belkin F5D8235 v1).

Initially I wanted to hunt down another bug described in detail in LEDE 
Flyspray Issue Tracker for that router. [1] Basically all kernels 4.4+ causes 
a kernel crash because of "BUG: Bad page state in process swapper".

Back to the hang for vanilla 4.4:

Analysis showed that initial_boot_params in of_scan_flat_dt() of drivers/of/
fdt.c is never checked before accessed.

In arch/mips/ralink/of.c __dt_setup_arch(__dtb_start) is called without any 
checks right before calling of_scan_flat_dt() as well. Given that 
initial_boot_params is null, that call never returned.

The hang was caused because arch/mips/ralink does not yet support 
fw_passed_dtb and initial_boot_params was null therefore.

As I'm new to the kernel development procedure (thanks for some hints go to 
Mathias Kresin) I'm sending these patches separately afterwards.

Best regards
Tobias Wolf

[1] https://bugs.lede-project.org/index.php?do=details&task_id=244
