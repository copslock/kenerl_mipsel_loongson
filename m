Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Oct 2010 15:28:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44211 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491033Ab0J3N2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Oct 2010 15:28:49 +0200
Date:   Sat, 30 Oct 2010 14:28:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, John Reiser <jreiser@bitwagon.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 3/3] ftrace/MIPS: Enable C Version of recordmcount
In-Reply-To: <1288186564.18238.126.camel@gandalf.stny.rr.com>
Message-ID: <alpine.LFD.2.00.1010301414060.25426@eddie.linux-mips.org>
References: <cover.1288176026.git.wuzhangjin@gmail.com>         <bb99009a9ac79d3f55a8c8bf1c8bd2bc0e1f160e.1288176026.git.wuzhangjin@gmail.com> <1288186564.18238.126.camel@gandalf.stny.rr.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Oct 2010, Steven Rostedt wrote:

> On Wed, 2010-10-27 at 18:59 +0800, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > Selects HAVE_C_RECORDMCOUNT to use the C version of the recordmcount
> > intead of the old Perl Version of recordmcount.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> I'd like to get an Acked-by from Ralf and Maciej on this.

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 I have looked through it and spotted nothing obviously wrong, but I can't 
afford any further testing, especially at run time, sorry.

 One point to note -- it seems to me the code currently assumes a 32-bit 
model, i.e. the use of the -msym32 GCC option suitable for a 64-bit kernel 
loaded to a CKSEG0 address (cf. KBUILD_SYM32 in arch/mips/Makefile), tools 
support permitting.  That means it does not (correctly) support kernels 
loaded to an XPHYS address as required for some platforms (or otherwise 
chosen for testing such a configuration; modulo some processor errata and 
bootloader limitations, it is generally OK to run the kernel from XPHYS on 
64-bit chips even if the entire RAM fits into CKSEG0).

 For the avoidance of doubt -- I'm just mentioning it to emphasise a 
possible future direction for improvement of this code -- not an objection 
against this submission, that is certainly a good foundation for future 
development.

 Thanks to everybody involved.

  Maciej
