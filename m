Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 15:58:19 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45540 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011490AbbAMO6Rm0b6u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 15:58:17 +0100
Date:   Tue, 13 Jan 2015 14:58:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
In-Reply-To: <54B519DE.4010708@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501131455530.23937@eddie.linux-mips.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com> <54932370.605@gmail.com> <5493E97A.1070608@imgtec.com> <alpine.LFD.2.11.1501112322130.27458@eddie.linux-mips.org>
 <54B519DE.4010708@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45101
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

> >  I think using the ADDU macro is preferred here as it allows arbitrary 
> > 32-bit values for `off', just like with memory references in MIPS assembly 
> > instructions.
> 
> What ADDU macro?

 This:

{"addu",		"t,r,I",	0,    (int) M_ADDU_I,	INSN_MACRO,		0,		I1,		0,	0 },

(from opcodes/mips-opc.c).

  Maciej
