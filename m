Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 22:02:04 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:63830 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007663AbcDPUCAs1wve (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 22:02:00 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0Lw14n-1bqEsS1RAj-017p2P; Sat, 16 Apr
 2016 22:01:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@arm.linux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: brcmstb_gisb: Rework dependencies
Date:   Sat, 16 Apr 2016 22:01:05 +0200
Message-ID: <13932531.o87aikNi0r@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1460571469-20201-1-git-send-email-f.fainelli@gmail.com>
References: <1460571469-20201-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:C8WFOF7jEqGEbygH/TCd8tV1ONeDE41wN/eOP7aB9JXjNSKQsYi
 ZxDrNO4R6Rn6n/PcGXBdExDPG6KWe6rLWOMfDFGlH/yXZr24vvFLMTqtuIA0GOfFWrLfggd
 8bGX9zNPjMPNmYMiTEXQ54ZDy5WcOn7hY07Oo+viNLa7sSjHjUqe77D/pG7AtRf47fVb03+
 tPyXnQBpNnDVxxgRKZH2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OYz18JTk828=:GpV2N5Q6/nveBBTBz9Ha3y
 jMNpk4sab9MvVqzZI6DbAHMI3W++MRuMjABaAHJbzYdgux2V33W98q/Z/dS+IdmJArJzKes6c
 xU8vDgp2iZ0zlPr24uun3W5eRo4CMigmAOAYBkq2E06kx2C3XWL8jBKC4ajLEN5VoPgdJJivQ
 FojqsfJSaVBJ2EufL7YCtx9HBVGXT20cs/lMQ8trulG9rkEq84SKthW55o40wdMk+7WNJSnod
 7t89vZnoSbDPXAxbwY0dncvmSv32TqW8oE1PZgioqPc1xBWbTiaaQr9cKqaVwXBAaiSy3GVMB
 iUc87Lmu3Y1MJYf07gKMAXAC6Yco3I0n2998ukQfkhGWSHiCV3yxO1b9kCse9gqqdJ3YZJ4G4
 Nx3kSj2JCYfKogJD5BVUhymmRSOuRySVESLXF3tEYx5OnyqI3K7nbom6jJ9mpRi9V6b4WYyy6
 yY/LZFLpMHCmI1yWmboYt0Zp8zRiY2sPhMU//oT4riDOEKH3Q9l7SZ3RFa4HSjzMuPiwVkfOq
 EyfKPwazMiI/EIGM1wRJflOvCDS95mcPb4fBJEshwxGiZwYcj4Fl/dXvrZGmX4QIwpGPpjikg
 tvSCxqLtx6UmsQUlVf2tam2dS9YBTdaHdRu/tcHjoYGH6foPQTjlj2lLXLW9iSJLbyin3hcdk
 dT1fHI//6J34P4+jQcxQ0KjVqY9q+Er99DCkoNlLz22HWhNLyeScLxoALyJU82BJVm5cbgq0q
 dYT7HRKLpvqQ1Xw8
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53025
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

On Wednesday 13 April 2016 11:17:48 Florian Fainelli wrote:
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -58,6 +58,8 @@ config ARM_CCN
>  config BRCMSTB_GISB_ARB
>         bool "Broadcom STB GISB bus arbiter"
>         depends on ARM || MIPS
> +       default ARCH_BRCMSTB
> +       default BMIPS_GENERIC
> 

I think having two 'default' statements is not clear to human
readers, how about changing it to

	default ARCH_BRCMSTB || BMIPS_GENERIC


	Arnd
