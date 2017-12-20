Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2017 12:15:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45782 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990425AbdLTLP1hK5xt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Dec 2017 12:15:27 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vBKBFQ1b025922;
        Wed, 20 Dec 2017 12:15:26 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vBKBFQiQ025920;
        Wed, 20 Dec 2017 12:15:26 +0100
Date:   Wed, 20 Dec 2017 12:15:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Schedule on CPUs we need to lose FPU for a mode
 switch
Message-ID: <20171220111525.GF28538@linux-mips.org>
References: <20171219235047.14382-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219235047.14382-1-paul.burton@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61524
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

On Tue, Dec 19, 2017 at 03:50:47PM -0800, Paul Burton wrote:

Looks good but doesn't apply on top of my 4.15-fixes branch which as of
now is at b67336eee3fc ("MIPS: Validate PR_SET_FP_MODE prctl(2) requests
against the ABI of the task").  See [1].

Can you respin?

Thanks,

  Ralf

[1] https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=b67336eee3fcb8ecedc6c13e2bf88aacfa3151e2
