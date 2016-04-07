Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 14:58:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50558 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026210AbcDGM6PJFFvT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Apr 2016 14:58:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u37CwCJu003232;
        Thu, 7 Apr 2016 14:58:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u37CwCik003231;
        Thu, 7 Apr 2016 14:58:12 +0200
Date:   Thu, 7 Apr 2016 14:58:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Apr 7
Message-ID: <20160407125811.GH1668@linux-mips.org>
References: <20160407152922.73d85ce6@canb.auug.org.au>
 <57063E5B.2080206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57063E5B.2080206@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52924
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

On Thu, Apr 07, 2016 at 04:32:51PM +0530, Sudip Mukherjee wrote:

> My patch at : https://lkml.org/lkml/2016/4/4/236 fixes the build for
> defconfig and allmodconfig. I have not checked the patch with other builds.

This is fixed locally; I just haven't pushed a fresh branch, sorry ...

  Ralf
