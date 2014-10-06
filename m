Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 14:49:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57948 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009833AbaJFMtRG0-yx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Oct 2014 14:49:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s96CnGF3029941;
        Mon, 6 Oct 2014 14:49:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s96CnF4Q029940;
        Mon, 6 Oct 2014 14:49:15 +0200
Date:   Mon, 6 Oct 2014 14:49:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: Convert pr_warning to pr_warn
Message-ID: <20141006124915.GA29036@linux-mips.org>
References: <1412441442.3247.138.camel@joe-AO725>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412441442.3247.138.camel@joe-AO725>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42962
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

On Sat, Oct 04, 2014 at 09:50:42AM -0700, Joe Perches wrote:

> Use the much more common pr_warn instead of pr_warning
> with the goal of removing pr_warning eventually.

While I agree that only one of pr_warn and pr_warning deserves to live
picking pr_warning introduces another logic inconsistency - for each
pr_<foo> function there is a KERN_<FOO> severity symbol.  And that in
this case is named KERN_WARNING, there's no KERN_WARN.

  Ralf
