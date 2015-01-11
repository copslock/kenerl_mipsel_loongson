Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 00:34:13 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35722 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011055AbbAKXeKifTch (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 00:34:10 +0100
Date:   Sun, 11 Jan 2015 23:34:10 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
In-Reply-To: <5493E97A.1070608@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501112322130.27458@eddie.linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com> <54932370.605@gmail.com> <5493E97A.1070608@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45073
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

On Fri, 19 Dec 2014, Markos Chandras wrote:

> >> The use of "add" instruction for immediate operations is wrong and
> >> relies to gas being smart enough to notice that and replace it with
> >> either addi or addui. However, MIPS R6 removed the addi instruction
> >> so, fix this problem properly by using the correct instruction
> >> directly.

 Not true, depending on the arguments the ADD assembly macro expands to 
either of the ADD and the ADDI hardware instructions; where an immediate 
outside the 16-bit signed range is used it also expands to a longer 
sequence involving LUI and the actual operation is ADD.  It never expands 
to ADDIU (which I gather you meant).

> > This is another case of the use of "add" being a real bug.  We should
> > never have faulting instructions like this in the kernel.
> > 
> > Can you send all patches in this set that fix this bug as a separate
> > patch?  Since they are obviously correct, and really should be used by
> > all non-R6 processors, we can get them in sooner that the entire R6 thing.
> > 
> > Thanks,
> > David Daney
> 
> sure i will move these patches away from R6 and post them separately.

 I think using the ADDU macro is preferred here as it allows arbitrary 
32-bit values for `off', just like with memory references in MIPS assembly 
instructions.

  Maciej
