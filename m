Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 13:14:56 +0100 (CET)
Received: from mail.skyhub.de ([IPv6:2a01:4f8:120:8448::d00d]:42062 "EHLO
        mail.skyhub.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdAFMOuTTyJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 13:14:50 +0100
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Aklt1GlLquqH; Fri,  6 Jan 2017 13:14:49 +0100 (CET)
Received: from pd.tnic (pD9F6AF60.dip0.t-ipconnect.de [217.246.175.96])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EF1967685;
        Fri,  6 Jan 2017 13:14:49 +0100 (CET)
Received: by pd.tnic (Postfix, from userid 1000)
        id 5F8AE160A45; Fri,  6 Jan 2017 13:14:46 +0100 (CET)
Date:   Fri, 6 Jan 2017 13:14:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net
Subject: Re: [PATCH v2 4/7] x86: put msr-index.h in uapi
Message-ID: <20170106121446.aizmoxons5gpecnc@pd.tnic>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Fri, Jan 06, 2017 at 10:43:56AM +0100, Nicolas Dichtel wrote:
> This header file is exported, thus move it to uapi.

It should rather not be exported - please remove it from
arch/x86/include/uapi/asm/Kbuild instead.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
