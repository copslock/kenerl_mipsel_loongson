Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2011 22:37:13 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54152 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903637Ab1LDVhJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2011 22:37:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2OY5smcNkF9QTn/tdYd0eNNGBIQr3Clq2NF9gAwDXqc=;
        b=DM8S+/XHUw8nS7LEFE0uO7qZUdbe7a05QNYAsjLibTohm4vtPtw+EJKhpt8ji92bRSG/yqbZf7NhMWmYdXFxCjhYmYwY162Ymnyi41awmV2A3SVPPG0G0SZRIyUwQJN8eTyElgb/BbmXEy2KwVtKBFWU10pixh/mVY6VA+Ko4Zg=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:50678)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1RXJgU-0002Fd-It; Sun, 04 Dec 2011 21:33:19 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1RXJgS-00080y-GV; Sun, 04 Dec 2011 21:33:16 +0000
Date:   Sun, 4 Dec 2011 21:33:16 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Randy Dunlap <rdunlap@xenotime.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org
Subject: Re: [PATCHv5] atomic: add *_dec_not_zero
Message-ID: <20111204213316.GB14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323013369-29691-1-git-send-email-sven@narfation.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 32022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2732

On Sun, Dec 04, 2011 at 04:42:49PM +0100, Sven Eckelmann wrote:
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)

I think this is rather silly - all these definitions are very similar to
each other.  Is there really no way to put this into include/linux/atomic.h,
maybe as something like:

#ifndef atomic64_dec_not_zero
#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
#endif

and avoid having to add essentially the same definition to 12 individual
files?

Architectures which want to override it can do by the following:

#define atomic64_dec_not_zero		atomic64_dec_not_zero

which won't have any effect on C nor asm code.
