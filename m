Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 02:22:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42761 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011719AbbATBWYtnPAA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 02:22:24 +0100
Date:   Tue, 20 Jan 2015 01:22:24 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 27/70] MIPS: kernel: cevt-r4k: Add MIPS R6 to the
 c0_compare_interrupt handler
In-Reply-To: <1421405389-15512-28-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501200110040.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-28-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45346
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

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> Just like MIPS R2, in MIPS R6 it is possible to determine if a
> timer interrupt has happened or not.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---

 While a preexisting bug, this is simply not true, there's CP0.Cause.TI to 
examine for a timer interrupt pending.  Please fix your change to use 
`c0_compare_int_pending' instead and synchronise with stuff posted by 
James (cc-ed) at <http://patchwork.linux-mips.org/patch/8900/>.

  Maciej
