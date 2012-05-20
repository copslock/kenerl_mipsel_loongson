Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 23:32:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53363 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903549Ab2ETVcs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2012 23:32:48 +0200
Date:   Sun, 20 May 2012 22:32:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     John Crispin <john@phrozen.org>
cc:     Deng-Cheng Zhu <dczhu@mips.com>, linux-mips@linux-mips.org,
        kevink@paralogos.com
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP)
 functionalities
In-Reply-To: <4FB68FA2.1030404@phrozen.org>
Message-ID: <alpine.LFD.2.00.1205202231400.3701@eddie.linux-mips.org>
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org> <4FB60403.3080700@mips.com> <4FB68FA2.1030404@phrozen.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 18 May 2012, John Crispin wrote:

> >> You could introduce a ARCH_HAS_APRP which any platform can then select ?
> > 
> > Hmm... This is a good idea. Maybe the name could be SYS_SUPPORTS_APRP?
> 
> You are correct

 What's so Malta-specific in the VPE loader anyway?  It's a CPU feature, 
not a board-specific one.

  Maciej
