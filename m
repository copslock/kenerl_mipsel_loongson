Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 00:42:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52574 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903239Ab2IOWmX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 00:42:23 +0200
Date:   Sat, 15 Sep 2012 23:42:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: Fix build error with modern GCC for non-Cavium.
In-Reply-To: <20120910171157.GC24448@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1209152336430.8926@eddie.linux-mips.org>
References: <S1903390Ab2IDU16/20120904202758Z+1425@eddie.linux-mips.org> <alpine.LFD.2.00.1209082024560.8926@eddie.linux-mips.org> <20120910171157.GC24448@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34514
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 10 Sep 2012, Ralf Baechle wrote:

> >  A dummy "break" is the usual solution though.  I don't think GCC ever 
> > complains if it sees it unreachable after a "return" -- in a sense it is 
> > just as unreachable as this null instruction is.
> 
> I wasn't overly picky.  Whatever gets the stuff to build correctly.  I'm
> doing one final round of test builds over all -stable branches before
> dropping most of them like radioctive rocks.  But more on that later.

 Yeah, sure -- I just noted this is not breaking a new ground really.  
There was a time GCC used to support genuinely empty switch cases and that 
was removed at one point for better ISO C compliance.  There was a rush 
fixing code all over the place at that point, including some "proper" GNU 
software such as I reckon bison, and the common approach taken was that I 
referred to.

  Maciej
