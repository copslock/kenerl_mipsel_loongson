Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 22:12:01 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:48490 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903871Ab1KPVLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 22:11:52 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3399D23C0084;
        Wed, 16 Nov 2011 22:11:50 +0100 (CET)
Message-ID: <4EC42717.2050806@openwrt.org>
Date:   Wed, 16 Nov 2011 22:11:51 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     "Luis R. Rodriguez" <mcgrof@frijolero.org>
CC:     Sangwook Lee <sangwook.lee@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        ath9k-devel@lists.ath9k.org, ralf@linux-mips.org,
        linville@tuxdriver.com, rmanohar@qca.qualcomm.com,
        patches@linaro.org
Subject: Re: [PATCH] ath9k: rename ath9k_platform.h to ath_platform.h
References: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org> <CAB=NE6UB6KzJ2p+sou4wcgnZ9jyQxhpWMr2qZ2=jwqaGc2L5Xw@mail.gmail.com>
In-Reply-To: <CAB=NE6UB6KzJ2p+sou4wcgnZ9jyQxhpWMr2qZ2=jwqaGc2L5Xw@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13844

2011.11.15. 17:09 keltezéssel, Luis R. Rodriguez írta:
> On Tue, Nov 15, 2011 at 3:23 AM, Sangwook Lee <sangwook.lee@linaro.org> wrote:
>> The patch series proposes to rename ath9k_platform.h to "ath_platform.h
>> This header file handles platform data used only for ath9k,
>> but it can used by ath6k as well.
> 
> Adding the actual OpenWrt stakeholders. Is there any public hardware
> platform that uses this yet?

It is used by the ath79 platform code in the mainline kernel, although only the
AP81 reference board uses that for now. However the linux-mips tree also has
code for the AP121 reference board, and that will use it as well.

Additionaly, we are using that in OpenWrt for several consumer boards which are
based on the AR71xx/AR724x/AR913x SoCs.

-Gabor
