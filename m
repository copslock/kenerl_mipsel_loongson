Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 13:00:50 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:42264
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992278AbdAIMAnnVrfc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 13:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=jktjZiQqGTR9TYJRzbsj/BKIvXGMeeij7yFYa9vwtFg=;
        b=KUgmboMQX05vDWqoFVL+X9VySNMwxyiVR/1HlsvCMR29qhGZ7edgJOvmvsVJHs/nvcfVoRSQRPRXgOyublpgIXXVe5kZ/gXGZwvrgvmptGta6TXlZZr+X/ORt+h21fdmfyl1izCGK309ruFfh+dHeKNI2YoM3SDcpZDB8tlwBko=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:37295)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1cQYca-0005pf-E0; Mon, 09 Jan 2017 12:00:16 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1cQYcQ-0004Re-68; Mon, 09 Jan 2017 12:00:06 +0000
Date:   Mon, 9 Jan 2017 12:00:04 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
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
        openrisc@lists.librecores.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mmarek@suse.com,
        netfilter-devel@vger.kernel.org, linux-alpha@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, davem@davemloft.net
Subject: Re: [PATCH v2 1/7] arm: put types.h in uapi
Message-ID: <20170109120004.GV14217@n2100.armlinux.org.uk>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-2-git-send-email-nicolas.dichtel@6wind.com>
 <1990589.0aJHWbJK4F@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1990589.0aJHWbJK4F@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56229
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

On Mon, Jan 09, 2017 at 12:33:02PM +0100, Arnd Bergmann wrote:
> On Friday, January 6, 2017 10:43:53 AM CET Nicolas Dichtel wrote:
> > 
> > diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
> > index a53cdb8f068c..c48fee3d7b3b 100644
> > --- a/arch/arm/include/asm/types.h
> > +++ b/arch/arm/include/asm/types.h
> > @@ -1,40 +1,6 @@
> >  #ifndef _ASM_TYPES_H
> >  #define _ASM_TYPES_H
> >  
> > -#include <asm-generic/int-ll64.h>
> ...
> > -#define __UINTPTR_TYPE__       unsigned long
> > -#endif
> > +#include <uapi/asm/types.h>
> >  
> >  #endif /* _ASM_TYPES_H */
> > 
> 
> Moving the file is correct as far as I can tell, but the extra
> #include is not necessary here, as the kernel will automatically
> search both arch/arm/include/ and arch/arm/include/uapi/.

Indeed, I'd like to see the include/asm file gone.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
