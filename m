Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 02:20:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53836 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993878AbdAKBUjzgt9x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2017 02:20:39 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0B1KZ3t021150;
        Wed, 11 Jan 2017 02:20:35 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0B1KWOg021149;
        Wed, 11 Jan 2017 02:20:32 +0100
Date:   Wed, 11 Jan 2017 02:20:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
Message-ID: <20170111012032.GE31072@linux-mips.org>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56256
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

On Wed, Jan 11, 2017 at 12:32:38AM +0100, Jason A. Donenfeld wrote:

> Was this ever picked up for 4.10 or 4.11?

Still sitting in -next as commit 3cc3434fd630 and its four parent commits.

  Ralf
