Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:22:17 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:57588 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab2BWQWO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:22:14 +0100
Message-ID: <4F4667A8.9090704@openwrt.org>
Date:   Thu, 23 Feb 2012 17:22:00 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: lantiq: add ipi handlers to make vsmp work
References: <1330013092-13815-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330013092-13815-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 23/02/12 17:04, John Crispin wrote:
> Add IPI handlers to the interrupt code. This patch makes MIPS_MT_SMP work
> on lantiq SoCs.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Hi Ralf,

This patch sort of duplicates code from mti-malta
I would welcome if this patch got merged as is.
I promise to send a more geneirc fix in a later series, which will
remove the code redundancy and make the ipi handlers available for other
targets that have no gic.

thx,
John
