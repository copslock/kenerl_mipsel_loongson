Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 06:04:38 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:34777 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823033Ab2KMFEiClFC6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 06:04:38 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id A4F7D6253;
        Mon, 12 Nov 2012 22:05:45 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:4c64:ca41:c8bc:4ee5])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 73CDEE40EF;
        Mon, 12 Nov 2012 22:04:36 -0700 (MST)
Message-ID: <50A1D4E4.50308@wwwdotorg.org>
Date:   Mon, 12 Nov 2012 22:04:36 -0700
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
Subject: Re: [RFC] MIPS: BCM63XX: switch to common clock and Device Tree
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-11-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1352638249-29298-11-git-send-email-jonas.gorski@gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34975
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
> Switch BCM63XX to the common clock framework and use clkdev for
> providing clock name lookups for non-DT devices.
> 
> Clocks can have a frequency and gate-bit, or none, in case they
> are just provided for drivers expecting them to be present.

> diff --git a/Documentation/devicetree/bindings/clock/bcm63xx-clock.txt b/Documentation/devicetree/bindings/clock/bcm63xx-clock.txt

A very minor nit, but it might be nice to add the DT binding
documentation before (or as part of) the patches that use them (code
that parses them, or using the bindings in .dts files)

Of course, I'm relying on my email receive order, to judge this since
the patch numbering didn't come through, so perhaps the patches are
already set up this way...
