Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 23:57:46 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:41076 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492021Ab0F3V5m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jun 2010 23:57:42 +0200
Received: from localhost (cpc5-brad6-0-0-cust25.barn.cable.virginmedia.com [82.38.64.26])
        by arkanian.console-pimps.org (Postfix) with ESMTPSA id ED6AD48045;
        Wed, 30 Jun 2010 22:57:41 +0100 (BST)
From:   Matt Fleming <matt@console-pimps.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to detect STACKOVEFLOW on mips
In-Reply-To: <20100630145006.GA31938@linux-mips.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com> <20100630145006.GA31938@linux-mips.org>
User-Agent: Notmuch/0.3.1-61-g3f63bb6 (http://notmuchmail.org) Emacs/23.1.90.2 (x86_64-unknown-linux-gnu)
Date:   Wed, 30 Jun 2010 22:57:41 +0100
Message-ID: <87zkycyyi2.fsf@linux-g6p1.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 27290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20620

On Wed, 30 Jun 2010 15:50:06 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> There used to be some code for other architectures that zeros the stack
> page and counts how much of that has been overwritten by the stack.  That
> was never ported to MIPS.
> 
> Another helper to find functions that do excessive static allocations is
> "make checkstack".

Both SH and sparc use the mcount function (enabled with the -pg switch
to gcc) to check the stack has not overflowed. The relevant code is in
arch/{sh,sparc}/lib/mcount.S. This checks the stack pointer value on
every function call. Yeah, it's heavy-weight, but an implementation for
MIPS should be able to catch almost the exact point at which stack
overflow occurs.
