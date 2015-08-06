Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 04:20:15 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:55899 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006959AbbHFCUNrv59Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 04:20:13 +0200
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN025JL2HHVQ00@mailout2.samsung.com>; Thu,
 06 Aug 2015 11:20:06 +0900 (KST)
Received: from epcpsbgm1new.samsung.com ( [172.20.52.115])
        by epcpsbgr5.samsung.com (EPCPMTA) with SMTP id 08.03.17770.554C2C55; Thu,
 6 Aug 2015 11:20:05 +0900 (KST)
X-AuditID: cbfee691-f79ca6d00000456a-1d-55c2c455a4a9
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id E4.57.23663.554C2C55; Thu,  6 Aug 2015 11:20:05 +0900 (KST)
Received: from [10.252.81.186] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NSN002ZM2HFW3C0@mmp2.samsung.com>; Thu,
 06 Aug 2015 11:20:05 +0900 (KST)
Message-id: <55C2C453.3000005@samsung.com>
Date:   Thu, 06 Aug 2015 11:20:03 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
MIME-version: 1.0
To:     Doug Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Seungwon Jeon <tgih.jun@samsung.com>,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Jun Nie <jun.nie@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hao <haokexin@gmail.com>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vineet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        CPGS <cpgs@samsung.com>
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=Wv1FLHGyK=yL_P-WbRZwnK2K-rMEaXHjsZf+4iHfucjw@mail.gmail.com>
In-reply-to: <CAD=FV=Wv1FLHGyK=yL_P-WbRZwnK2K-rMEaXHjsZf+4iHfucjw@mail.gmail.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0yTdxTG8+97K0ySdxX0L8viRjRkBnRA0bO464eF98vcDEEyY6KVvUPD
        xaaFRrLNNCtOwsC20A1WsLJwscxya3fhNsRaYJPLqETqnLSFFsVix4bOog66lprMb7+cy3Oe
        58MREqIFOl54vLCIlxVK8hPoaNIUK5YnZ9msWa+OBsTQurSKQHV9noGWYEAAKrMcyqYbBeA2
        /EjDatUwA0stFQimb56n4a71FThvm6BgvOUyDep731Jwrq4Kwcq8k4ThO24KgnOLFEz4WhEM
        PZFC88wyDU3eWQYWF1JA7Vkk4J8rRgT3Zi0IzJ5pCqZ662nQfFXFgC2oRrDsDhJQ+9uAANq7
        bjLwx1QM2KZMCPocEwiaHXYBuBoDCK467oe2atpI6KxdI8Fj9DNwrX8bzH9joeH0zzYGVsa+
        JOHPi14Et7wdFNSM+Cn4YniYAkv7GQZu1JRS8JfLTsDZtms0dFb3hW5pqxGMtGWD9Yc5Ei4Y
        UmFguRmBv2GIgbt//0KCd0hHwO+mSebtt7jGgJPgTAYT4kpVFTT35HEV4vSucZqrU9pJbups
        pYBbveMgue6ZJsT19tRTnNdsR5x2PJnr0c8wXOuFBzTnOdfFcKU2P/XBSwejX/+Izz+u4GW7
        3jwSfeyWb42SNlEnyxdqKSVSk+VIKMSsGI9pDpWjqBBuwpPODrocRQtFrBFhn2WOiDTE2O64
        RIVZxOoRbm/ZExlyI6zTGJhwI4bdgf0NPetMstuxxqWiw0yzSfinhyOCMMexB/BYbRkZmX8e
        r1Q71zmWfR93u8rJsCjBGmNx7xXz+sJGNgc32vsFkcsTCF8/nR3mKDYTT1bY1xMQbCLW6QrC
        ZYLdii0mPxHWwazuOayc0aKIIRY/rLY+TfwiNg8+DbYFXzbeIDVok/4ZS/r/VfXPqDYg4jsU
        x0tzpPKjubL0nXJJgby4MHdnzokCMwo9wOjabW03cg3utSJWiBI2xLhN1iwRJVHISwqsKD1k
        QkvEx+WcCP1MYdHhlLTdqZAuTk9L3fPa7oTNMUkvPMoUsbmSIj6P56W87LCsOJ+XW5FAGBWv
        RLv+7Rbu8zSn5W3pdy4pl9yK4k6+ZNvm7X0l1NdnMhpO1o905m29muSq/HDD/kO33yiT/Xrq
        6Duei5mfx55SqDriQKiuS7u//+CDd4ODxd2P+uf3SZPf+943O9qQulYZiD9Qqkh8eW/G44EO
        z2efDCoTPzawn3aZfZzBvirKMPVfUmcnkPJjkpQdhEwu+Q9407xb+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1BUZRTA59v7Wqy1C6F9w0wj7VSU0xKLIsdGe1hjt7FGRBDGmsHbcge2
        2IX2AqWTE9OiMkguL1tABZSHkAsCOxIvbVwWcOQRCwllwqIs+YCVRAsmB+gujNnU99dvznd+
        55z5vjlywqeR8ZNr9cmCQc8nKOkVZPfCuLcq0m6LDHpQ+CJUT88jMF6ZYKBycVYGxgYRMobK
        ZDBW3EjDfG4nA9OVWQiGrpbQcNv2MpTY+yjorbxIg2nqJAUnjuUimJsYJaHz5hgFizcmKei7
        U42g42ESVIzM0FDuus7A5C01mMYnCfijvQrB1HUrgobxIQoGW47TkH00lwH7ognBzNgiAQU/
        XpBBbf1VBn4dVIB90IKgdbgPQcWwQwbOslkEl4fvS5a5hoS6ggUSxqvcDAy0PQ8ThVYaDpy3
        MzDXc5iEu2dcCK65zlJg7nJTcLCzkwJr7SEGfjanU/C700HAkZoBGuryWqVeOXkIumqiwHbu
        Bgmni4PhwkwFAndpBwO3710iwdWRT8Avln7mzTe4stlRgrMUWxCXbsyiuYd/5SKuyNlLc8fS
        HCQ3eOQbGTd/c5jkmkbKEdfSfJziXA0OxOX0qrjmohGGqz79gObGT9QzXLrdTYX5705Dm+IF
        PlYw+At6TWKsVh+3WbltZ8zbMSEbgtQq9UYIVfrreZ2wWfnO+2GqrdoE6TuV/ql8QooUCuNF
        Ufnq6/+vEBmxVQWPxGjVBxHh/zjBQf85eywo/tqdBSqpnPoi81YBlYZMZCbykmN2PXYM/0At
        82rcP3qW9rAPW4RwbWVoJloh8RjC+dnFjOdCwa7F7tLmJSbZF3C207gk0Owr+Ps/u2QeXsXu
        wj0FGeRyvjeeyxtdYl92O25yZpKeogRb5Ytb2huWhKdZDS5ztMmWO/chfOVAlIe92J24P8sh
        CXJJCMD5+TpPmGDXYKvFTWQjacrHLYoeZxX9K6sUEd8hLCRpksSP43RqvfB5oMjrxBR9XKAm
        UdeAlnbmN78mdLHlXRti5Uj5pGLMYov0ofhUca/OhrCcUPoqpjOkkCKW37tPMCTGGFISBNGG
        QqQ3yCH8VmkSpQ3UJ8eo163fELwxOFQNwetClc8onq2zRvqwcXyy8KkgJAmGR55M7uWXhvC9
        +M9Ul8xfvRaDy+/uN50yxs6cqogu9+ou3DT1pbZkQWvZlzvtXZbwXrjDe3+4S1vYrdnR3vhJ
        bPRU+67ziQGXD630/rZt9OTBgamAMzU6W0Ddh17iuTVbssw9gc+ZBroPr155/6Pd244+NdL8
        Ukh2654nIqIWzCNb6p0/fR2earC+pVWSYjyvXksYRP5vIMQ4xEkEAAA=
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh80.chung@samsung.com
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

On 08/06/2015 11:16 AM, Doug Anderson wrote:
> Shawn,
> 
> On Wed, Aug 5, 2015 at 1:17 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> synopsys-dw-mshc supports three types of transfer mode. We add bindings
>> and description for how to use them at runtime. Without idmac and edmac
>> property, pio is the default transfer mode. Make sure that Idmac and emdac
>> should not be used simultaneously.
> 
> Can't you just read the HCON register?
> 
> [17:16]: DMA_INTERFACE
>  00: none
>  01: DW_DMA
>  10: GENERIC_DMA
>  11: NON-DW-DMA

If read it and get the exactly information. I think we can use that information.

Best Regards,
Jaehoon Chung

> 
