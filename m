Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 17:29:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34461 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008113AbaLLQ3mDHV4m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Dec 2014 17:29:42 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBCGTeL6016190;
        Fri, 12 Dec 2014 17:29:40 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBCGTePA016189;
        Fri, 12 Dec 2014 17:29:40 +0100
Date:   Fri, 12 Dec 2014 17:29:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: use phys_addr_t instead of phy_t
Message-ID: <20141212162939.GD6477@linux-mips.org>
References: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44633
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

On Sat, Dec 13, 2014 at 12:26:43AM +0900, Jaedon Shin wrote:

> add missing patch of commit "MIPS: Replace use of phys_t with phys_addr_t".

Thanks.  That'a a patch which I was always applying in the merge commit.
Linus should have done the same but unfortunately I forgot to advise him
of this merge issue.

  Ralf
