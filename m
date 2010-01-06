Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2010 13:48:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49250 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492356Ab0AFMsp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2010 13:48:45 +0100
Date:   Wed, 6 Jan 2010 12:48:45 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     loody <miloody@gmail.com>
cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about Extended Asm
In-Reply-To: <3a665c761001052313v36bfeb89v37ada6b76e91c271@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1001061244330.13474@eddie.linux-mips.org>
References: <3a665c761001052313v36bfeb89v37ada6b76e91c271@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 25520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4017

On Wed, 6 Jan 2010, loody wrote:

> I try to
>   "or %0, count\n", where count is $a1.
> so I write %1 as count and write
>   "or %0, %1\n" and assign %1 as count in input section.
> 
> But the result is not what I expect.
> the result is "   or      v1,v1,v0"
> Did I miss something or the only way to meet what I need is directly write
>  "or %0, $a1\n"?

 As you can figure out from the semantics:

	or	v1, v0

is a shorthand for:

	or	v1, v1, v0

There is no two-argument register OR instruction in the standard MIPS 
instruction set (nor there is a need for one).

  Maciej
