Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 16:59:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37957 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011804AbbASP7ZMClEY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 16:59:25 +0100
Date:   Mon, 19 Jan 2015 15:59:25 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 12/70] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
In-Reply-To: <1421405389-15512-13-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501190651440.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-13-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> The use of "add" instruction for immediate operations can result to
> build failures for MIPS R6. This is because, the 'add' is a macro in
> binutils and depending on the size of the immediate it can expand to
> an 'addi' instruction which has been removed from MIPS R6.
> Thus, we will be using the 'addu' macro instead, which also
> accepts immediate operands.
> 
> Link: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00121.html
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---

 This needs a title fix: s/addui/addu/; I'd suggest making the use of 
quotation marks consistent too on this occasion, e.g.:

MIPS: asm: asmmacro: Replace "add" instructions with "addu"

You might take the opportunity to decide on single or double quotes 
throughout the description too; right now it looks a bit messy to me.

 Other than that -- this is self-contained and an actual bug fix, 
irrelevant to R6.  I think it can and really should go in right away 
regardless of the outcome of the discussion on the other changes in this 
series.  Also to any stable branches where applicable; the change is so 
obvious that it cannot do any harm.

 So please resend this change with the title fix (and any description 
updates), and I'll give you my review acceptance tag to speed up 
processing.

 NB it looks to me like a followup change is needed to ensure the correct 
operation of these macros in 64-bit kernels, where a doubleword addition 
must be used instead for address calculation.  One way would be by using 
the PTR_ADDU preprocessor macro, but there are other possibilities as 
well.  This is not a requirement for this change to be accepted as far as 
I am concerned though.

 Thanks,

  Maciej
