Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2011 16:18:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43251 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492105Ab1I1OSW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Sep 2011 16:18:22 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8SEJ4wd006586;
        Wed, 28 Sep 2011 16:19:04 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8SEJ4xf006585;
        Wed, 28 Sep 2011 16:19:04 +0200
Date:   Wed, 28 Sep 2011 16:19:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Kuehling <dvdkhlng@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] add MIPS assembler version of twofish crypto algorithm
Message-ID: <20110928141903.GA6450@linux-mips.org>
References: <87ty9c743i.fsf@snail.Pool>
 <20110928133241.GA30192@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110928133241.GA30192@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Sep 28, 2011 at 03:32:41PM +0200, Ralf Baechle wrote:

Ah, also we unfortunately still support assemblers older than binutils 2.18
but and support for the software names of the registers was introduced
in 2.18, so <asm/mipsregs.h> should be used to get the definitions for the
register names.

Another advantage of doing this is that we get rid of the ugly $ prefix of
register names.

Cheers,

  Ralf
