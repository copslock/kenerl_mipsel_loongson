Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2014 05:04:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50179 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821742AbaEEDEG2sKoq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 May 2014 05:04:06 +0200
Date:   Mon, 5 May 2014 04:04:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: microMIPS: Work around an assembler bug.
In-Reply-To: <5345A2EB.8020109@imgtec.com>
Message-ID: <alpine.LFD.2.11.1405050400530.21408@eddie.linux-mips.org>
References: <1396892446-23883-1-git-send-email-Steven.Hill@imgtec.com> <5345A2EB.8020109@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40019
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

On Wed, 9 Apr 2014, Steven J. Hill wrote:

> > In newer toolchains, the 16-bit branch delay slot instruction
> > calculation is wrong. We get a message very similar to:
> > 
> >    {standard input}: Assembler messages:
> >    {standard input}:7035: Warning: wrong size instruction
> >    in a 16-bit branch delay slot
> > 
> > This corner case only occurs in 'arch/mips/kernel/traps.c' and
> > we add the '-fno-delayed-branch' option when compiling it.
> > 
> > Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> >
> I rejected this in patchwork. Just making sure you do not use it.

 In any case I think using -mno-jals rather than -fno-delayed-branch would 
be a better workaround, wouldn't it?

  Maciej
