Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2011 11:28:54 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:56114 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491882Ab1AKK2u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jan 2011 11:28:50 +0100
Message-ID: <4D2C3120.80602@openwrt.org>
Date:   Tue, 11 Jan 2011 11:29:52 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 06/10] MIPS: lantiq: add NOR flash support
References: <1294257379-417-1-git-send-email-blogic@openwrt.org> <1294257379-417-7-git-send-email-blogic@openwrt.org> <4D2BC787.20002@gmail.com>
In-Reply-To: <4D2BC787.20002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 11/01/11 03:59, Daniel Schwierzeck wrote:
> Hi John,
>
> the EBU doesn't allow unaligned read or write access thus Lantiq added
> this alignment hack directly in hardware. The addr^=2 is only needed
> during CFI probe because odd addresses are accessed. A simple solution
> is inside your patch.
>
> The spin_lock_irqsave(&ebu_lock, flags); is actually not needed
> because the EBU does access arbitration and protection already in
> hardware.
>
> Daniel
>
Hi Daniel,

thx, i will try it out later on and then merge it into v2 of the series.

John
