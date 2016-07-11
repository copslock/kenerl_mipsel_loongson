Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 18:02:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49266 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993238AbcGKQBwxSvxQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jul 2016 18:01:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u6BG1pHI001278;
        Mon, 11 Jul 2016 18:01:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u6BG1o55001277;
        Mon, 11 Jul 2016 18:01:50 +0200
Date:   Mon, 11 Jul 2016 18:01:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: OCTEON: Changes to support readq()/writeq() usage.
Message-ID: <20160711160150.GB1024@linux-mips.org>
References: <5780652D.2030604@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5780652D.2030604@cavium.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54282
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

On Fri, Jul 08, 2016 at 09:45:01PM -0500, Steven J. Hill wrote:

> Update OCTEON port mangling code to support readq() and
> writeq() functions to allow driver code to be more portable.
> Updates also for word and long function pairs. We also
> remove SWAP_IO_SPACE for OCTEON platforms as the function
> macros are redundant with the new mangling code.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Thanks, applied.

  Ralf
