Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 20:06:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46235 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008849AbaLRTGWE3V3B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Dec 2014 20:06:22 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBIJ6K8S008467;
        Thu, 18 Dec 2014 20:06:20 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBIJ6KER008466;
        Thu, 18 Dec 2014 20:06:20 +0100
Date:   Thu, 18 Dec 2014 20:06:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 24/67] MIPS: asm: spinlock: Replace sub instruction
 with addiu
Message-ID: <20141218190620.GB8221@linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
 <1418915416-3196-25-git-send-email-markos.chandras@imgtec.com>
 <54932291.1040509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54932291.1040509@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44812
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

On Thu, Dec 18, 2014 at 10:53:05AM -0800, David Daney wrote:

> On 12/18/2014 07:09 AM, Markos Chandras wrote:
> >sub $reg, imm is not a real MIPS instruction. The assembler replaces
> >that with 'addi $reg, -imm'.
> 
> That is a bug right there.  We cannot have faulting instructions like this
> in the kernel.

The instruction is meant to kill the kernel if a readlock gets unlocked
more often than it was taken.  Think of it as an efficient method of
implementing a BUG_ON() for this condition.

I've only seen that overflow exception once and honestly, the primary
reason was my desparate search for a rarely used CPU feature.  So if
this ADDI is repaced by an ADDIU I won't be sad.

  Ralf
