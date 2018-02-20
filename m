Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 11:22:26 +0100 (CET)
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38194 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994664AbeBTKWRW70L1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 11:22:17 +0100
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KAIugY011394;
        Tue, 20 Feb 2018 04:21:19 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2g6jp5bh7b-1;
        Tue, 20 Feb 2018 04:21:19 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id E22EB60D974E;
        Tue, 20 Feb 2018 04:21:18 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Tue, 20 Feb 2018
 10:21:07 +0000
Received: from localhost.localdomain (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w1KAKvPa009826; Tue,
 20 Feb 2018 10:20:57 GMT
Date:   Tue, 20 Feb 2018 10:20:57 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "William Breathitt Gray" <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Johannes Thumshirn" <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "Marc Gonzalez" <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-mips@linux-mips.org>, <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180220102057.um6g7gykvrnjx2qs@localhost.localdomain>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=450 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802200132
Return-Path: <ckeepax@opensource.cirrus.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ckeepax@opensource.cirrus.com
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

On Tue, Feb 20, 2018 at 10:31:08AM +0100, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/wm831x_wdt.c          |  5 +---
>  drivers/watchdog/wm8350_wdt.c          |  5 +---

For the Wolfson parts:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
