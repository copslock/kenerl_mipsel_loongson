Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2015 20:50:21 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013405AbbBMTuSifeZ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2015 20:50:18 +0100
Date:   Fri, 13 Feb 2015 19:50:18 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Andreas Ruprecht <rupran@einserver.de>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] MIPS: mm: Remove dead macro definitions
In-Reply-To: <1423748572-31012-1-git-send-email-rupran@einserver.de>
Message-ID: <alpine.LFD.2.11.1502131949190.22715@eddie.linux-mips.org>
References: <1423748572-31012-1-git-send-email-rupran@einserver.de>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45813
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

On Thu, 12 Feb 2015, Andreas Ruprecht wrote:

> In commit c441d4a54c6e ("MIPS: mm: Only build one microassembler that
> is suitable"), the Makefile at arch/mips/mm was rewritten to only
> build the "right" microassembler file, depending on whether
> CONFIG_CPU_MICROMIPS is set or not.
> 
> In the files, however, there are still preprocessor definitions
> depending on CONFIG_CPU_MICROMIPS. The #ifdef around them can now
> never evaluate to true, so let's remove them altogether.
> 
> This inconsistency was found using the undertaker-checkpatch tool.
> 
> Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
> ---

Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>

 Thanks for catching it!

  Maciej
