Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 12:18:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60393 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825074AbaE3KSNPYYYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 12:18:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4UAI7BG020137;
        Fri, 30 May 2014 12:18:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4UAI4cB020136;
        Fri, 30 May 2014 12:18:04 +0200
Date:   Fri, 30 May 2014 12:18:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 02/23] MIPS: Export local_flush_icache_range for KVM
Message-ID: <20140530101804.GH17197@linux-mips.org>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
 <1401355005-20370-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401355005-20370-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40382
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

On Thu, May 29, 2014 at 10:16:24AM +0100, James Hogan wrote:

> Export the local_flush_icache_range function pointer for GPL modules so
> that it can be used by KVM for syncing the icache after binary
> translation of trapping instructions.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
