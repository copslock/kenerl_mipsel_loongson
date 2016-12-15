Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2016 09:02:43 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:59248 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990845AbcLOICgANQX1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Dec 2016 09:02:36 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0LaHLm-1d2L4P1ivu-00m2up; Thu, 15 Dec 2016 09:02:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     kernel-build-reports@lists.linaro.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@linux-mips.org
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82 warnings (next-20161214)
Date:   Thu, 15 Dec 2016 09:02:17 +0100
Message-ID: <2139236.OXpNvTk27O@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20161215032241.GB15191@linux-mips.org>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com> <20161214174539.h3xsugswlq576g7b@sirena.org.uk> <20161215032241.GB15191@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:O1s/rIRyvsuYxreX1Te3s18ugafoY/E8nn+REcan+BSXiTpnnw/
 uGpEwYTPxLSRxqOXcF18f3QaXPm+fThpBOEotwLbFHsCgfiFgNrGa9oswEqGJsBdxxD2D5P
 uFstcmcC5ZJKubvxrWaH8Hswer4pEBQD54VNhbeearQVJh4zR72hw2+ZXmKV3Xxk40QoqGT
 i4YHFcNfRsDL0BNVZeE7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D2c/meqICmM=:NSpAqdJofDH8vsyExpsVRH
 eNvN7tLtPAbxk5aaI3Wyq6hEeiWdH8XBlQLKwq2QMaFXZmoictkWkN2N/8hILrdX6udZu7ku8
 xO22CtpiXJU0DohTFXXP8ztJ1y/PKlY/Jx8f/stm1gMPngb5hsF9v3D1jUI/YhfnCP3mEeBb+
 wURkT4vTu+8s/VAh2SUXsMP1kX8xmAEiLryHjo/I0ZtPWY9PT6yYZdl0XOucuUiQFhg9NJgxr
 KwX4jcPMHx7QVe5mhAVEcmMx162XkFF4QlnAhrQ3PuTONP5zMdlNxwig/offNgb4BfDb6WOV/
 89tlOzLwZFRcX2P3/SlM3AEoPgSDEzF2uMvE5Mq6v0ftYHEcey/tpYifWmHb/LyV3SiCa3elK
 4obrYw0523nWgPQvCB/dmB1PMFQvDef0XvaKOaTtNnI3D9zDNatVXt4sVsCi84+Dk7dC6AEL5
 CB5yQKawscLrL3eEIbPvlKtitR+nLRbyRt1ZLaqMB/XGdsnfSr6NBb3x7COCqP3n325L4UyT1
 g10GHk3tsjxP5ibyT+cZM5JXFrhnm0CH74GI84PbkVYHlclCkmPR4LVVJi8XzRVL+X6uvgE90
 9wCTHQ3fahi+SUbQJgUq4nZpFzdW6ksnSR6gIwPsLXLP3lNiTAgl63UQQkKsLdiv93IPmBFmc
 iiE1oUxaWAKjn+MoKtcTpSwJchlr8U5u0bFGIx1LoLyY+mz6uywls/bGN40fksCkgrHDeIfvq
 6Gafn5JS/X+R5qoq
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56054
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

On Thursday, December 15, 2016 4:22:41 AM CET Ralf Baechle wrote:
> 
> Some configurations, in particular new cores or architecture variants
> may require vendor tool- chains or patches until support makes it upstream.
> I wonder if for the benefit of automated build testing we should tag
> kernel configurations with a special CONFIG_ symbol to indicate they need
> non-standard tools?  That would allow build testing to detect and
> possibly skip such configuration.

I think that this ties in with a discussion we recently had about moving
toolchain feature detection from Makefiles into Kconfig, which can
then probably handle this better. We just need to find someone who
can hack this up into Kconfig.

	Arnd
