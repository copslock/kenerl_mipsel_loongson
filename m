Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 11:38:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37138 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028881AbcEKJirLeY05 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 11:38:47 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4B9ckRD014339;
        Wed, 11 May 2016 11:38:46 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4B9cjwv014338;
        Wed, 11 May 2016 11:38:45 +0200
Date:   Wed, 11 May 2016 11:38:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 04/12] MIPS: Use enums to make asm/pgtable-bits.h readable
Message-ID: <20160511093845.GJ16402@linux-mips.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-5-git-send-email-paul.burton@imgtec.com>
 <20160415202906.GF7859@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160415202906.GF7859@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53357
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

On Fri, Apr 15, 2016 at 09:29:06PM +0100, James Hogan wrote:

> Having had to work my way through some of this file to manually walk
> page tables only this week, I really do think this is an excellent
> cleanup (if nothing else, look at that diffstat :-D ).

I agree.  Lots of history in this file.  It uses #define because well,
i386 was using #define back in the 90's when Elvis was still alive.
Much of the page table code has been rewritten for simplicity, performance
and ease of maintenance but somehow this has escaped so far.

And I'm wondering if eventually the rewrite should be taken even further
making things fully dynamic.

  Ralf
