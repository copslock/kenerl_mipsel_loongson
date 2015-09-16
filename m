Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 04:32:21 +0200 (CEST)
Received: from one.firstfloor.org ([193.170.194.197]:60841 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006546AbbIPCcTzA1W1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 04:32:19 +0200
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 605CA86E3D; Wed, 16 Sep 2015 04:32:19 +0200 (CEST)
Date:   Wed, 16 Sep 2015 04:32:19 +0200
From:   Andi Kleen <andi@firstfloor.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/3] Add __ioread32_copy() and use it
Message-ID: <20150916023219.GD1747@two.firstfloor.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andi@firstfloor.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@firstfloor.org
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

> __iowrite32_copy() is marked __visible.  I don't actually know what
> that does and Andi's d47d5c8194579bc changelog (which sucks the big
> one) didn't explain it.  Apparently it has something to do with being
> implemented in assembly, but zillions of functions are implemented in
> assembly, so why are only two functions marked this way?  Anyway,
> __ioread32_copy() is implemented in C so I guess __visible isn't needed
> there.

__visible is needed for C functions that are called from assembler.
Otherwise the compiler may optimize them away.

-Andi
