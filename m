Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2012 17:45:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45379 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903689Ab2CGQoy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2012 17:44:54 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q27Gip9W032729;
        Wed, 7 Mar 2012 17:44:52 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q27Gin89032728;
        Wed, 7 Mar 2012 17:44:49 +0100
Date:   Wed, 7 Mar 2012 17:44:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [ping][PATCH] Handle COP3 Unusable exception as COP1X for FP
 emulation
Message-ID: <20120307164448.GA32101@linux-mips.org>
References: <alpine.DEB.1.10.1203062024030.14492@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1203062024030.14492@tp.orcam.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 06, 2012 at 08:28:54PM +0000, Maciej W. Rozycki wrote:

> Subject: [ping][PATCH] Handle COP3 Unusable exception as COP1X for FP

The list's spam filter ate both this and your your original posting and
thus the patch also didn't make it to patchwork, whoops...  I've modified
the offending test to avoid this from repeating and would like to
encourageusers who experience problems posting to contact me off the
list.

The patch itself looks good and I've applied it.

Thanks!

  Ralf
