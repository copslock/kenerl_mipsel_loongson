Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 16:41:11 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52485 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490959Ab0KIPlI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 16:41:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA9FeuH0030651;
        Tue, 9 Nov 2010 15:40:57 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA9FetFc030650;
        Tue, 9 Nov 2010 15:40:55 GMT
Date:   Tue, 9 Nov 2010 15:40:55 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Robert Millan <rmh@gnu.org>
Cc:     wu zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
Message-ID: <20101109154055.GD10799@linux-mips.org>
References: <AANLkTi=HjVCbghbH3LYHQfzh=qAPBV-0q_JnfkGPXyS1@mail.gmail.com>
 <AANLkTimbPpVmbrk13+KSF_DbBmfwjpeuzr2i7DMAKHbO@mail.gmail.com>
 <1289305442.31389.0@thorin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289305442.31389.0@thorin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 09, 2010 at 01:24:02PM +0100, Robert Millan wrote:

> El 09/11/10 10:48:34, en/na wu zhangjin va escriure:
> > Just rechecked this with a friend from Lemote, in reality, the
> > revision id of Loongson-2F is 0x3, so, my old code should be a
> > reference for you:
> > 
> > arch/mips/loongson/common/platform.c
> > 
> > PRID_REV_LOONGSON2F and PRID_REV_LOONGSON2E has already been defined
> > in arch/mips/include/asm/cpu.h
> > 
> > So, the manual is buggy, perhaps the editors of the manuals did copy
> > and paste for I have found the title of the 2F manual is the same as
> > the 2E manual ;-)
> 
> Thank you!  Then I suppose this will do it.

Looks technically ok; I just have a more stylistic problem with the patch:

> +			if (cpu == 0)
> +				__elf_platform = "loongson2e";

Cavium introduced this idion first.  Now your patch is repeating it and I'm
sure other SMP platforms will soon use it.   I don't want a thousand
if (cpu == 0) in that file, so can you cook a patch that introduces a
helper, something like

static void set_elf_platform(const char *plat)
{
	if (cpu == 0)
		__elf_platform = plat;
}

Then use that for all assignments to __elf_platform?  Thanks.

  Ralf
