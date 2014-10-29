Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 09:10:26 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:49609 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011823AbaJ2IKYVDAaL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 09:10:24 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0LoIFV-1YGYLh0qS1-00gEo7; Wed, 29 Oct 2014 09:09:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/4] MIPS: GIC device-tree support
Date:   Wed, 29 Oct 2014 09:09:51 +0100
Message-ID: <15750371.2vAOfonLTV@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:R7YR0oTO4+g20hEz/HnY/vb29dE4Wyzf6ayka6W+WgC
 TN1u9+0Q/dh9THxuI1gKZ85Ia+/4JStxAjMa7VDJqM6i9oPsoa
 KGnQ+GKcv0LCZ/7yw0c3hrzfaiJ52cftarn2fWNhAhfy3Bm82w
 LHq+8eNFXo3pwKO2pILtSXKfpPLhCqcjjItVsWMNxt+957ABGN
 2VP6boNmDGiNYJKfk3J5Gtt2Ta82apHnKhHEeYHm+QyoIC7SxU
 Dliiz7q29oSdgEWiJHghFE6kBzGSZigu2DbtnN4hr4dCyjwzGL
 kMw/OY7JXMjLQ2fjm48aSGId6lXmDFUUXGwDAIY2D+jsxYLhvd
 1vq4RQaY+idDpwm9+6+k=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday 28 October 2014 17:12:38 Andrew Bresticker wrote:
> This series add support for mapping and routing GIC interrupts as well
> as setting up the GIC timer through device-tree.  Patches 1 adds the
> "mti" vendor prefix, patch 2 adds the GIC binding document, and patches
> 3 and 4 add device-tree support for the GIC irqchip and clocksource drivers,
> respectively.
> 
> Based on next-20141028, which includes part 1 [0] and part 2 [1] of my
> GIC cleanup series.
> 

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
