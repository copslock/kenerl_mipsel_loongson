Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Feb 2016 14:49:25 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:41499 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011451AbcBNNtI2LJwZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Feb 2016 14:49:08 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q39042NQcz3hjNn;
        Sun, 14 Feb 2016 14:49:08 +0100 (CET)
X-Auth-Info: gkcqvdMoruvJf7/MOZocXVN0QTvxRTtFQReG6VHu9wM=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q39033RnszvdWV;
        Sun, 14 Feb 2016 14:49:07 +0100 (CET)
Message-ID: <56C0851D.5090105@denx.de>
Date:   Sun, 14 Feb 2016 14:46:05 +0100
From:   Marek Vasut <marex@denx.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop
 unused alias node
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com> <1455400697-29898-6-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455400697-29898-6-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52044
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
> The TP-LINK TL-WR1043ND board has only one serial port,
> so replacing the default of 0 with 0 does nothing useful.

I'd suggest to keep the aliases node, since it can be used by other
non-Linux systems to access the serial port 0 . This might be useful in
case you add some additional UART chip(s) too.

[...]
