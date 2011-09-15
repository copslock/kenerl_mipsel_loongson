Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 18:01:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34597 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491209Ab1IOQBA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Sep 2011 18:01:00 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8FG0vMX012515;
        Thu, 15 Sep 2011 18:00:57 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8FG0s4f012511;
        Thu, 15 Sep 2011 18:00:54 +0200
Date:   Thu, 15 Sep 2011 18:00:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        linux-mips@linux-mips.org,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110915160054.GA10622@linux-mips.org>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E5C2490.6040203@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7906

On Mon, Aug 29, 2011 at 04:45:20PM -0700, David Daney wrote:

> How about the attached completely untested one instead?

Applied.  I like it more than than Edgar's patch because of the better
scheduling.

I didn't apply Kevin's original patch because a followup to the patch
mentioned there were still problems remaining - but it seems they were
unrelated.

Thanks everybody,

  Ralf
