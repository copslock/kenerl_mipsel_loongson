Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2017 16:03:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33280 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993898AbdCVPDVmPcCk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Mar 2017 16:03:21 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2MF3Ku9018610;
        Wed, 22 Mar 2017 16:03:20 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2MF3JXg018609;
        Wed, 22 Mar 2017 16:03:19 +0100
Date:   Wed, 22 Mar 2017 16:03:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, leonid.yegoshin@imgtec.com,
        douglas.leung@imgtec.com, aleksandar.markovic@imgtec.com,
        petar.jovanovic@imgtec.com, miodrag.dinic@imgtec.com,
        goran.ferenc@imgtec.com
Subject: Re: [PATCH 1/3] MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL
 identification
Message-ID: <20170322150319.GA14889@linux-mips.org>
References: <1489419397-25291-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1489419397-25291-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489419397-25291-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57415
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

On Mon, Mar 13, 2017 at 04:36:35PM +0100, Aleksandar Markovic wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> Fix the problem of inaccurate identification of instructions BLEZL and
> BGTZL in R2 emulation code by making sure all necessary encoding
> specifications are met.
> 
> Previously, certain R6 instructions could be identified as BLEZL or
> BGTZL. R2 emulation routine didn't take into account that both BLEZL
> and BGTZL instructions require their rt field (bits 20 to 16 of
> instruction encoding) to be 0, and that, at same time, if the value in
> that field is not 0, the encoding may represent a legitimate MIPS R6
> instruction.
> 
> This means that a problem could occur after emulation optimization,
> when emulation routine tried to pipeline emulation, picked up a next
> candidate, and subsequently misrecognized an R6 instruction as BLEZL
> or BGTZL.
> 
> It should be said that for single pass strategy, the problem does not
> happen because CPU doesn't trap on branch-compacts which share opcode
> space with BLEZL/BGTZL (but have rt field != 0, of course).
> 
> Signed-off-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtech.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
> Reported-by: Douglas Leung <douglas.leung@imgtec.com>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>

Thanks for sorting out the review comments on v1.

Applied,

  Ralf
