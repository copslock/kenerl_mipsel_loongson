Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 07:18:40 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:52922 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006157AbbJ2GSiY3KrB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Oct 2015 07:18:38 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id CE6382804A9;
        Thu, 29 Oct 2015 07:16:52 +0100 (CET)
Received: from Dicker-Alter.lan (p548C981A.dip0.t-ipconnect.de [84.140.152.26])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 29 Oct 2015 07:16:52 +0100 (CET)
Subject: Re: [PATCH 06/15] MIPS: lantiq: deactivate most of the devices by
 default
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
 <1446071865-21936-7-git-send-email-hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
From:   John Crispin <blogic@openwrt.org>
Message-ID: <5631BA3B.4090703@openwrt.org>
Date:   Thu, 29 Oct 2015 07:18:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1446071865-21936-7-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi Hauke,

read through the series a couple of times now and the only thing i can
find is a superfluous Travolta bracket

On 28/10/2015 23:37, Hauke Mehrtens wrote:
> +	if (deactivate) {
> +		/* Disable it during the initialitin. Module should enable when used */
> +		pmu_disable(clk);
> +	}
>  	clkdev_add(&clk->cl);
>  }

i think that bracket is not needed

apart from that, for the whole series

Acked-by: John Crispin <blogic@openwrt.org>

Thanks!
