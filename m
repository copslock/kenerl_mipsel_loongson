Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 13:30:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51068 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822106AbaEULaT11Hht (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 13:30:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4LBU19p020310;
        Wed, 21 May 2014 13:30:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4LBTbF5020272;
        Wed, 21 May 2014 13:29:37 +0200
Date:   Wed, 21 May 2014 13:29:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yong Zhang <yong.zhang@windriver.com>
Cc:     Yong Zhang <yong.zhang0@gmail.com>, linux-mips@linux-mips.org,
        huawei.libin@huawei.com
Subject: Re: [PATCH] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140521112936.GC17197@linux-mips.org>
References: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
 <20140521053853.GC19655@pek-yzhang-d1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140521053853.GC19655@pek-yzhang-d1>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40212
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

On Wed, May 21, 2014 at 01:38:53PM +0800, Yong Zhang wrote:

> Please check the V2 in which I add the reporter.
> And thanks libin for reporting it :)

The bug was introduced in 5636919b5c909fee54a6ef5226475ecae012ad02
[MIPS: Outline udelay and fix a few issues.] in 2009 btw.  I think
the intension was to avoid holes in the structure and minimize
the bloat.  I instead applied aptch which also moves another member
of the struct arond such that no hole will be created in the struct.
This is important because the strcture it accessed fairly frequently
so we want to fit the most important members into as few cache
lines as possible.

Thanks,

  Ralf
