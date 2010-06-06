Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jun 2010 00:02:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42581 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492262Ab0FFWCf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jun 2010 00:02:35 +0200
Date:   Sun, 6 Jun 2010 23:02:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [Q] MIPS: How to record the user stack backtrace in the kernel
In-Reply-To: <AANLkTikRaw_OLR7LenUA8acaedJy2V6HZKJ0cAd6PNRk@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006062256080.20820@eddie.linux-mips.org>
References: <AANLkTikRaw_OLR7LenUA8acaedJy2V6HZKJ0cAd6PNRk@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4356

On Sat, 5 Jun 2010, Deng-Cheng Zhu wrote:

> In the kernel, we don't have frame unwinder to work on the user stack.
> Given the different possible compiler flags, getting the backtrace for the
> user stack is especially challenging. Certainly, I don't want symbols -
> only to get a list of return addresses. Do you have any comments?

 You can't do that, because, unlike some other platforms, MIPS ABIs do not 
use a fixed frame layout.  You need at least symbol information or, 
preferably, debug records to be able to construct a backtrace.  These can 
be attached to the ELF executables used and are not easily reachable from 
the kernel.

 What's the point anyway?  Just use GDB or other widely available user 
tools.

  Maciej
