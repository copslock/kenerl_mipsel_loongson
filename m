Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 06:12:37 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:37619 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823033Ab2KMFMgyexht (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 06:12:36 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 7ED8D6234;
        Mon, 12 Nov 2012 22:13:44 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:4c64:ca41:c8bc:4ee5])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 4160FE40EF;
        Mon, 12 Nov 2012 22:12:35 -0700 (MST)
Message-ID: <50A1D6C3.2010108@wwwdotorg.org>
Date:   Mon, 12 Nov 2012 22:12:35 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] MIPS: BCM63XX: add empty Device Trees for all supported
 boards
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-15-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1352638249-29298-15-git-send-email-jonas.gorski@gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 11/11/2012 05:50 AM, Jonas Gorski wrote:
> Add empty board files for all boards supported by the legacy board
> support.

> diff --git a/arch/mips/bcm63xx/dts/96328avng.dts b/arch/mips/bcm63xx/dts/96328avng.dts

> +/ {
> +	model = "96328avng";
> +	compatible = "96328avng";

The board should be compatible with both the board name and the SoC on
the board. I know that right now the MIPS code is choosing the DT to use
based on the board name, but I think it's more typical to pass an
explicit DT to the kernel, and then choose the kernel support to execute
based on the compatible value (certainly this is the case on ARM and I
assume other architectures too). That would require the DT content to
include the SoC name in the compatible property, so that the kernel
support didn't then need to contain a table of all supported board names.

> +	ubus@10000000 {
> +
> +	};

Do you need to include this empty node in each file? I guess it gets
added to in the next patch so it's not a big deal though.

> diff --git a/arch/mips/bcm63xx/dts/Kconfig b/arch/mips/bcm63xx/dts/Kconfig

> +config BOARD_96328AVNG
> +	bool "96328avng reference board"
> +	select BCM63XX_CPU_6328

Why not simply compile all DTs whenever the SoC support is enabled? I
suppose you're trying to avoid packing all the DTs into the kernel
image. Does it make more sense to amend the MIPS kernel boot process so
that a single user-/firmware-selected DT is passed to the kernel, rather
than packing the DTs into the kernel and selecting one?
