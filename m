Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 18:07:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47671 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1AXRHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 18:07:06 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0OH6btT004354;
        Mon, 24 Jan 2011 18:06:37 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0OH6ZJC004351;
        Mon, 24 Jan 2011 18:06:35 +0100
Date:   Mon, 24 Jan 2011 18:06:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add an unreachable return statement to satisfy
 buggy GCCs.
Message-ID: <20110124170635.GA4214@linux-mips.org>
References: <1295479482-28769-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295479482-28769-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

> It was reported that GCC-4.3.3 (with CodeSourcery extensions) fails
> without this.

This gcc missfeature has annoyed me often enough.  Applied.

Thanks,

  Ralf
