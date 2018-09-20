Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 17:51:07 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:40682 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992363AbeITPvDsKAFi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 17:51:03 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 485C7146FE6EB;
        Thu, 20 Sep 2018 08:50:58 -0700 (PDT)
Date:   Thu, 20 Sep 2018 08:50:55 -0700 (PDT)
Message-Id: <20180920.085055.1188796939437872993.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     dmitry.tarnyagin@lockless.no, wg@grandegger.com,
        mkl@pengutronix.de, michal.simek@xilinx.com,
        hsweeten@visionengravers.com, madalin.bucur@nxp.com,
        pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com,
        leoyang.li@nxp.com, linux@armlinux.org.uk, sammy@sammy.net,
        ralf@linux-mips.org, nico@fluxnic.net,
        steve.glendinning@shawell.net, f.fainelli@gmail.com,
        grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com,
        t.sailer@alumni.ethz.ch, jreuter@yaina.de, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu2@citrix.com,
        paul.durrant@citrix.com, arvid.brodin@alten.se, pshelar@ovn.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-omap@vger.kernel.org, linux-hams@vger.kernel.org,
        devel@linuxdriverproject.org, linux-usb@vger.kernel.org,
        xen-devel@lists.xenproject.org, dev@openvswitch.org
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Sep 2018 08:50:59 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Sep 2018 20:32:44 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.

I would advise you not to send so many of these changes as a group.

If one of the patches needs feedback addressed, which is already the
case, you will have to resubmit the entire series all over again with
the fixes.
