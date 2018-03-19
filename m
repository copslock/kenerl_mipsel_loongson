Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 07:30:51 +0100 (CET)
Received: from la.guarana.org ([173.254.219.205]:60872 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990403AbeCSGalTxUEr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Mar 2018 07:30:41 +0100
Received: by la.guarana.org (Postfix, from userid 1006)
        id C0C94346001A; Mon, 19 Mar 2018 02:29:30 -0400 (EDT)
Date:   Mon, 19 Mar 2018 02:29:29 -0400
From:   Kevin Easton <kevin@guarana.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, viro@ZenIV.linux.org.uk, linux-arch@vger.kernel.org,
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
Message-ID: <20180319062928.GA11309@la.guarana.org>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-3-linux@dominikbrodowski.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <caf@la.guarana.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin@guarana.org
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
> The compat_sys_truncate64() implementations in mips, powerpc, s390, sparc
> and x86 only differed based on whether the u64 parameter needed padding
> and on its endianness.
> 

...
  
> +#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_low, unsigned int, offset_high)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_high, unsigned int, offset_low)

Notwithstanding the other comments, shouldn't there be a comma between
'u32' and 'padding' in those?

    - Kevin
