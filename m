Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 12:57:04 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34527 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903632Ab2EHK5A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 12:57:00 +0200
Message-ID: <4FA8FBA3.1090803@openwrt.org>
Date:   Tue, 08 May 2012 12:55:31 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Artem Bityutskiy <dedekind1@gmail.com>
CC:     MTD Maling List <linux-mtd@lists.infradead.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mtd: xway_nand: add OF dependency
References: <1336474436-9755-1-git-send-email-dedekind1@gmail.com>
In-Reply-To: <1336474436-9755-1-git-send-email-dedekind1@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/05/12 12:53, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> xway_nand.c requires OF support - add dependency in Kconfig.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Thanks

Acked-by: John Crispin <blogic@openwrt.org>
