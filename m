Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 17:38:50 +0100 (CET)
Received: from mail.skyhub.de ([IPv6:2a01:4f8:120:8448::d00d]:50672 "EHLO
        mail.skyhub.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993956AbdAMQioEvHLR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 17:38:44 +0100
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OLLeXlSgQoIp; Fri, 13 Jan 2017 17:38:43 +0100 (CET)
Received: from pd.tnic (p2003008C2F3A7C0099559D88C4B2656A.dip0.t-ipconnect.de [IPv6:2003:8c:2f3a:7c00:9955:9d88:c4b2:656a])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 724E867685;
        Fri, 13 Jan 2017 17:38:43 +0100 (CET)
Received: by pd.tnic (Postfix, from userid 1000)
        id 3A7E0160BE5; Fri, 13 Jan 2017 17:38:36 +0100 (CET)
Date:   Fri, 13 Jan 2017 17:38:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     David Howells <dhowells@redhat.com>, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org,
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
        linux@armlinux.org.uk
Subject: Re: [PATCH v3 4/8] x86: stop exporting msr-index.h to userland
Message-ID: <20170113163836.jn3u6xyfcrbtynut@pd.tnic>
References: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25483.1484322229@warthog.procyon.org.uk>
 <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56308
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

On Fri, Jan 13, 2017 at 05:08:34PM +0100, Nicolas Dichtel wrote:
> Le 13/01/2017 à 16:43, David Howells a écrit :
> >> -header-y += msr-index.h
> > 
> > I see it on my desktop as /usr/include/asm/msr-index.h and it's been there at
> > least four years - and as such it's part of the UAPI.  I don't think you can
> > remove it unless you can guarantee there are no userspace users.
> I keep it in the v2 of the series, but the maintainer, Borislav Petkov, asks me
> to un-export it.
> 
> I will follow the maintainer decision.

I'm not the maintainer. I simply think that exporting that file was
wrong because it if we change something in it, we will break userspace.
And that should not happen - if userspace needs MSRs, it should do its
own defines.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
