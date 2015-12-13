Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:44:59 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35244 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008764AbbLMWo55Zta9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:44:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=CXQQqcQFrcA4Y/WJSrKptUPPz3NMZMA2yULp0XmJKvQ=;
        b=TaR4005etUghqhqzYuz1UFmLfW7smr2l3tndPOVNZjkrPyd8bWioGaAE387/aFm6G2Ujh7pfJeszho/c9gVOcRH3oVXQ52nCfW34eOYZZhPgXwCxfbU/AhTQBsn/BnyuZNzX4hIExyxrOVkUcFBloS5LHm+o931AN5OHxKWleGTb8SssIe2AI+sv3KEX7pzpJwzBEJmKcY4fXbWgFOmoM+MKgF+xb739JibmrGOX8VrPAbIYTPxn+c6svMgSujSYP4sho3kWe/CNAzTTk0kzZ8rdAVlSulGPVVE2mKbYU4LTzE15Yihv//xuYseOGukX27LoYXkYXAxa+2Jfga/EoA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44490 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FNv-0003ml-OT (Exim); Sun, 13 Dec 2015 22:44:56 +0000
Subject: Re: [PATCH linux-next v4 00/11] mtd: bcm63xxpart: Add NAND
 partitioning support
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
References: <566DF43B.5010400@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566DF4E6.3030702@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:44:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <566DF43B.5010400@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50572
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

On 13/12/15 22:42, Simon Arlott wrote:
> The BCM963xx NAND flash boards have a different handling of the
> partition layout from the NOR flash boards. For NAND there are offsets
> for the partitions in nvram. Both types of boards use the same CFE
> bootloader, nvram format and image tag in their rootfs partitions.
> 
> This patch series:
> 1-4:  Creates separate header files for bcm963xx_nvram and bcm_tag structures
> 5:    Updates the bcm_tag field image_sequence
> 6:    Removes the dependency on mach-bcm63xx from the bcm63xxpart parser
> 7:    Removes unused mach-bcm63xx nvram function
> 8-10: Cleanup and move NOR flash layout to a separate function
> 11:   Add NAND flash layout support

These patches are also available on github against next-20151211:
https://github.com/lp0/linux/commits/20151213-bcm63xxpart-v4

(Yes I am aware that the summary line and description of the patches are
not suitable for merging.)

-- 
Simon Arlott
