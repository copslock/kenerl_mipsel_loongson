Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2011 17:58:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47932 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491113Ab1BPQ6j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Feb 2011 17:58:39 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p1GGwPhc032495;
        Wed, 16 Feb 2011 17:58:25 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1GGwNAa032492;
        Wed, 16 Feb 2011 17:58:23 +0100
Date:   Wed, 16 Feb 2011 17:58:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     maksim.rayskiy@gmail.com
Cc:     linux-mips@linux-mips.org, Maksim Rayskiy <mrayskiy@broadcom.com>
Subject: Re: [PATCH v2] MIPS: move idle task creation to work queue
Message-ID: <20110216165823.GA28595@linux-mips.org>
References: <1297534892-29952-1-git-send-email-maksim.rayskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297534892-29952-1-git-send-email-maksim.rayskiy@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 12, 2011 at 10:21:32AM -0800, maksim.rayskiy@gmail.com wrote:

Thanks Maksim, applied.  This solves all the problems at once and is
barely more complex!

  Ralf
