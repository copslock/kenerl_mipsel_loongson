Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 17:01:58 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:45523 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011086AbaJJPB4sqkyR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Oct 2014 17:01:56 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 60B4C28087A;
        Fri, 10 Oct 2014 17:01:03 +0200 (CEST)
Received: from Dicker-Alter.local (ip-109-47-181-192.web.vodafone.de [109.47.181.192])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 10 Oct 2014 17:01:03 +0200 (CEST)
Message-ID: <5437F4DC.2070509@openwrt.org>
Date:   Fri, 10 Oct 2014 17:01:48 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     balbi@ti.com
CC:     linux-usb@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] USB: phy: add ralink SoC driver
References: <1412936401-57511-1-git-send-email-blogic@openwrt.org> <20141010135826.GC31348@saruman>
In-Reply-To: <20141010135826.GC31348@saruman>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43209
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


On 10/10/2014 15:58, Felipe Balbi wrote:
> On Fri, Oct 10, 2014 at 12:20:01PM +0200, John Crispin wrote:
>> RT3352, RT5350 and the MT762x SoCs all have a usb phy that we need to setup.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
> new PHY drivers only on drivers/phy ;-)
>
i that hope i am not the first to get it wrong. I will prepare/send a
fixed version.

    John
