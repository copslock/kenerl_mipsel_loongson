Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 12:35:12 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:57063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992482AbdAILfAapBrc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 12:35:00 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0McMsh-1c99gd0xM7-00JbtL; Mon, 09 Jan 2017 12:34:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        airlied@linux.ie, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
        coreteam@netfilter.org, fcoe-devel@open-fcoe.org,
        xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
        linux-media@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        mmarek@suse.com, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        davem@davemloft.net
Subject: Re: [PATCH v2 3/7] nios2: put setup.h in uapi
Date:   Mon, 09 Jan 2017 12:33:46 +0100
Message-ID: <3162962.COsNxdSb45@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1483695839-18660-4-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com> <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com> <1483695839-18660-4-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:ZZnO/2hBeL/oePYR2t9fbBJzN1+JfZ2CSwbxHUb38gX1q9cIRR3
 ZxoWH9h+tx5gFfkn22Cdce25AQmYuHg2Zi8qykg9H+b4HQq1LOUjRrA3WsU9N4xBj/mbhCp
 Ngf9z7jVw6U+jcwcfuCprdZoKgHb2u4wSkhAcXeMEeh1tiKT9btF7FhErAucE0jVe3ivPLM
 vjIfmw9ilHnXGrvpfq3xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DH1jTx2lUHQ=:M/9HvXYhmCSKgNd/YM2aUg
 dXH5Dl4sfq5ho+/IyCsB8yaH2JxBzCjFj1ENkUZXkbRvdehF0/3dop8SIqqwxocLqEE6NCySb
 lBv884R+2/radA3RPLZTmzGKcWMlHifwNeC7xGaOSnOqY3puUOC+Fes7SSOSkTCVcBKaCA0U1
 /Mu0NIUvU/89JSF57iPlWKuUv4QvEJn69Zgsmy+xFJ8+pQ22fWw8ho+By8XAd56Gax5K2xbEZ
 LnOXHA9MhLzhbULBgTwOzQm2In24Yz/7Co8jObZMJpOi2f+IUvNlizolxq8sYxmb16p7KLHCI
 R5XV3OGlpbNGgAzcP9czpQktfFrR+jwnBPv6wd0IaIpqrgb+k1lVMO6MDYf70WJSogFmxl30H
 /6ceFjrYsenYa0T6q/sy7uCu00K5OnB+K2zU3xJK+/6ZPVbbhd5oHv0o3fuxsHTZPo3oZVjzv
 Ba8zyP6CBDSF6qsPhQQjrVbccwMn5q2YJ3wSL89fSoM53urm4xyTVo3gzemNIYpVg0nNgfHqM
 oolyUQpGalinFgRtqxgVxdEA+JBVOaLiUC/nym+jcCa3nhlkPtYHYWEuz/RCJdM4S29l0FGFP
 pqM2Pdq05kSi0oImR99CxoGpTpLzJBaaht2/u5pBa7hcFLBpe3g+/X3u/NrGri37ayXL/ZJLx
 YUPp5bucmf87fFBtbYs8kry47L9QZvQG20m4rke+MFBI+k1FYCmCMAT2KQZ/quKfypopJrcHJ
 i31sf89bmgym52rB
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56227
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

On Friday, January 6, 2017 10:43:55 AM CET Nicolas Dichtel wrote:

> diff --git a/arch/nios2/include/uapi/asm/setup.h b/arch/nios2/include/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..8d8285997ba8
> --- /dev/null
> +++ b/arch/nios2/include/uapi/asm/setup.h
> @@ -0,0 +1,6 @@
> +#ifndef _UAPI_ASM_NIOS2_SETUP_H
> +#define _UAPI_ASM_NIOS2_SETUP_H
> +
> +#include <asm-generic/setup.h>
> +
> +#endif /* _UAPI_ASM_NIOS2_SETUP_H */
> 

This one is only a redirect to an asm-generic header, so it can be
removed completely and replaced with a line in the 
arch/nios2/include/uapi/asm/ file:

generic-y += setup.h

	Arnd
