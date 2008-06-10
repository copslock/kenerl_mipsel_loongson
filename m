Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2008 10:57:06 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:62433 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20034741AbYFJJ5E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jun 2008 10:57:04 +0100
Received: from lagash (88-106-136-149.dynamic.dsl.as9105.com [88.106.136.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id E0E7748916;
	Tue, 10 Jun 2008 11:57:03 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1K60b8-0004JS-Uu; Tue, 10 Jun 2008 10:57:02 +0100
Date:	Tue, 10 Jun 2008 10:57:02 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Brian Foster <brian.foster@innova-card.com>
Cc:	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Andrew Dyer <adyer@righthandtech.com>,
	linux-mips@linux-mips.org
Subject: Re: Adding(?) XI support to MIPS-Linux?
Message-ID: <20080610095702.GG11233@networkno.de>
References: <200806091658.10937.brian.foster@innova-card.com> <484D856B.5030306@paralogos.com> <20080609204627.GE11233@networkno.de> <200806101119.06227.brian.foster@innova-card.com> <a537dd660806100232v4cbf2cfeo397e94ac5a4d2104@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a537dd660806100232v4cbf2cfeo397e94ac5a4d2104@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Brian Foster wrote:
[snip]
>  2) Kevin D. Kissell wrote:
>  2)[ ... ]
>  2) > Well, strictly speaking, you wouldn't actually *need* to modify
>  2) > binutils to make specially tagged binaries.  [ ... ]
>  2)
>  2) This exists already in ld's -z execstack/noexecstack feature.
> 
> Good point.  Thanks for the reminder.
> 
>  2) It is not used by default because too many things depend on executable
>  2) stacks on MIPS.
> 
> Ah!  Can you be more specific please?  At the present time
> I'm only aware of three situations where executable stacks
> are magically used ("magic" meaning it's being done without
> the programmer explicitly coding it):
> 
>   1. sigreturn.
>   2. something to do with FPU emulation?
>   3. pointer to a nested function (gcc extension).

Those, plus manually coded trampolines in e.g. foreign function
interfacing (which are typically hidden in some library). I don't
know if you can ignore that completely. :-)

> And, significantly, I am do not know of any need for the
> kernel-mode stacks to be executable.  Except, perhaps,
> for case 3, the above are (should be?) user-land only.

AFAIK nested functions are frowned upon in kernelspace.


Thiemo
