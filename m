Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 14:47:59 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.186]:56071 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839455Ab3KLNr4UyNTc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Nov 2013 14:47:56 +0100
Received: from klappe2.localnet (HSI-KBW-46-223-47-137.hsi.kabel-badenwuerttemberg.de [46.223.47.137])
        by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
        id 0LgjGE-1VKsGC1pOY-00oDer; Tue, 12 Nov 2013 14:46:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 01/11] Add generic fixmap.h
Date:   Tue, 12 Nov 2013 14:46:40 +0100
User-Agent: KMail/1.12.2 (Linux/3.8.0-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1384262545-20875-1-git-send-email-msalter@redhat.com> <1384262545-20875-2-git-send-email-msalter@redhat.com>
In-Reply-To: <1384262545-20875-2-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201311121446.40700.arnd@arndb.de>
X-Provags-ID: V02:K0:+2zmCdfderxGjbzwBr5c5ktT93yjI6sR2mBpcJiBz7b
 lnmkTEI+LEpJeY7SttwYPJCVkks05Zo07eB/xRXZJnxz2gwmpn
 iSg8BF92CewlBarW2l13ZeoQNQPfoKzJAkYMj1U33zZRKKsYdf
 A+uAf/zuIBDpZHoiXoB55Wk0vmnQph7RLPNxEiN7gKt04cSh9P
 QJD0/fpVtfL2YWcUpi5KFxuGqMafNzFWLZtNX9c6dcT61rlv26
 Rsv0gNyiKkipRCoLHETu3FAUvDIkkire2iEx2tspFIBNCQQf/I
 P++1WCajC2sQOvZKozxAPHCwt+aKqheScAXcAazXp4B5NXcyo1
 hRd+ZEuC4KtR3ZARkqag=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38508
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

On Tuesday 12 November 2013, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.


Good idea, 

Acked-by: Arnd Bergmann <arnd@arndb.de>

On Tuesday 12 November 2013, Mark Salter wrote:
> +static __always_inline unsigned long fix_to_virt(const unsigned int idx)
> +{
> +       /*
> +        * this branch gets completely eliminated after inlining,
> +        * except when someone tries to use fixaddr indices in an
> +        * illegal way. (such as mixing up address types or using
> +        * out-of-range indices).
> +        *
> +        * If it doesn't get removed, the linker will complain
> +        * loudly with a reasonably clear error message..
> +        */
> +       if (idx >= __end_of_fixed_addresses)
> +               __this_fixmap_does_not_exist();
> +

You might be able to turn this into the more readable BUILD_BUG_ON().

	Arnd
