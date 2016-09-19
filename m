Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 17:10:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35936 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992544AbcISPKk1f0R6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Sep 2016 17:10:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8JFAd9B017427;
        Mon, 19 Sep 2016 17:10:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8JFAd8G017426;
        Mon, 19 Sep 2016 17:10:39 +0200
Date:   Mon, 19 Sep 2016 17:10:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, rt@linutronix.de,
        tglx@linutronix.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 16/21] mips: loongson: smp: Convert to hotplug state
 machine
Message-ID: <20160919151039.GD14137@linux-mips.org>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-17-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160906170457.32393-17-bigeasy@linutronix.de>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55171
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

On Tue, Sep 06, 2016 at 07:04:52PM +0200, Sebastian Andrzej Siewior wrote:

> Install the callbacks via the state machine.

Same here, I assume you want to upstream this as a single pull request, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
