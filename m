Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 15:23:37 +0200 (CEST)
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54562 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993256AbeGTNXeHjwPG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 15:23:34 +0200
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KDIxZK009824;
        Fri, 20 Jul 2018 08:23:03 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2kbg2301br-1;
        Fri, 20 Jul 2018 08:23:03 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 8E608611CE60;
        Fri, 20 Jul 2018 08:24:13 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Fri, 20 Jul 2018
 14:23:02 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w6KDMwCn011246; Fri,
 20 Jul 2018 14:22:58 +0100
Date:   Fri, 20 Jul 2018 14:22:58 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Marcel Ziswiler <marcel@ziswiler.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        <linux-mips@linux-mips.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        "Philippe Ombredanne" <pombredanne@nexb.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Daniel Mack" <daniel@zonque.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>, Donglin Peng <dolinux.peng@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] ASoC: wm9712: fix replace codec to component
Message-ID: <20180720132258.GD18740@imbe.wolfsonmicro.main>
References: <20180720075148.14648-1-marcel@ziswiler.com>
 <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=495 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1806210000
 definitions=main-1807200152
Return-Path: <ckeepax@opensource.cirrus.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64986
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

On Fri, Jul 20, 2018 at 08:30:41AM +0000, Kuninori Morimoto wrote:
> 
> Hi Marcel
> 
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
> > "wm9712-codec" got renamed to "wm9712-component", however, this change
> > never got propagated down to the actual board/platform drivers. E.g. on
> > Colibri T20 this lead to the following spew upon boot with sound/touch
> > being broken:
> 
> Oops, my bad...
> The platform_driver name is not important,
> how about simply rename back it to "wm9712-codec" ?
> 

Yeah I would agree here wm9712-component isn't great as a name
for board files etc. Lets rename back to wm9712-codec for these
specific bits.

Thanks,
Charles
