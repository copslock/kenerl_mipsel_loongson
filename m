Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 12:26:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56244 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990924AbdDJKZtqvBdI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 12:25:49 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3AAPlBP024919;
        Mon, 10 Apr 2017 12:25:47 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3AAPkie024918;
        Mon, 10 Apr 2017 12:25:46 +0200
Date:   Mon, 10 Apr 2017 12:25:46 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rabin Vincent <rabin.vincent@axis.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH] MIPS: perf: fix deadlock
Message-ID: <20170410102546.GB24214@linux-mips.org>
References: <1491398048-20083-1-git-send-email-rabin.vincent@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491398048-20083-1-git-send-email-rabin.vincent@axis.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57624
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

Thanks, applied.

  Ralf
