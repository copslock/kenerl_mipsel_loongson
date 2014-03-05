Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2014 12:16:24 +0100 (CET)
Received: from merlin.infradead.org ([205.233.59.134]:38165 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823083AbaCELQVq95lO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Mar 2014 12:16:21 +0100
Received: from dhcp-077-248-225-117.chello.nl ([77.248.225.117] helo=twins)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1WL9oA-00051P-AY; Wed, 05 Mar 2014 11:16:18 +0000
Received: by twins (Postfix, from userid 1000)
        id C3A78827883B; Wed,  5 Mar 2014 12:16:15 +0100 (CET)
Date:   Wed, 5 Mar 2014 12:16:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] sched: Removed unused mc_capable() and smt_capable()
Message-ID: <20140305111615.GV9987@twins.programming.kicks-ass.net>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Tue, Mar 04, 2014 at 02:07:31PM -0700, Bjorn Helgaas wrote:
> This is just cleanup of a couple unused interfaces and (for sparc64) a
> supporting variable.
> 

Thanks!
