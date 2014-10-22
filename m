Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 19:51:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40067 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012159AbaJVRvGpg7SN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 19:51:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MHp5Up014160;
        Wed, 22 Oct 2014 19:51:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MHp4hj014159;
        Wed, 22 Oct 2014 19:51:04 +0200
Date:   Wed, 22 Oct 2014 19:51:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: OCTEON: Remove special case for simulator command
 line.
Message-ID: <20141022175104.GB12502@linux-mips.org>
References: <1413845064-30271-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413845064-30271-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43497
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

On Mon, Oct 20, 2014 at 03:44:24PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> There is no reason to have the kernel to append commands when running
> under the simulator, the simulator is perfectly capable of supplying
> the necessary command line arguments.  Furthermore, if the simulator
> needs something different than what is hard coded in the kernel, it
> cannot get it if the kernel overrides it.
> 
> Fix/Simplify the whole thing by removing this bit.

And various other platforms have the same issue, usually due to the lack
of a mechanism to pass a command line.  I can see why this may be
necessary as a stop gap - but it's still a horrible, horrible solution.

Applied,

  Ralf
