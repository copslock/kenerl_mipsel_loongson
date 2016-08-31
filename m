Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 13:49:01 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:35722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991977AbcHaLsyu8ThG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 13:48:54 +0200
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=twins.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
        id 1bf40f-0006bH-PM; Wed, 31 Aug 2016 11:48:49 +0000
Received: by twins.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E2EB12573B0D; Wed, 31 Aug 2016 13:48:47 +0200 (CEST)
Date:   Wed, 31 Aug 2016 13:48:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 06/10] MIPS: pm-cps: Use MIPS standard lightweight
 ordering barrier
Message-ID: <20160831114847.GB10153@twins.programming.kicks-ass.net>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
 <1472640279-26593-7-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472640279-26593-7-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54894
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

On Wed, Aug 31, 2016 at 11:44:35AM +0100, Matt Redfearn wrote:
> Since R2 of the MIPS architecture, SYNC(0x10) has been an optional but
> architecturally defined ordering barrier. If a CPU does not implement it,
> the arch specifies that it must fall back to SYNC(0).
> 
> Define the barrier type and always use it in the pm-cps code rather than
> falling back to the heavyweight sync(0) such that we can benefit from
> the lighter weight sync.
> 

Changelog does not explain what 0x10 is, nor why its sufficient for this
case.

Changelog also fails to explain why you do this.

How do you expect anybody to review this?
