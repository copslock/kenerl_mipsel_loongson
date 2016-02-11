Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 16:30:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36170 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011283AbcBKPaNO4rpN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 16:30:13 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1BFUBDV008645;
        Thu, 11 Feb 2016 16:30:11 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1BFU9jE008644;
        Thu, 11 Feb 2016 16:30:09 +0100
Date:   Thu, 11 Feb 2016 16:30:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 2/2] mips: Differentiate between 32 and 64 bit ELF
 header
Message-ID: <20160211153009.GG11091@linux-mips.org>
References: <56BAD881.9000208@bmw-carit.de>
 <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1455096081-7176-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20160211104903.GD11091@linux-mips.org>
 <alpine.DEB.2.00.1602111153320.15885@tp.orcam.me.uk>
 <alpine.DEB.2.00.1602111430530.15885@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1602111430530.15885@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52009
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

On Thu, Feb 11, 2016 at 02:58:55PM +0000, Maciej W. Rozycki wrote:
> Date:   Thu, 11 Feb 2016 14:58:55 +0000
> From: "Maciej W. Rozycki" <macro@imgtec.com>
> To: Ralf Baechle <ralf@linux-mips.org>
> CC: Daniel Wagner <daniel.wagner@bmw-carit.de>,
>  linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
> Subject: Re: [PATCH v4 2/2] mips: Differentiate between 32 and 64 bit ELF
>  header
> Content-Type: text/plain; charset="ISO-8859-7"
> 
> On Thu, 11 Feb 2016, Maciej W. Rozycki wrote:
> 
> > > > Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> > > > Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
> > > > Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
> > > > Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> > > 
> > > Thanks, applied.
> > > 
> > > I'm getting a less spectacular warning from gcc 5.2:
> > > 
> > >   CC      fs/proc/vmcore.o
> > > fs/proc/vmcore.c: In function ‘parse_crash_elf64_headers’:
> > > fs/proc/vmcore.c:939:47: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > 
> >  Yes, the temporaries still need to have their pointed types changed, to 
> > `Elf32_Ehdr' and `Elf64_Ehdr' respectively, as in the original change.
> > 
> >  I had it mentioned in a WIP version of my review (stating that it would 
> > verify that the correct type is used by the caller), but then deleted that 
> > part inadvertently, sigh.
> 
>  Hold on, I was right in dropping it actually.
> 
>  With your v4 change in place all `parse_crash_elf64_headers' is supposed 
> to call is `mips_elf_check_machine' and that doesn't make any 
> intialisations, it just dereferences the pointer passed once.  This error 
> does not make any sense to me and line 939 isn't even in 
> `parse_crash_elf64_headers', which starts at line 999, it's in 
> `process_ptload_program_headers_elf32'.
> 
>  So Ralf, what tree are you using that is off from LMO/Linus by 60 lines?

That was 3.16, the oldest version affected.  But I'm getting the same
messages with different line numbers on more recent kernels including
the master branch.

  Ralf
