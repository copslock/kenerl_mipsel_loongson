Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 14:36:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34390 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993894AbdDDMgEP4XIi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Apr 2017 14:36:04 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v34Ca2YN030416;
        Tue, 4 Apr 2017 14:36:02 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v34Ca176030415;
        Tue, 4 Apr 2017 14:36:01 +0200
Date:   Tue, 4 Apr 2017 14:36:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MIPS: IRQ Stack: Unwind IRQ stack onto task stack
Message-ID: <20170404123601.GH7681@linux-mips.org>
References: <1490107945-21553-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9p_Yw7Xi2P=zs4snEM3vGo8OkgM8cddpOy69KssNHqsmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p_Yw7Xi2P=zs4snEM3vGo8OkgM8cddpOy69KssNHqsmA@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57558
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

On Tue, Apr 04, 2017 at 01:58:04PM +0200, Jason A. Donenfeld wrote:

> This indeed is useful. Out of curiosity, are other archs using a
> similar technique? In anycase,
> 
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Unfortunately MIPS doesn't have anything like a frame pointer or similar
to make backtracing easy so proper stacktraces have always been more of
rocket science than they really ought to ...

  Ralf
