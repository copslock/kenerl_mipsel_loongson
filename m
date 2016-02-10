Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 10:01:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39798 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010852AbcBJJBLbnex6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 10:01:11 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1A919l4010648;
        Wed, 10 Feb 2016 10:01:09 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1A916MK010647;
        Wed, 10 Feb 2016 10:01:06 +0100
Date:   Wed, 10 Feb 2016 10:01:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     weiyj_lk@163.com, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mips@linux-mips.org,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MIPS: pci-mt7620: Fix return value check in
 mt7620_pci_probe()
Message-ID: <20160210090106.GA10352@linux-mips.org>
References: <1454768659-32720-1-git-send-email-weiyj_lk@163.com>
 <56B613D3.2070709@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56B613D3.2070709@openwrt.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51963
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

On Sat, Feb 06, 2016 at 04:40:03PM +0100, John Crispin wrote:

> On 06/02/2016 15:24, weiyj_lk@163.com wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > In case of error, the function devm_ioremap_resource() returns
> > ERR_PTR() and never returns NULL. The NULL test in the return
> > value check should be replaced with IS_ERR().
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Hi,
> 
> thanks for the fix.
> 
> Acked-by: John Crispin <blogic@openwrt.org>
> 
> @Ralf: can you merge this via LMO with the next PR please ?
> 
> @mbgg: ignore the patch please it is for the legacy MIPS SoCs

Applied.  Thanks folks,

  Ralf
