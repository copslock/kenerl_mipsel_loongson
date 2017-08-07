Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 12:09:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46038 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991087AbdHGKJdMdmEn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 12:09:33 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v77A9Vwl025794;
        Mon, 7 Aug 2017 12:09:31 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v77A9VbD025793;
        Mon, 7 Aug 2017 12:09:31 +0200
Date:   Mon, 7 Aug 2017 12:09:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        "# 4 . 3+" <stable@vger.kernel.org>, Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: Re: [PATCH v4 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix
 quiet NaN propagation
Message-ID: <20170807100931.GA25642@linux-mips.org>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1501171791-23690-6-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501171791-23690-6-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59389
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

On Thu, Jul 27, 2017 at 06:08:48PM +0200, Aleksandar Markovic wrote:

This is a mindbogglingly big series of FP fixes.  There's always a risk
associated with fixes so I'd prefer if they could wait for 4.14.  For now
I'm going to apply them to my 4.14 branch but let me know if you think they
are more urgent than that?

  Ralf
