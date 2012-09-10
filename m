Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 19:12:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38817 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903468Ab2IJRL6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Sep 2012 19:11:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8AHBvYg014081;
        Mon, 10 Sep 2012 19:11:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8AHBvfM014080;
        Mon, 10 Sep 2012 19:11:57 +0200
Date:   Mon, 10 Sep 2012 19:11:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: Fix build error with modern GCC for non-Cavium.
Message-ID: <20120910171157.GC24448@linux-mips.org>
References: <S1903390Ab2IDU16/20120904202758Z+1425@eddie.linux-mips.org>
 <alpine.LFD.2.00.1209082024560.8926@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1209082024560.8926@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34453
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Sep 08, 2012 at 08:28:26PM +0100, Maciej W. Rozycki wrote:

> > An empty default block is not allowed so add a ; as empty statement to
> > make gcc happy.
> 
>  A dummy "break" is the usual solution though.  I don't think GCC ever 
> complains if it sees it unreachable after a "return" -- in a sense it is 
> just as unreachable as this null instruction is.

I wasn't overly picky.  Whatever gets the stuff to build correctly.  I'm
doing one final round of test builds over all -stable branches before
dropping most of them like radioctive rocks.  But more on that later.

  Ralf
