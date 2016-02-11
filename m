Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 11:49:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56384 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012336AbcBKKtFslGuR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 11:49:05 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1BAn4v1003576;
        Thu, 11 Feb 2016 11:49:04 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1BAn3fA003575;
        Thu, 11 Feb 2016 11:49:03 +0100
Date:   Thu, 11 Feb 2016 11:49:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 2/2] mips: Differentiate between 32 and 64 bit ELF
 header
Message-ID: <20160211104903.GD11091@linux-mips.org>
References: <56BAD881.9000208@bmw-carit.de>
 <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1455096081-7176-3-git-send-email-daniel.wagner@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1455096081-7176-3-git-send-email-daniel.wagner@bmw-carit.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Feb 10, 2016 at 10:21:21AM +0100, Daniel Wagner wrote:

> Depending on the configuration either the 32 or 64 bit version of
> elf_check_arch() is defined. parse_crash_elf{32|64}_headers() does
> some basic verification of the ELF header via
> vmcore_elf{32|64}_check_arch() which happen to map to elf_check_arch().
> Since the implementation 32 and 64 bit version of elf_check_arch()
> differ, we use the wrong type:
> 
>    In file included from include/linux/elf.h:4:0,
>                     from fs/proc/vmcore.c:13:
>    fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
> >> arch/mips/include/asm/elf.h:228:23: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      struct elfhdr *__h = (hdr);     \
>                           ^
>    include/linux/crash_dump.h:41:37: note: in expansion of macro 'elf_check_arch'
>     #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
>                                         ^
>    fs/proc/vmcore.c:1015:4: note: in expansion of macro 'vmcore_elf64_check_arch'
>       !vmcore_elf64_check_arch(&ehdr) ||
>        ^
> 
> Therefore, we rather define vmcore_elf{32|64}_check_arch() as a
> basic machine check and use it also in binfm_elf?32.c as well.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>

Thanks, applied.

I'm getting a less spectacular warning from gcc 5.2:

  CC      fs/proc/vmcore.o
fs/proc/vmcore.c: In function ‘parse_crash_elf64_headers’:
fs/proc/vmcore.c:939:47: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]

  Ralf
