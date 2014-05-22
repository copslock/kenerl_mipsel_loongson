Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:16:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56019 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822090AbaEVNQBzEPpC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:16:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDG11Q011369;
        Thu, 22 May 2014 15:16:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDG0kB011368;
        Thu, 22 May 2014 15:16:00 +0200
Date:   Thu, 22 May 2014 15:16:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove CONFIG_PMCTWILED completely
Message-ID: <20140522131600.GA10287@linux-mips.org>
References: <1400585676.4912.38.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400585676.4912.38.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40238
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

On Tue, May 20, 2014 at 01:34:36PM +0200, Paul Bolle wrote:

> Commit 8b284dbc2200 ("MIPS: PNX Removing dead CONFIG_PMCTWILED") missed
> one reference to CONFIG_PMCTWILED in the code. It also missed one
> related reference to pmctwiled_setup(). Remove these references now.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.

Who is testing MSP71xx anyway ...

Anyway, looks good.  Queued for 3.16.

  Ralf
