Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2012 00:30:32 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:37076 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902129Ab2FQWa1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2012 00:30:27 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3WFqrT20Khz4LDdr;
        Mon, 18 Jun 2012 00:30:16 +0200 (CEST)
Received: from igel.home (ppp-93-104-152-241.dynamic.mnet-online.de [93.104.152.241])
        by mail.mnet-online.de (Postfix) with ESMTPA id 3WFqrS57K4z4KK6v;
        Mon, 18 Jun 2012 00:30:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
        id 4D803CA2A5; Mon, 18 Jun 2012 00:30:16 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Chris Zankel <chris@zankel.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Build regressions/improvements in v3.5-rc3
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
        <1339969995.9220.242.camel@pasglop>
X-Yow:  Did you move a lot of KOREAN STEAK KNIVES this trip, Dingy?
Date:   Mon, 18 Jun 2012 00:30:16 +0200
In-Reply-To: <1339969995.9220.242.camel@pasglop> (Benjamin Herrenschmidt's
        message of "Mon, 18 Jun 2012 07:53:15 +1000")
Message-ID: <m2vcip4lmv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 33683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2012-06-17 at 21:56 +0200, Geert Uytterhoeven wrote:
>> Truckloads of powerpc "Unrecognized opcode" breakage, and
>
> Where ? The boot wrappers again ?

<http://permalink.gmane.org/gmane.linux.kernel/1312778>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
