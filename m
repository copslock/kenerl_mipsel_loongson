Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 22:38:21 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:35912
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdCDViOxCgzZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 22:38:14 +0100
Received: by mail-pf0-x244.google.com with SMTP id j5so13394461pfb.3;
        Sat, 04 Mar 2017 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T113F+LWsK49MRaodrq2aciYSICth59XP9jp5xA1kko=;
        b=apTR96C/GNcWpeWdyQkpDSafUrb8wElWcNvymUxrEY/ivy367a28/jUymjHvEOk+3K
         l+5AKPhZygzq13R17gkTT0trDZzZiUmojHhnN6fmsVtKNox+Un17K0B5qQxqTCbQLFGl
         YACikrTEw3rdoCGirBahnKwhVEaOwE9FiFvtS9s+tr1nUwdCJwyXexbMt9zB7OWaFP2s
         EGc2F/vDoxjaDT2HuugXFg56EsBvMEFfpq8/kVkMVoR4nSlZky46EbeMlG77B2FsJPqJ
         wkGGSJYllkaf7F9GcJtfMSPx5hgfS/xNoNWn0ADB5Cr6RQEVoT3z7csX4a4ImuR+r1X7
         NTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T113F+LWsK49MRaodrq2aciYSICth59XP9jp5xA1kko=;
        b=GNpLLu6lra8Hg0QuXmsPAaD3I0c/oIT2vG3dYkLK1BAzSYXfcIW5S6pEbEoGQJVaWq
         yRJ+6n0krKsYhT8MtYayvoBd9GcX/+vy4UJxaGnaLCJWsvZiCT5/NuKHIdgCAxQ1qAWW
         /TLgUhLlC+pNk2Wa5LK3C6MWFiD8pRLcJLbtqDjv3oXHDeTbl/1vsEkvFo5wJFhQw0Tx
         KHKxVtB9HWbm+ouqW0cJ/wT4A15zUERARK2CYCgTTdJ1MGli4ZwNGxmxx9hUhbJnv2Zn
         mbSPMkBVe9piZ9cfvA/pnFDCU7iWmcYxsdiNWcS+ySc7GoF2KgX8IJ9SyuF3kjJNMkEA
         zhew==
X-Gm-Message-State: AMke39lu8O5sZSDVoq6vCrVi7rReXqj8ZZazCxlrOBVavtBqXOKpTN5Fb6o/dS4f5HuO0g==
X-Received: by 10.84.231.207 with SMTP id g15mr9405976pln.2.1488663488907;
        Sat, 04 Mar 2017 13:38:08 -0800 (PST)
Received: from localhost (z254.124-44-183.ppp.wakwak.ne.jp. [124.44.183.254])
        by smtp.gmail.com with ESMTPSA id s3sm31043661pgn.55.2017.03.04.13.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Mar 2017 13:38:07 -0800 (PST)
Date:   Sun, 5 Mar 2017 06:38:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] futex: remove duplicated code
Message-ID: <20170304213805.GA2449@lianli.shorne-pla.net>
References: <20170303122712.13353-1-jslaby@suse.cz>
 <20170304130550.GT21222@n2100.armlinux.org.uk>
 <3994975e-89a5-d2b5-60be-a8633ddc3733@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3994975e-89a5-d2b5-60be-a8633ddc3733@zytor.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <shorne@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shorne@gmail.com
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

On Sat, Mar 04, 2017 at 11:15:17AM -0800, H. Peter Anvin wrote:
> On 03/04/17 05:05, Russell King - ARM Linux wrote:
> >>  
> >> +static int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
> >> +{
> >> +	int op = (encoded_op >> 28) & 7;
> >> +	int cmp = (encoded_op >> 24) & 15;
> >> +	int oparg = (encoded_op << 8) >> 20;
> >> +	int cmparg = (encoded_op << 20) >> 20;
> > 
> > Hmm.  oparg and cmparg look like they're doing these shifts to get sign
> > extension of the 12-bit values by assuming that "int" is 32-bit -
> > probably worth a comment, or for safety, they should be "s32" so it's
> > not dependent on the bit-width of "int".
> > 
> 
> For readability, perhaps we should make sign- and zero-extension an
> explicit facility?

There is some of this in already here, 32 and 64 bit versions:

  include/linux/bitops.h

Do we really need zero extension? It seems the same.

Example implementation from bitops.h

static inline __s32 sign_extend32(__u32 value, int index)
{
        __u8 shift = 31 - index;
        return (__s32)(value << shift) >> shift;
}

> /*
>  * Truncate an integer x to n bits, using sign- or
>  * zero-extension, respectively.
>  */
> static inline __const_func__ s32 sex32(s32 x, int n)
> {
>   return (x << (32-n)) >> (32-n);
> }
> 
> static inline __const_func__ s64 sex64(s64 x, int n)
> {
>   return (x << (64-n)) >> (64-n);
> }
> 
> #define sex(x,y)						\
> 	((__typeof__(x))					\
> 	 (((__builtin_constant_p(y) && ((y) <= 32)) ||		\
> 	   (sizeof(x) <= sizeof(s32)))				\
> 	  ? sex32((x),(y)) : sex64((x),(y))))
> 
> static inline __const_func__ u32 zex32(u32 x, int n)
> {
>   return (x << (32-n)) >> (32-n);
> }
> 
> static inline __const_func__ u64 zex64(u64 x, int n)
> {
>   return (x << (64-n)) >> (64-n);
> }
> 
> #define zex(x,y)						\
> 	((__typeof__(x))					\
> 	 (((__builtin_constant_p(y) && ((y) <= 32)) ||		\
> 	   (sizeof(x) <= sizeof(u32)))				\
> 	  ? zex32((x),(y)) : zex64((x),(y))))
> 
