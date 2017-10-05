Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 21:04:54 +0200 (CEST)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:33835 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993608AbdJETErlUKNl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 21:04:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id ABE303F579;
        Thu,  5 Oct 2017 21:04:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id btykG2730nUA; Thu,  5 Oct 2017 21:04:36 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 624DC3F5DD;
        Thu,  5 Oct 2017 21:04:26 +0200 (CEST)
Date:   Thu, 5 Oct 2017 21:04:20 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171005190419.GA21833@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003194916.GA9633@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

> >  Anyway, as noted above that shouldn't cause a problem with user software
> > and I think that any corruption you can see comes from elsewhere.  You'll
> > have to paper this $ra non-sign-extension issue over somehow to proceed
> > though.
> 
> During early kernel initialisation at least one other register (besides
> $ra) appears to fail the sign-extension test, and the error cannot be
> ignored. I will now try figure this out.

Trap 12 is causing kernel inconvenience resulting in "kernel bug" crashes
when triggering sign-extension failures for the remaining registers. As a
less intrusive measure I've collected some statistics:

Failed registers are marked by bit position in 0x8000FF74, hence 
registers $v0, $a0-$a2, $t0-$t7 and $ra fail the sign-extension test.

Problems are present during kernel initialisation, so either 1) the R5900
is not really 32-bit compatible, 2) the compiler is somehow generating
64-bit code, 3) assembler directives in the R5900 patch produce 64-bit code,
or 4) the sign-extension tests are wrong (or a combination of the above).

In principle, I suppose one could carefully write assembly code to save
all registers and stack traces in a reserved memory area for later
examination, avoiding "kernel bug" crashes when immediately triggering
trap 12 in a sensitive kernel context.

What are your thoughts on how to proceed?

Fredrik
