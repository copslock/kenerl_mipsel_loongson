Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 06:13:19 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:49165 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823033Ab2KMFNSjm3kO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 06:13:18 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 75F836253;
        Mon, 12 Nov 2012 22:14:26 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:4c64:ca41:c8bc:4ee5])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 48F78E40EF;
        Mon, 12 Nov 2012 22:13:17 -0700 (MST)
Message-ID: <50A1D6ED.50001@wwwdotorg.org>
Date:   Mon, 12 Nov 2012 22:13:17 -0700
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
Subject: Re: [RFC] MIPS: BCM63XX: enable serial through Device Tree
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-16-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1352638249-29298-16-git-send-email-jonas.gorski@gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34978
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
> Enable serial through Device Tree board files instead of legacy
> board files.

> diff --git a/arch/mips/bcm63xx/dts/96328avng.dts b/arch/mips/bcm63xx/dts/96328avng.dts

>  	ubus@10000000 {
>  
> +		serial@100 {

Very minor nit: Why the blank line there?

> +			status = "ok";
> +		};
>  	};
>  };
