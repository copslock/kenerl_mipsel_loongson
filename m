Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 11:45:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44300 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993944AbdFMJpaPuQfv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Jun 2017 11:45:30 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5D9jR3L009751;
        Tue, 13 Jun 2017 11:45:27 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5D9jPbI009750;
        Tue, 13 Jun 2017 11:45:25 +0200
Date:   Tue, 13 Jun 2017 11:45:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V4 4/9] MIPS: Loongson-3: Support 4 packages in CPU Hwmon
 driver
Message-ID: <20170613094525.GB31492@linux-mips.org>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
 <1496718888-18324-4-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496718888-18324-4-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58420
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

On Tue, Jun 06, 2017 at 11:14:43AM +0800, Huacai Chen wrote:

(Fixing the Steven.Hill@imgtec.com address on cc, this email address is
stale since a long time.  Steven is now Steven.Hill@cavium.com.

> Loongson-3 machines may have as many as 4 physical packages.

Any reason why not dynamically allocating all structures, static allocations
just won't scale to many packages nor are they very maintenance friendly.

  Ralf
