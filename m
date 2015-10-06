Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 13:21:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46047 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009646AbbJFLVYLlAYc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Oct 2015 13:21:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t96BLMFm026264;
        Tue, 6 Oct 2015 13:21:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t96BLLpR026263;
        Tue, 6 Oct 2015 13:21:21 +0200
Date:   Tue, 6 Oct 2015 13:21:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH] MIPS: io: Define ioremap_uc
Message-ID: <20151006112121.GA26251@linux-mips.org>
References: <1444089416.2956.2.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444089416.2956.2.camel@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49445
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

On Tue, Oct 06, 2015 at 12:56:56AM +0100, Ben Hutchings wrote:

> All architectures must now define ioremap_uc(), but MIPS currently
> only has ioremap_nocache().
> 
> Fixes: 4c73e8926623 ("arch/*/io.h: Add ioremap_uc() to all architectures")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>

Applied.

Thanks!

  Ralf
