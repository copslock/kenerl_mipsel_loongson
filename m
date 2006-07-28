Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 20:32:27 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:42654 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8134060AbWG1Tb6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 20:31:58 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 85EDC44841; Fri, 28 Jul 2006 21:31:57 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G6Y3T-0007iN-F0; Fri, 28 Jul 2006 20:31:27 +0100
Date:	Fri, 28 Jul 2006 20:31:27 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	David Daney <ddaney@avtrex.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
Message-ID: <20060728193127.GA25426@networkno.de>
References: <20060727170305.GB4505@networkno.de> <cda58cb80607271151n2dcfe64cn4cb1ecca3ece6b1e@mail.gmail.com> <20060727191245.GD4505@networkno.de> <20060728.233842.41629448.anemo@mba.ocn.ne.jp> <44CA43EC.9010904@avtrex.com> <44CA4AA3.8080700@mips.com> <44CA5837.2060502@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CA5837.2060502@avtrex.com>
User-Agent: Mutt/1.5.12-2006-07-14
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Nigel Stephens wrote:
> >
> >
> >David Daney wrote:
> >
> >>Atsushi Nemoto wrote:
> >>
> >>>On Thu, 27 Jul 2006 20:12:45 +0100, Thiemo Seufer <ths@networkno.de> 
> >>>wrote:
> >>>
> >>>>IOW, binary analysis can't be expected to provide full accuracy, but
> >>>>we can live with a reasonable approximation, I think.
> >>>
> >>>
> >>>
> >>>Yes, this is a starting point.
> >>>
> >>>The patch (and current mips get_wchan() implementation) tries to do is
> >>>what I used to do to analyze stack dump by hand.
> >>>
> >>>1. Determine PC and SP.
> >>>2. Disassemble a function containing the PC address.
> >>>3. If the function is leaf, make use RA for new PC.
> >>
> >>
> >>This was always the tricky part for me.  How do you know if the 
> >>function is a leaf?
> >>
> >
> >I think that if you cannot find a store instruction which saves RA to 
> >the stack -- either because it's a real leaf and there is no such store, 
> >or because the PC hasn't yet reached the store instruction -- then in 
> >both cases it can be treated as a leaf.
> 
> Presumably you are walking the code back from the PC until you find the 
> prolog.  How would you tell if you had gone past the beginning of a leaf 
> function?  If you find a j $31 you might assume that it was the end of 
> the previous function.
> 
> But that does not work if you are in a function that has multiple return 
> points.  On encountering a j $31 you have no way of telling if you are 
> in a leaf function or a non-leaf function with multiple return points.

... or in a fragment of a single return function which was moved out
of the hot path, after the return point.


Thiemo
