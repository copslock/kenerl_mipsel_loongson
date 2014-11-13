Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 13:24:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51616 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013586AbaKMMYIX7xpp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 13:24:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sADCO7qU019952;
        Thu, 13 Nov 2014 13:24:07 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sADCO6Ue019951;
        Thu, 13 Nov 2014 13:24:06 +0100
Date:   Thu, 13 Nov 2014 13:24:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Impact of removing VM_EXEC from brk area
Message-ID: <20141113122406.GA19763@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44115
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

A patch to remove VM_EXEC from VM_DATA_DEFAULT_FLAGS for MIPS has been
submitted to me with the primary motivation for this change being
some performance improvment.  In other words, the patch would remove
execute permission from a process brk area.  It's however unclear to
me how much software wreckage would result from such a change, even
if the execute permission for the stack area remains unchanged.

So, what would break?

Thanks,

  Ralf
