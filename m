Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2010 15:09:58 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36665 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491183Ab0KJOJ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Nov 2010 15:09:56 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oAAE9pDj030297;
        Wed, 10 Nov 2010 14:09:53 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oAAE9n7J030286;
        Wed, 10 Nov 2010 14:09:49 GMT
Date:   Wed, 10 Nov 2010 14:09:45 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Separate two consecutive loads in memset.S
Message-ID: <20101110140945.GA29377@linux-mips.org>
References: <20101110134815.GA28312@metis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101110134815.GA28312@metis>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 10, 2010 at 09:48:15PM +0800, Tony Wu wrote:

This new version applies cleanly, so applied.

Only R2000/R3000 class processors are lacking the the load-user interlock
and even some of those got it retrofitted.  With R2000/R3000 being fairly
uncommon these days the impact of this bug should be minor but the last
R3000 DECstation user on this list may be interested ;-)

Thanks a lot!

  Ralf
