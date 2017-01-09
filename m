Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 13:01:33 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:42314
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992278AbdAIMBYUJwyc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 13:01:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ids+U8uv4m2VXYi9TPpEO/B4YwgCpc0T6RAdDMZ4npc=;
        b=HoI3akt0XPLXuot0tNN9OJjGNg4Ddj6JZPlXwkyU+cSOly0Oe/3pMs9Ybjo9zq/AurBVSIOeunfBaAJoYfA7/uMsw0TgqDtQQScr/CuAh2bOCKeqnLWl2ZylQWoiaRhOr0TVUDF4oOiqQN54K3bFAqipxEhWlTq6kRKYQgA1pas=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:37300)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1cQYdb-0005qh-2H; Mon, 09 Jan 2017 12:01:19 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1cQYdR-0004T1-4f; Mon, 09 Jan 2017 12:01:09 +0000
Date:   Mon, 9 Jan 2017 12:01:08 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     arnd@arndb.de, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, airlied@linux.ie,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org,
        linux-rdma@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, coreteam@netfilter.org,
        fcoe-devel@open-fcoe.org, xen-devel@lists.xenproject.org,
        linux-snps-arc@lists.infradead.org, linux-media@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        mmarek@suse.com, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: Re: [PATCH v2 7/7] uapi: export all headers under uapi directories
Message-ID: <20170109120107.GW14217@n2100.armlinux.org.uk>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
> diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
> index 46a76cd6acb6..607f702c2d62 100644
> --- a/arch/arm/include/uapi/asm/Kbuild
> +++ b/arch/arm/include/uapi/asm/Kbuild
> @@ -1,23 +1,6 @@
>  # UAPI Header export list
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -header-y += auxvec.h
> -header-y += byteorder.h
> -header-y += fcntl.h
> -header-y += hwcap.h
> -header-y += ioctls.h
> -header-y += kvm_para.h
> -header-y += mman.h
> -header-y += perf_regs.h
> -header-y += posix_types.h
> -header-y += ptrace.h
> -header-y += setup.h
> -header-y += sigcontext.h
> -header-y += signal.h
> -header-y += stat.h
> -header-y += statfs.h
> -header-y += swab.h
> -header-y += unistd.h
>  genhdr-y += unistd-common.h
>  genhdr-y += unistd-oabi.h
>  genhdr-y += unistd-eabi.h

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
