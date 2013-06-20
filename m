Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 16:26:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55906 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823009Ab3FTO0aBp0FC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 16:26:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5KEQRNK030320;
        Thu, 20 Jun 2013 16:26:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5KEQPaj030319;
        Thu, 20 Jun 2013 16:26:25 +0200
Date:   Thu, 20 Jun 2013 16:26:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix OCTEON BUG() warnings a different way.
Message-ID: <20130620142625.GA30061@linux-mips.org>
References: <1371679468-29479-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371679468-29479-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37058
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

On Wed, Jun 19, 2013 at 03:04:28PM -0700, David Daney wrote:

> Signed-off-by: David Daney <david.daney@cavium.com>

I replaced my fix with your fix but left he direct inclusion of
<linux/bug.h>.

Let as homework for a later point: make BUG() invoke unreachable() if
CONFIG_BUG is diabled, something like that.  This will improve code
generation for GCC 4.5+ but for older compilers unreachable() is
defined as do { } while (1) so will emit extra code.

Thanks,

  Ralf
