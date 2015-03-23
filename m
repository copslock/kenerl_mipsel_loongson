Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 23:08:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42594 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009701AbbCWWIKCYyiG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Mar 2015 23:08:10 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2NM88CW019639;
        Mon, 23 Mar 2015 23:08:08 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2NM87pa019638;
        Mon, 23 Mar 2015 23:08:07 +0100
Date:   Mon, 23 Mar 2015 23:08:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: next-20150323 build: 1 failures 23 warnings (next-20150323)
Message-ID: <20150323220806.GB8891@linux-mips.org>
References: <E1YZyoN-00019n-50@debutante>
 <20150323212524.GU14954@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150323212524.GU14954@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46503
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

On Mon, Mar 23, 2015 at 02:25:24PM -0700, Mark Brown wrote:

> On Mon, Mar 23, 2015 at 09:38:19AM +0000, Build bot for Mark Brown wrote:
> 
> In current -next the bgmac driver does not compile in an ARM
> allmodconfig:
> 
> > 	arm-allmodconfig
> > ../drivers/net/ethernet/broadcom/bgmac.c:20:27: fatal error: bcm47xx_nvram.h: No such file or directory
> 
> because this include file is only present on MIPS.  This looks at first
> glance to have happened in the merge commit edb15d83a875a1f4 from the
> MIPS tree though I think that needs a bit more investigation.

At that time the bgmac NIC was still exclusivly used on MIPS.

  Ralf
