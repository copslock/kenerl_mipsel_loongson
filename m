Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 04:16:16 +0200 (CEST)
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33415 "EHLO
        mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006750AbbHFCQNbebgQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 04:16:13 +0200
Received: by ykoo205 with SMTP id o205so51625077yko.0
        for <linux-mips@linux-mips.org>; Wed, 05 Aug 2015 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=T4TM5ncuCIOfivP1fSGUSyO5/sfG7YmL4eQALej+e7s=;
        b=JThz3gwyJFjw9xjTOi4dMkVe4isCiHm20u9JP0xQbTJErSG260k2NXlpJvJqzMeccv
         LCNMnnqDnfaJSYlAQHV+fCzsRzzYDkytzwUJl31YbrC+IaNc/0ygJmt3yBtY3rCuWvEM
         cKhYZ52rih6j98OFgm2dWUsFufDeFaiZKPFWVJjp39Rv1tOvUqmkdw/aFmzCuQHYJXaw
         eSy/iAwsks7esTARIkU4t445f6blEi/75+Cmpe6G41zFKUblV0Wi17WktMbndk5F9lZr
         NOPG+0XH0YwkedmrrCGFSYvkZxzVfP6EAOlRBUYTH/fDwYHXOFl8wci1AVj3PkWN0ACe
         ezDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=T4TM5ncuCIOfivP1fSGUSyO5/sfG7YmL4eQALej+e7s=;
        b=WUUmxbT/mkavXA3pG0hwxl12vfgOde7Jv0qTaT2kfVuQza9By4xhqHPJ9xui94RPLG
         ytnKyAg75/yRcCr55Pini2s4cequf453YVpbziy/wCcCwgCFao+4YTSmGlgoHiUoqu+D
         Dw6DHa7k7OUuBbe7610Fh1YgOecjkU81JdpoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T4TM5ncuCIOfivP1fSGUSyO5/sfG7YmL4eQALej+e7s=;
        b=L1PUKKf9xvpnNUctGab7kKHhLEeqS3DOwAkDEkRzcG7qWPm1GR01OGUusPNQ0FtbNP
         qZ9SFY+Mz/Wb/eAvurutVq31OlR6eKcufWHCs+A3C+gQCsoHpdBPwqC9PhlggU2zzeFN
         VKdIZUzGCHTDONHCIl3hKM+NCGrd+SOqnsjUwfw4hqCP+u5Y7G9hCTV3cb+3Z32kQ0YG
         EeqriJMYbzJBKcTj7/UqmWXrNZI5kLqzDi1N4xoKT4wKcYhfORNXzltBw92Zb6v/HkL3
         DN3Kle9H6Xmh92T0T/Fu8xDg5BQhwsV1KU88n4uO4hyJY654QT1BjJ1sxrDTv2oQ/zPE
         HjHw==
X-Gm-Message-State: ALoCoQmEZ+9t7gpoEgcKKwM8hllkyVrtWAVpEv5HYhMIEEo8yrKDt52ANqq+LDALMqkNQhBJnCdi
MIME-Version: 1.0
X-Received: by 10.170.144.66 with SMTP id l63mr12772706ykc.122.1438827367448;
 Wed, 05 Aug 2015 19:16:07 -0700 (PDT)
Received: by 10.37.78.66 with HTTP; Wed, 5 Aug 2015 19:16:07 -0700 (PDT)
In-Reply-To: <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
        <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
Date:   Wed, 5 Aug 2015 19:16:07 -0700
X-Google-Sender-Auth: QIiAwUBve3YtPTXsmIBynlgA1hM
Message-ID: <CAD=FV=Wv1FLHGyK=yL_P-WbRZwnK2K-rMEaXHjsZf+4iHfucjw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
From:   Doug Anderson <dianders@chromium.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
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
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <dianders@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

Shawn,

On Wed, Aug 5, 2015 at 1:17 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> synopsys-dw-mshc supports three types of transfer mode. We add bindings
> and description for how to use them at runtime. Without idmac and edmac
> property, pio is the default transfer mode. Make sure that Idmac and emdac
> should not be used simultaneously.

Can't you just read the HCON register?

[17:16]: DMA_INTERFACE
 00: none
 01: DW_DMA
 10: GENERIC_DMA
 11: NON-DW-DMA
