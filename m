Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 20:15:27 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:51290 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823019Ab2JWSP1AjkJN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 20:15:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 7C4C0BC0;
        Tue, 23 Oct 2012 20:15:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id rnPrwLMuXPSg; Tue, 23 Oct 2012 20:15:20 +0200 (CEST)
Received: from [192.168.178.21] (host-188-174-220-229.customer.m-online.net [188.174.220.229])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id E5CC2BB2;
        Tue, 23 Oct 2012 20:14:53 +0200 (CEST)
Message-ID: <5086DEBB.1030506@metafoo.de>
Date:   Tue, 23 Oct 2012 20:15:23 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120922 Icedove/3.0.11
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [RFC 00/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D
 SOC
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 10/23/2012 07:43 PM, Antony Pavlov wrote:
> AFAIK the single known chip in Ingenic JZ4750D line is JZ4755.
> It has just the same CPU core as JZ4740, but another set of
> peripherals (though the program model for the most
> of the peripherals is the same).
> 
> +-----------------+--------------+--------------+
> |                 |   JZ4755     |    JZ4740    |
> +-----------------+--------------+--------------+
> | UART            |      3       |       4      |
> | MSC (mmc/sd)    |      2       |       1      |
> | GPIO            |     5x32     |      4x32    |
> | TCU (timers)    | 6x16 + 1x32  |      8x16    |
> | USB             |  device 2.0  |   host 1.1   |
> |                 |              |  device 2.0  |
> +-----------------+--------------+--------------+
> 
> The most significant advantage of the JZ4755 chip
> is the second MIPS core dedicated for image processing.
> Also JZ4755 is made with use of more precise technology
> and it can run on the higher clock rate (approx. 433 MHz
> for JZ4755 vs 336 MHz for JZ4740).
> 
> The JZ4755 is used in some game consoles:
> * Ritmix RZX-50;
> * Dingoo A320E/A380;
> * GameLinBox.
> 
> This patch series based on the work of Lars-Peter Clausen.
> To tell the truth it is the Lars-Peter Clausen's patches
> with some fixes and changes.
> 
> As most of the code for JZ4750D is very close to code
> for JZ4740 we can incorporate the code for JZ4750D
> to the code for JZ4740 to avoid code duplication.

Yes, definitely agreed. Most of the peripherals are similar enough that they
can be supported by a shared driver. I actually started working on this some
time ago, but never finished it, because other things took priority.
The code can be found here:
http://projects.qi-hardware.com/index.php/p/qi-kernel/source/tree/jz47xx-2.6.38/arch/mips/jz47xx

The code is based on 2.6.38 and is a bit outdated by now, but I think it gets
the idea over quite well. And most of the patches touching jz47xx related code
are still valid as well.

As for the renaming I'm not so sure if it is really necessary. We often stick
we the name for the driver or architecture version which was first supported by
the kernel and add note in Kconfig and comments that the driver also supports
other version/variants of the peripheral or SoC.

- Lars
