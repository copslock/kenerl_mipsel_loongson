Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 21:49:42 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:16403 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993302AbdJCTtgLqKya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 21:49:36 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id BAA053F6AC;
        Tue,  3 Oct 2017 21:49:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Setovxr4Kq5Z; Tue,  3 Oct 2017 21:49:26 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id A1CCE3F3EA;
        Tue,  3 Oct 2017 21:49:19 +0200 (CEST)
Date:   Tue, 3 Oct 2017 21:49:17 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171003194916.GA9633@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
 <20170922163753.GA2415@localhost.localdomain>
 <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
 <20170930182608.GB7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60241
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

>  Hmm, this looks consistent with the TX79 manual:
> 
> "6.2.1 Virtual Address Space
> 
> The C790 only implements 32 bits of virtual address space.  There is no 
> requirement for address sign extension and no checking will be done on the 
> upper 32 bits of the address."
> 
> and then say in the JAL instruction description:
> 
> "I: GPR[31] 63..0 <- zero_extend (PC + 8)"
> 
> It does not matter for the user mode where bit #31 is 0 and therefore both 
> zero-extension and sign-extension produce the same result, so the typical 
> PIC code sequence used to determine its own location, i.e.:
> 
> 	la	$2, 0f
> 	bltzal	$0, 0f
> 0:
> 	subu	$2, $31, $2
> 
> will work correctly, not causing UB with the SUBU instruction.
> 
>  However it does cause complications for the kernel in that the value of 
> $ra retrieved cannot be readily used for 32-bit calculations and has to be 
> treated with SLL by 0 first.  You'll have to audit the arch/mips subtree 
> for any such $ra use for calculation; hopefully are there's none.
> 
>  I wonder why they broke it like this -- was it a silly deliberate choice 
> or merely an oversight (erratum) they chose to document rather than fix? 
> For a change they do implement MFC0 with sign-extension, so retrieving 
> e.g. CP0.EPC will see kernel addresses correctly sign-extended.

After some further tests, it appears that for $ra, save/restore works with
both SW/LW and SW/LWU. Hence, $ra bits 63:32 do not seem to matter at all
(as intended), and its sign-extension failure can therefore be disregarded.
This is somewhat non-obvious since $ra is the only register that fails to
sign-extend after kernel initialisation (and consequently trigger a trap).

>  Anyway, as noted above that shouldn't cause a problem with user software 
> and I think that any corruption you can see comes from elsewhere.  You'll 
> have to paper this $ra non-sign-extension issue over somehow to proceed 
> though.

During early kernel initialisation at least one other register (besides
$ra) appears to fail the sign-extension test, and the error cannot be
ignored. I will now try figure this out.

Fredrik
