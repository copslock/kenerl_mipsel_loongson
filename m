Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:46:13 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008166AbbCENqLjfIw5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 14:46:11 +0100
Date:   Thu, 5 Mar 2015 13:46:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: asm: r4kcache: Use correct base register for
 MIPS R6 cache flushes
In-Reply-To: <1425408530-21613-2-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1503050245540.18344@eddie.linux-mips.org>
References: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com> <1425408530-21613-2-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46205
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

On Tue, 3 Mar 2015, Markos Chandras wrote:

> Commit 934c79231c1b("MIPS: asm: r4kcache: Add MIPS R6 cache unroll
> functions") added support for MIPS R6 cache flushes but it used the
> wrong base address register to perform the flushes so the same lines
> were flushed over and over. Moreover, replace the "addiu" instructions
> with LONG_ADDIU so the correct base address is calculated for 64-bit
> cores.

 Since this operates on addresses shouldn't PTR_ADDIU be used instead?

  Maciej
