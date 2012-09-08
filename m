Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2012 21:28:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45557 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903261Ab2IHT21 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Sep 2012 21:28:27 +0200
Date:   Sat, 8 Sep 2012 20:28:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Re: MIPS: Fix build error with modern GCC for non-Cavium.
In-Reply-To: <S1903390Ab2IDU16/20120904202758Z+1425@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.00.1209082024560.8926@eddie.linux-mips.org>
References: <S1903390Ab2IDU16/20120904202758Z+1425@eddie.linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34444
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
X-Status: A

On Tue, 4 Sep 2012, linux-mips@linux-mips.org wrote:

> An empty default block is not allowed so add a ; as empty statement to
> make gcc happy.

 A dummy "break" is the usual solution though.  I don't think GCC ever 
complains if it sees it unreachable after a "return" -- in a sense it is 
just as unreachable as this null instruction is.

  Maciej
