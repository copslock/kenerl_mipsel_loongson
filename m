Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2016 09:19:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11047 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992847AbcJ1HT1eEh7s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2016 09:19:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 14472FC8F7086;
        Fri, 28 Oct 2016 08:19:18 +0100 (IST)
Received: from [10.20.78.229] (10.20.78.229) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 28 Oct 2016
 08:19:19 +0100
Date:   Fri, 28 Oct 2016 08:19:10 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] More FCSR handling fixes
Message-ID: <alpine.DEB.2.00.1610272159160.31859@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.229]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi,

 Here are some further fixes to our FCSR handling.  Just 2 changes at this 
time.

 The first, very small one, closes an issue where a write made with 
ptrace(PTRACE_POKEUSR, ...) to FCSR does not mark the FP context as used.  
This is the legacy interface, seldom used these days, having been largely 
replaced with ptrace(PTRACE_SETFPREGS, ...), so the problem may have 
escaped easily.  Fixed now.

 The second, larger one, addresses the handling of the Cause bits, by 
letting them remain set in some cases, making their semantics more 
consistent with what hardware does when undisturbed; a SIGFPE signal is 
sent if appropriate where previously it was missed.

 This change is not final as in some cases, specifically in the FP context 
of SIGFPE's signal frame, active Cause bits that match Enable bits will 
still be recorded as clear even though they were originally set, being the 
reason for the signal.  Consequently the signal will not retrigger if the 
handler returns with the FP context unchanged in the signal frame.  This 
is unlike with other signals triggered by a hardware exception which do 
require a corrective action if a return is intended rather than an escape 
via `longjmp' or suchlike and which is what one would expect here as well.

 I plan to address this final issue with a further change in the future, 
however I have not started this effort yet and I don't have a schedule 
set.  Meanwhile this change is I believe a step in the right direction.

 Details of both changes have been provided with individual patch 
descriptions.

 While making these changes I have noticed a bunch of bitrot issues we 
have with the handling of the FP context in signal frames with MIPS I-II 
processors.  I will submit corrections as a separate patch series.

 Questions or comments are welcome, as usually, and otherwise please queue
for the next merge cycle.

  Maciej
