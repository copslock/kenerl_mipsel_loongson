Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 21:56:36 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:49133 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492298Ab0ACU4c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 21:56:32 +0100
Received: from [2001:8b0:10b:1:222:41ff:fe2d:310a]
        by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
        id 1NRXUo-0006OR-N0; Sun, 03 Jan 2010 20:56:19 +0000
Subject: Re: [PATCH 4/4] MTD: include ar7part in the list of partitions
 parsers
From:   David Woodhouse <dwmw2@infradead.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        ralf@linux-mips.org
In-Reply-To: <201001032117.37459.florian@openwrt.org>
References: <201001032117.37459.florian@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 03 Jan 2010 20:56:17 +0000
Message-ID: <1262552177.3181.5891.camel@macbook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 (2.28.2-1.fc12) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org
        See http://www.infradead.org/rpr.html
X-archive-position: 25490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2003

On Sun, 2010-01-03 at 21:17 +0100, Florian Fainelli wrote:
> This patch modifies the physmap-flash driver to include
> the ar7part partition parser in the list of parsers to
> use when a physmap-flash driver is registered. This is
> required for AR7 to create partitions correctly.

Hrm, perhaps we'd do better to allow the probe types to be specified in
the platform physmap_flash_data?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
