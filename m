Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 09:06:29 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49741 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491065Ab1G0HGY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 09:06:24 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6R76KZt015865;
        Wed, 27 Jul 2011 08:06:21 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6R76Jr6015862;
        Wed, 27 Jul 2011 08:06:19 +0100
Date:   Wed, 27 Jul 2011 08:06:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2 v2] MIPS: Close races in TLB modify handlers.
Message-ID: <20110727070619.GA15608@linux-mips.org>
References: <1309908886-1624-1-git-send-email-david.daney@cavium.com>
 <1309908886-1624-2-git-send-email-david.daney@cavium.com>
 <20110721135525.GB27341@linux-mips.org>
 <20110722101117.GA21860@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110722101117.GA21860@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19443

On Fri, Jul 22, 2011 at 11:11:17AM +0100, Ralf Baechle wrote:

> > Looks good and nobody else has complained but backporting to <= 2.6.37 is
> > gonna be ugly.  I either have to resolve huge conflicts or alternatively
> > backport tons of other tlbex.c patches.  The latter is less risky and
> > time consuming and will provide additional benefit so I'll do it.  Just
> > be prepared for a storm on the linux-git list.
> 
> It also broke the build for the !defined(CONFIG_MIPS_PGD_C0_CONTEXT) case.

Patch applied but I've decieded not to backport it to < 2.6.34; the
amount of other patches that this fix relies on is just way too big.

On the positive side, those who haven't hit the race in past will probabbly
be able to get away for until they upgrade - and this fix really is a
reason to upgrade.

  Ralf
