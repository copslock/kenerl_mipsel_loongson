Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 23:38:10 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:34088 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993456AbcHLViC4igLP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 23:38:02 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-167-73-nat.elisa-mobile.fi [85.76.167.73])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 3D13B3FDF;
        Sat, 13 Aug 2016 00:38:02 +0300 (EEST)
Date:   Sat, 13 Aug 2016 00:38:01 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: OCTEON: Changes to support readq()/writeq() usage.
Message-ID: <20160812213801.GC10648@raspberrypi.musicnaut.iki.fi>
References: <5780652D.2030604@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5780652D.2030604@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Fri, Jul 08, 2016 at 09:45:01PM -0500, Steven J. Hill wrote:
> Update OCTEON port mangling code to support readq() and
> writeq() functions to allow driver code to be more portable.
> Updates also for word and long function pairs. We also
> remove SWAP_IO_SPACE for OCTEON platforms as the function
> macros are redundant with the new mangling code.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

[...]

> +static inline bool __should_swizzle_bits(volatile void *a)
> +{
> +	extern const bool octeon_should_swizzle_table[];
> +
> +	unsigned long did = ((unsigned long)a >> 40) & 0xff;
> +	return octeon_should_swizzle_table[did];
> +}

v4.8-rc1 OCTEON build is now broken with GCC 6.1 when support for 32-bit
ABIs is enabled:

  CC      arch/mips/vdso/gettimeofday-o32.o
In file included from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/includ
e/asm/io.h:32:0,
                 from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/includ
e/asm/page.h:194,
                 from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/vdso/v
dso.h:26,
                 from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/vdso/g
ettimeofday.c:11:
/home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/include/asm/mach-cavium-octe
on/mangle-port.h: In function '__should_swizzle_bits':
/home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/include/asm/mach-cavium-octe
on/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift
-count-overflow]
  unsigned long did = ((unsigned long)a >> 40) & 0xff;

A.
