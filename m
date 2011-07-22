Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 12:11:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59045 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491003Ab1GVKLf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 12:11:35 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6MABIEI022055;
        Fri, 22 Jul 2011 11:11:18 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6MABHcB022053;
        Fri, 22 Jul 2011 11:11:17 +0100
Date:   Fri, 22 Jul 2011 11:11:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2 v2] MIPS: Close races in TLB modify handlers.
Message-ID: <20110722101117.GA21860@linux-mips.org>
References: <1309908886-1624-1-git-send-email-david.daney@cavium.com>
 <1309908886-1624-2-git-send-email-david.daney@cavium.com>
 <20110721135525.GB27341@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110721135525.GB27341@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15902

On Thu, Jul 21, 2011 at 02:55:25PM +0100, Ralf Baechle wrote:

> Looks good and nobody else has complained but backporting to <= 2.6.37 is
> gonna be ugly.  I either have to resolve huge conflicts or alternatively
> backport tons of other tlbex.c patches.  The latter is less risky and
> time consuming and will provide additional benefit so I'll do it.  Just
> be prepared for a storm on the linux-git list.

It also broke the build for the !defined(CONFIG_MIPS_PGD_C0_CONTEXT) case.

  Ralf
