Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Feb 2016 14:49:48 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:39645 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011699AbcBNNtN0j0KZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Feb 2016 14:49:13 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q39063lYfz3hjNp;
        Sun, 14 Feb 2016 14:49:10 +0100 (CET)
X-Auth-Info: cZUqJVvuQBZwQd+aab90WQVCVA5zUK1d33ah7S9CW2Y=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q390516W2zvdWV;
        Sun, 14 Feb 2016 14:49:09 +0100 (CET)
Message-ID: <56C0855C.1060802@denx.de>
Date:   Sun, 14 Feb 2016 14:47:08 +0100
From:   Marek Vasut <marex@denx.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/10] MIPS: dts: qca: ar9132: use short references for
 uart, usb and spi nodes
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com> <1455400697-29898-7-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455400697-29898-7-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52045
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
> Here are some Sascha Hauer's arguments for using aliases in the dts
> files:
> 
>  - using aliases reduces the number of indentations in dts files;
> 
>  - dts files become independent of the layout of the dtsi files
>    (it becomes possible to introduce another bus {} hierarchy between
>    a toplevel bus and the devices when you have to);
> 
>  - less chances for typos. if &i2c2 does not exist you get an error.
>    If instead you duplicate the whole path in the dts file a typo
>    in the path will just create another node.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org

Acked-by: Marek Vasut <marex@denx.de>
