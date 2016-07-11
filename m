Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 17:57:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48928 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993238AbcGKP5dp1RRQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jul 2016 17:57:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u6BFvVd5001146;
        Mon, 11 Jul 2016 17:57:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u6BFvU3C001145;
        Mon, 11 Jul 2016 17:57:30 +0200
Date:   Mon, 11 Jul 2016 17:57:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <rcochran@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net,
        linux-mips@linux-mips.org
Subject: Re: [patch 53/66] MIPS: Loongson-3: Convert oprofile to hotplug
 state machine
Message-ID: <20160711155730.GA1024@linux-mips.org>
References: <20160711122450.923603742@linutronix.de>
 <20160711122535.104189590@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160711122535.104189590@linutronix.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Thank, looks ok.  I assume you want to merge this with the remainder of
of the series, so:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
