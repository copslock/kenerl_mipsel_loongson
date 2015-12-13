Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:42:16 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35194 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008361AbbLMWmOHGKu9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To; bh=qIBCtzj3nz7gwb6rpHBlxSutyr0iJsYbTqFhCau0tlE=;
        b=I5HSYnGzO7IHc9GOY6PdDGQkc7/uriwApFX/i7JMC39NpfvwxdPNLHgn8cBFogktWR0YkwdP4RigmV3SvAmwNhzUCf0+9D6zlOJ8i+4+gL994+C2H3EnkEzNZoYTfqihW77ZeBRVGoSVbWq779ewVvH+0gvmQ81uQ4WUWagu0FFIApawVQiitIKhl7TTQm2nf/44ihBxcealARLphlLOIjA32Dj+JK69vr7fplv1tjyvJ7BrbP7vkOmIY+R7mI2iOfLPPyQ+pXc/np/NBxqFVzrt4mlSI1nw0HlIuiqH5vFAOXLoPeErQeRbQpuqKWAZv5V4Wb+SS790sqTERqJ3eQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44458)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FLC-0003hl-NE (Exim); Sun, 13 Dec 2015 22:42:07 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: [PATCH linux-next v4 00/11] mtd: bcm63xxpart: Add NAND partitioning
 support
Message-ID: <566DF43B.5010400@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:42:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

The BCM963xx NAND flash boards have a different handling of the
partition layout from the NOR flash boards. For NAND there are offsets
for the partitions in nvram. Both types of boards use the same CFE
bootloader, nvram format and image tag in their rootfs partitions.

This patch series:
1-4:  Creates separate header files for bcm963xx_nvram and bcm_tag structures
5:    Updates the bcm_tag field image_sequence
6:    Removes the dependency on mach-bcm63xx from the bcm63xxpart parser
7:    Removes unused mach-bcm63xx nvram function
8-10: Cleanup and move NOR flash layout to a separate function
11:   Add NAND flash layout support

Patches 1-2 tested on BCM63XX with a BCM963168 (NAND) board.
Patches 3-11 compile tested on BCM63XX.
Patches 6-11 tested on BMIPS with a BCM963168 (NAND) board.
---
v4: Move struct bcm_tag to include/linux/.

    Modify bcm63xx parser to read nvram from NOR flash and handle the
    NAND flash layout in the same parser.

v3: Fix includes/type names, add comments explaining the nvram struct.

    Use COMPILE_TEST.

    Ensure that strings read from flash are null terminated and validate
    bcm_tag integer values (this also moves reporting of rootfs sequence
    numbers to later on).

v2: Use external struct bcm963xx_nvram definition for bcm963268part.

    Removed support for the nand partition number field, it's not a
    standard Broadcom field (was added by MitraStar Technology Corp.).

-- 
Simon Arlott
