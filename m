Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 20:17:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34011 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491092Ab1AXTRh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 20:17:37 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0OJHAWc007514;
        Mon, 24 Jan 2011 20:17:10 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0OJH9PZ007512;
        Mon, 24 Jan 2011 20:17:09 +0100
Date:   Mon, 24 Jan 2011 20:17:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stefan Oberhumer <stefan@obssys.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: Clear the correct flag in sysmips(MIPS_FIXADE, ...).
Message-ID: <20110124191709.GA7237@linux-mips.org>
References: <4D33FBA9.9080503@obssys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D33FBA9.9080503@obssys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 09:19:53AM +0100, Stefan Oberhumer wrote:

> The sysmips(MIPS_FIXADE, ...) case contains an obvious copy-and-paste
> error in the handling of the TIF_LOGADE flag. Fix that

Applied - but <rant> please include a Signed-off-by line for all patches
you submit. </rant>

Thanks,

  Ralf
