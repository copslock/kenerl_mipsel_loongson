Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 16:24:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45961 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011490AbbAMPY13KgLM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 16:24:27 +0100
Date:   Tue, 13 Jan 2015 15:24:27 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
In-Reply-To: <54B533EF.1090201@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501131506310.23937@eddie.linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com> <54932370.605@gmail.com> <5493E97A.1070608@imgtec.com> <alpine.LFD.2.11.1501112322130.27458@eddie.linux-mips.org>
 <54B519DE.4010708@imgtec.com> <alpine.LFD.2.11.1501131455530.23937@eddie.linux-mips.org> <54B533EF.1090201@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45104
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

On Tue, 13 Jan 2015, Markos Chandras wrote:

> >> What ADDU macro?
> > 
> >  This:
> > 
> > {"addu",		"t,r,I",	0,    (int) M_ADDU_I,	INSN_MACRO,		0,		I1,		0,	0 },
> > 
> > (from opcodes/mips-opc.c).
> 
> I see your point about having 32-bit offsets supported here but it's not
> obvious that addu would simply accept this format without looking at the
> binutils sources.

 All MIPS assemblers support it AFAIK, including SGI's MIPSpro and the 
original MIPS Co. assembler.

 You will have it documented in any reasonable MIPS assembly language 
manual, and other books on the MIPS architecture will have it too.  All 
MIPS ALU operations have a corresponding macro that handles an arbitrary 
third argument, including 32-bit immediates, e.g. AND, NOR, SUBU, etc.  
Some branches and other operations are macros too.

 If you have been unaware of this fact, then I suggest you that you have a 
look at a MIPS assembly book, e.g. the book I started with had all the 
macros and what they actually expand to listed, in addition to true 
hardware instructions up to MIPS IV.

  Maciej
