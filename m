Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Feb 2016 14:49:08 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:47707 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011099AbcBNNtGxFoiZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Feb 2016 14:49:06 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q39024nbTz3hjNp;
        Sun, 14 Feb 2016 14:49:06 +0100 (CET)
X-Auth-Info: nbiMGZasqIo8c+zf8gGu15n588Jw1Y2RTR3dXf0ma08=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q39015jtYzvdWV;
        Sun, 14 Feb 2016 14:49:05 +0100 (CET)
Message-ID: <56C084C4.8000509@denx.de>
Date:   Sun, 14 Feb 2016 14:44:36 +0100
From:   Marek Vasut <marex@denx.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>
Subject: Re: [PATCH 03/10] MIPS: ath79: Fix the ar724x clock calculation
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com> <1455400697-29898-4-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455400697-29898-4-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marex@denx.de
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

On 02/13/2016 10:58 PM, Antony Pavlov wrote:
> From: Weijie Gao <hackpascal@gmail.com>
> 
> According to the AR7242 datasheet section 2.8, AR724X CPUs use a 40MHz
> input clock as the REF_CLK instead of 5MHz.

Can't the AR71xx also use 25MHz clock source ?

> The correct CPU PLL calculation procedure is as follows:
> CPU_PLL = (FB * REF_CLK) / REF_DIV / 2.

[...]
