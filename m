Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 04:31:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46110 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490961Ab0I3Cbd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 04:31:33 +0200
Date:   Thu, 30 Sep 2010 03:31:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: RE: How to setup interrupts for a new board?
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760115A691@CORPEXCH1.na.ads.idt.com>
Message-ID: <alpine.LFD.2.00.1009300306230.21189@eddie.linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com> <4CA36859.2050506@caviumnetworks.com> <AEA634773855ED4CAD999FBB1A66D0760115A691@CORPEXCH1.na.ads.idt.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 23812

Hi Andrei,

> I checked in the MIPS documentation and I couldn't find relevant
> information about this particular way of implementation. Unfortunately
> in the MIPS kernel source there are no enough comments.

 With reasonable understanding what the MIPS architecture features covered 
by these macros, functions, etc. are you should be able to infer from 
Linux code what it actually does.

 May I suggest some reading on the architecture first then?  I realise 
MIPS Technologies' architecture specifications may not be the best way to 
learn how the architecture works, so why not try a MIPS textbook instead, 
such as Dominic Sweetman's excellent "See MIPS Run Linux" (ISBN 
978-0-12-088421-6)?  While not covering such details of Linux as you are 
looking for, it includes related introductory subjects to get you started.  
And of course it covers the MIPS architecture itself.  You may be able to 
find the book at your nearby (or less near) library.

 I think it's about as much as we can help -- you need to get down to 
understanding the details yourself or you'll be bound to asking around 
helplessly all the time.

  Maciej
