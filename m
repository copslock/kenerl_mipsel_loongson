Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2008 17:51:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26768 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577026AbYA1Rv3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jan 2008 17:51:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0SHpSif015601;
	Mon, 28 Jan 2008 17:51:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0SHpS3b015600;
	Mon, 28 Jan 2008 17:51:28 GMT
Date:	Mon, 28 Jan 2008 17:51:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: your mail
Message-ID: <20080128175128.GA15115@linux-mips.org>
References: <20080122000026.GN28842@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080122000026.GN28842@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 22, 2008 at 12:00:26AM +0000, Thiemo Seufer wrote:

> This patch moves the micro-assembler in a separate implementation, as
> it is useful for further run-time optimizations. The only change in
> behaviour is cutting down printk noise at kernel startup time.
> 
> Checkpatch complains about macro parameters which aren't protected by
> parentheses. I believe this is a flaw in checkpatch, the paste operator
> used in those macros won't work with parenthesised parameters.
> 
> Tested on:
> - Qemu 32-bit little endian
> - BCM1480 64-bit big endian
> 
> 
> Thiemo
> 
> 
> ---
> Split the micro-assembler from tlbex.c.
> 
> Signed-off-by:  Thiemo Seufer <ths@networkno.de>

Looks technically ok but conflicts with these 7 other patches which also
touch arch/mips/mm/tlbex.c:

Please keep all the stuff the stuff that should go into the commit
message - and only that - above the "---" tearline.  git-am will drop
anything below it and friendly greetings, signatures etc. should not go
into the log message so keep that below the tearoff line.

commit 699a78e99f302003ae6d6090bf7f35eb69b772e0
Author: Manuel Lauss <mano@roarinelk.homelinux.net>
Date:   Thu Dec 6 09:07:55 2007 +0100

    [MIPS] Alchemy: Au1210/Au1250 CPU support
    
    This patch adds IDs for new Au1200 variants: Au1210 and Au1250.
    They are essentially identical to the Au1200 except for the Au1210
    which has a different SoC-ID in the PRId register [bits 31:24].
    The Au1250 is a "Au1200 V0.2".
    
    Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 56bccd5921f7b1160ddab0f9c3e9cc227ecd9aef
Author: Franck Bui-Huu <fbuihuu@gmail.com>
Date:   Thu Oct 18 09:11:17 2007 +0200

    [MIPS] tlbex.c: cleanup debug code
    
    Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 97432dc56d464006a62b1cd3ee6484828bde816c
Author: Franck Bui-Huu <fbuihuu@gmail.com>
Date:   Thu Oct 18 09:11:16 2007 +0200

    [MIPS] tlbex.c: use __cacheline_aligned instead of __tlb_handler_align
    
    Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 82e27810cd28e4322bd400640c8627ceacfc29f5
Author: Franck Bui-Huu <fbuihuu@gmail.com>
Date:   Thu Oct 18 09:11:15 2007 +0200

    [MIPS] tlbex.c: cleanup include files
    
    Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit b849ac81b87278c9b9e17aef8f4d82a30578ec93
Author: Franck Bui-Huu <fbuihuu@gmail.com>
Date:   Thu Oct 18 09:11:14 2007 +0200

    [MIPS] tlbex.c: Cleanup __init usages.
    
    Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit bf672b2f700d031d933c7dadcd9fae5edaa019b4
Author: Maciej W. Rozycki <macro@linux-mips.org>
Date:   Tue Oct 23 12:43:25 2007 +0100

    [MIPS] R4000/R4400 daddiu erratum workaround
    
     This complements the generic R4000/R4400 errata workaround code and adds
    bits for the daddiu problem.  In most places it just modifies handwritten
    assembly code so that the assembler is allowed to use a temporary register
    as daddiu may now be treated as a macro that expands to a sequence of li
    and daddu.  It is the AT register or, where AT is unavailable or used
    explicitly for another purpose, an explicitly-named register is selected,
    using the .set at=<reg> feature added recently to gas.  This feature is
    only used if CONFIG_CPU_DADDI_WORKAROUNDS has been set, so if the
    workaround remains disabled, the required version of binutils stays
    unchanged.
    
     Similarly, daddiu instructions put in branch delay slots in noreorder
    fragments are now taken out of them and the assembler is allowed to
    reorder them itself as possible (which it does making the whole idea of
    scheduling them into delay slots manually questionable).
    
     Also in the very few places where such a simple conversion was not
    possible, a handcoded longer sequence is implemented.
    
     Other than that there are changes to code responsible for building the
    TLB fault and page clear/copy handlers to avoid daddiu as appropriate.
    These are only effective if the erratum is verified to be present at the
    run time.
    
     Finally there is a trivial update to __delay(), because it uses daddiu in
    a branch delay slot.
    
    Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 2d220349159729f143570673f8752aafd6d8da74
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Mon Jan 28 17:14:10 2008 +0000

    [MIPS] tlbex: Cleanup handling of R2 hazards in TLB handlers.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

But I'm really happing to see the generalization we've been talking about
to finally proceed.

  Ralf
