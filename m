Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 11:08:11 +0100 (CET)
Received: from osg.samsung.com ([64.30.133.232]:50548 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990410AbeACKICkuXo2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jan 2018 11:08:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id A359030603;
        Wed,  3 Jan 2018 02:07:52 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bINchcq7wn3D; Wed,  3 Jan 2018 02:07:50 -0800 (PST)
Received: from vento.lan (179.176.127.141.dynamic.adsl.gvt.net.br [179.176.127.141])
        by osg.samsung.com (Postfix) with ESMTPSA id 6A578305FB;
        Wed,  3 Jan 2018 02:07:45 -0800 (PST)
Date:   Wed, 3 Jan 2018 08:07:42 -0200
From:   Mauro Carvalho Chehab <mchehab@s-opensource.com>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-rpi-kernel@lists.infradead.org,
        patches@opensource.cirrus.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 01/34] clk_ops: change round_rate() to return
 unsigned long
Message-ID: <20180103080742.6ad76c2d@vento.lan>
In-Reply-To: <1514835793-1104-2-git-send-email-pure.logic@nexus-software.ie>
References: <1514835793-1104-1-git-send-email-pure.logic@nexus-software.ie>
        <1514835793-1104-2-git-send-email-pure.logic@nexus-software.ie>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mchehab@s-opensource.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchehab@s-opensource.com
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

Em Mon,  1 Jan 2018 19:42:40 +0000
Bryan O'Donoghue <pure.logic@nexus-software.ie> escreveu:

> Right now it is not possible to return a value larger than LONG_MAX on 32
> bit systems. You can pass a rate of ULONG_MAX but can't return anything
> past LONG_MAX due to the fact both the rounded_rate and negative error
> codes are represented in the return value of round_rate().
> 
> Most implementations either return zero on error or don't return error
> codes at all. A minority of implementations do return a negative number -
> typically -EINVAL or -ENODEV.
> 
> At the higher level then callers of round_rate() typically and rightly
> check for a value of <= 0.
> 
> It is possible then to convert round_rate() to an unsigned long return
> value and change error code indication for the minority from -ERRORCODE to
> a simple 0.
> 
> This patch is the first step in making it possible to scale round_rate past
> LONG_MAX, later patches will change the previously mentioned minority of
> round_rate() implementations to return zero only on error if those
> implementations currently return a negative error number. Implementations
> that do not return an error code of < 0 will be left as-is.
> 

>  drivers/media/platform/omap3isp/isp.c           |  4 ++--

Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Thanks,
Mauro
