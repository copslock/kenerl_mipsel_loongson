Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2009 13:04:01 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:32961 "HELO
        imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with SMTP id S1493339AbZLOMD5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Dec 2009 13:03:57 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by imap.sh.mvista.com (Postfix) with SMTP
        id 0F37B3ED2; Tue, 15 Dec 2009 04:03:37 -0800 (PST)
Message-ID: <4B277B09.3080906@ru.mvista.com>
Date:   Tue, 15 Dec 2009 15:03:21 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
References: <200912121757.56365.ffainelli@freebox.fr> <200912141802.13171.ffainelli@freebox.fr> <10f740e80912141105kcccb4e9y68cf47b35bb7a648@mail.gmail.com> <200912150144.04051.ffainelli@freebox.fr>
In-Reply-To: <200912150144.04051.ffainelli@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

> From: Florian Fainelli <ffainelli@freebox.fr>
> Subject: [PATCH v3] MIPS: add readl/write_be accessors
>
> MIPS currently lacks the readl_be and writel_be accessors
> which are required by BCM63xx for OHCI and EHCI support.
> Let's define them globally for MIPS. This also fixes the
> compilation of the bcm63xx defconfig against USB.
>
> Changes from v2:
> - fixed the be/cpu endianness inversion
>
> Changes from v1:
> - make it work on little-endian machines
> - protect macros arguments with parenthesis
>   

   You should have put the description of changes under --- tearline, 
not in the patch description itself.

> Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
> ---

WBR, Sergei
