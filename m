Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 12:34:47 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:57969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992246AbdAILekCcnOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 12:34:40 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPSA (Nemesis) id
 0MIgBs-1cSl7Y3lQO-002E9r; Mon, 09 Jan 2017 12:33:13 +0100
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
Subject: Re: [PATCH v2 1/7] arm: put types.h in uapi
Date:   Mon, 09 Jan 2017 12:33:02 +0100
Message-ID: <1990589.0aJHWbJK4F@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1483695839-18660-2-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com> <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com> <1483695839-18660-2-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:lFuqw0O+zwe8xGI5ryMwMSgw46KXWXBsddg4+RL0e4FYSDZfxgm
 6kOGY1A4Vzl56BwTc73hDYZoeRkCvYNE/0v/R1N5GJqsV16rvxmElECduPJX3XxHL+hMezA
 OyKf98gUNbOTEcXnmh1jf1o4KsgMzAQeZj0NxkkqFo6/El8eFWh37SdIq5AgUycoFcJwEX/
 sFWkhUmE0ApwS2YqNPjqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ner0l3fze+0=:L+72hpZSyrdkKC3Y5nQ1sw
 pX2v6dGCO/UixFM1gDa9Q4dfLe9TfF38/NWSrSci7slFMqOJRvxciDOYO8qpRpnalzyJUBFh/
 yVlq+w/OcrfPAUtq2SmS3PmYkRAtS2eTJvlqV0LLWYc/jkLI9r7OF7TdaiWO/4f4h4u6vRkk4
 XDm1x4Uz2LlX3qPkeyaFDL7oMT75NoH0LvO472l/BPOVk00S5GBpcKtT1C8pqeNiyvxl7Yrer
 TXu/NA82AXzPgZ597QRn04LBoOetElKkKvFglvFHzFypWJ91OgQ0q7t2dO/yf+2S9w0wNm2/r
 eh3VjL8es0HM4NWU4adJXCj5Dtpi7zyihfEraBDqv6lM84alCw5XehyJ6md3/ZblyPTdcCwZG
 LCsQGkgLPYWogyScygsvBQOU9qDFtyQlbIbBfbCWEqHs54e7hcBVHC4KcdpSrxk8uRc3UHb7k
 F56qtEv1om+xUI7Yx3YhqQIY0kq26TTjLdr+WndJNgp7xFvdSY5Fz/DtUACuyvUL6s0yQSTmH
 AR32i9iTKo/OFtpW9ckFl1wUnoFu5reWnlS/nP3kF80b5ajbo39VxdDCKeqxN6v4xeoPF2Cnm
 ppBV6cNRsewJzPAgtpi5sl4Tz98uPWPlnaPF73yXZeyim1P1galyh3PioeokhtlptuQAGmpu0
 RrSnxE9yHejiP/GTjSy9rp34XHc9PynGSovROgY7EKfoVQ0k3Di43+1jikOaVFH2NB3JhfIRn
 iysnVUSai0/0M1RS
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56226
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

On Friday, January 6, 2017 10:43:53 AM CET Nicolas Dichtel wrote:
> 
> diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
> index a53cdb8f068c..c48fee3d7b3b 100644
> --- a/arch/arm/include/asm/types.h
> +++ b/arch/arm/include/asm/types.h
> @@ -1,40 +1,6 @@
>  #ifndef _ASM_TYPES_H
>  #define _ASM_TYPES_H
>  
> -#include <asm-generic/int-ll64.h>
...
> -#define __UINTPTR_TYPE__       unsigned long
> -#endif
> +#include <uapi/asm/types.h>
>  
>  #endif /* _ASM_TYPES_H */
> 

Moving the file is correct as far as I can tell, but the extra
#include is not necessary here, as the kernel will automatically
search both arch/arm/include/ and arch/arm/include/uapi/.

The same applies to patches 2 and 4.

	Arnd
