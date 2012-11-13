Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 06:06:25 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:35119 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823033Ab2KMFGY2y7Yf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 06:06:24 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 190A06254;
        Mon, 12 Nov 2012 22:07:32 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:4c64:ca41:c8bc:4ee5])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id C8E3BE40EF;
        Mon, 12 Nov 2012 22:06:22 -0700 (MST)
Message-ID: <50A1D54E.2090406@wwwdotorg.org>
Date:   Mon, 12 Nov 2012 22:06:22 -0700
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
Subject: Re: [RFC] MIPS: BCM63XX: register GPIO controller through Device
 Tree
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-12-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1352638249-29298-12-git-send-email-jonas.gorski@gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34976
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
> Register the GPIO controller through Device Tree and add the
> appropriate values in the include files.
> 
> Since we can't register a platform driver at this early stage move the
> direct call to bcm63xx_gpio_init from prom_init to an arch initcall.

> diff --git a/Documentation/devicetree/bindings/gpio/bcm63xx-gpio.txt b/Documentation/devicetree/bindings/gpio/bcm63xx-gpio.txt

> +- #gpio-cells: Must be <2>. The first cell is the GPIO pin, and
> +  the second one the standard linux flags.

Also here, I think you want to explicitly document the flag values here
so the bindings don't rely on the Linux kernel code. I don't think
there's a standard central file which documents them though, although I
vaguely recall some discussion to create add them to gpio.txt?
