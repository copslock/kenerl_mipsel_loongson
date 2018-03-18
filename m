Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 18:40:35 +0100 (CET)
Received: from zeniv.linux.org.uk ([195.92.253.2]:59826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeCRRk1OMRxh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 18:40:27 +0100
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1excI2-0006Pt-9P; Sun, 18 Mar 2018 17:40:14 +0000
Date:   Sun, 18 Mar 2018 17:40:14 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Message-ID: <20180318174014.GR30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-5-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ZenIV.linux.org.uk
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

On Sun, Mar 18, 2018 at 05:10:54PM +0100, Dominik Brodowski wrote:

> +#ifdef __ARCH_WANT_COMPAT_SYS_READAHEAD
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
> +		       unsigned int, off_lo, unsigned int, off_hi,
> +		       size_t, count)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
> +		       unsigned int, off_hi, unsigned int, off_lo,
> +		       size_t, count)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
> +		       unsigned int, off_lo, unsigned int, off_hi,
> +		       size_t, count)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
> +		       unsigned int, off_hi, unsigned int, off_lo,
> +		       size_t, count)
> +#endif
> +{
> +	return do_readahead(fd, ((u64) off_hi << 32) | off_lo, count);
>  }

*UGH*

static inline compat_to_u64(u32 w0, u32 w1)
{
#ifdef __BIG_ENDIAN
	return ((u64)w0 << 32) | w1;
#else
	return ((u64)w1 << 32) | w0;
#endif
}

in compat.h, then this turns into

#ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
		       u32, off0, u32 off1,
		       compat_size_t, count)
#else
COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
		       u32, off0, u32 off1,
		       compat_size_t, count)
#endif
{
	return do_readahead(fd, compat_to_u64(off0, off1), count);
}
