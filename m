Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 18:50:10 +0100 (CET)
Received: from zeniv.linux.org.uk ([195.92.253.2]:60014 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeCRRuBpa-mh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 18:50:01 +0100
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1excRQ-0006v8-AE; Sun, 18 Mar 2018 17:49:56 +0000
Date:   Sun, 18 Mar 2018 17:49:56 +0000
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
Subject: Re: [RFC PATCH 2/6] fs: provide a generic compat_sys_truncate64()
 implementation
Message-ID: <20180318174956.GS30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-3-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63034
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

On Sun, Mar 18, 2018 at 05:10:52PM +0100, Dominik Brodowski wrote:

> +#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_low, unsigned int, offset_high)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_high, unsigned int, offset_low)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +		       unsigned int, offset_low, unsigned int, offset_high)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +		       unsigned int, offset_high, unsigned int, offset_low)
> +#endif
> +{
> +#ifdef CONFIG_SPARC
> +	if ((int) offset_high < 0)
> +		return -EINVAL;
> +#endif
> +	return do_sys_truncate(filename,
> +			       ((loff_t) offset_high << 32) | offset_low);
> +}
> +#endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */

Ow...

For one thing, the same observation as for readahead(2).  For another, that
sparc-specific test is very suspicious, innit?  Let's take a look at
do_sys_truncate():
static long do_sys_truncate(const char __user *pathname, loff_t length)
{
        unsigned int lookup_flags = LOOKUP_FOLLOW;
        struct path path;
        int error;

        if (length < 0) /* sorry, but loff_t says... */
                return -EINVAL;

So in case of offset_high having bit 31 set, we would get length with bit 63 set,
and step into that if (length < 0) return -EINVAL;

Sure, any set of texts can be combined, given a sufficiently large pile of ifdefs,
but you are replacing an arseload of almost but not quite identical functions
spread all over the tree with something that is in one place, but is awfully hard
to look at, nevermind reading it...
