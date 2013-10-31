Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 10:53:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:43176 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817974Ab3JaJxjq0S0P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Oct 2013 10:53:39 +0100
Message-ID: <52722851.30302@openwrt.org>
Date:   Thu, 31 Oct 2013 10:52:17 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Wei Yongjun <weiyj.lk@gmail.com>
CC:     ralf@linux-mips.org, grant.likely@linaro.org,
        rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ralink: fix return value check in rt_timer_probe()
References: <CAPgLHd81Ucjnc=pmdxiZzBrk15ui1ezyowdd8JxYzvmmdLoMwQ@mail.gmail.com>
In-Reply-To: <CAPgLHd81Ucjnc=pmdxiZzBrk15ui1ezyowdd8JxYzvmmdLoMwQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38425
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

On 31/10/13 08:51, Wei Yongjun wrote:
> From: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function devm_request_and_ioremap() returns NULL
> pointer not ERR_PTR(). Fix it by using devm_ioremap_resource() instead
> of devm_request_and_ioremap().
>
> Signed-off-by: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
Thanks for spotting the bug.

Acked-by: John Crispin <blogic@openwrt.org>
