Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:27:14 +0100 (CET)
Received: from ns.mm-sol.com ([37.157.136.199]:44301 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007189AbbCEN1MrHbBf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 14:27:12 +0100
Received: from [192.168.25.131] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 85F6FC8A6;
        Thu,  5 Mar 2015 15:27:07 +0200 (EET)
Message-ID: <1425562025.5705.24.camel@mm-sol.com>
Subject: Re: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
From:   "Ivan T. Ivanov" <iivanov@mm-sol.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Date:   Thu, 05 Mar 2015 15:27:05 +0200
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.13.7-fta1.2~trusty 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <iivanov@mm-sol.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: iivanov@mm-sol.com
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


On Wed, 2015-02-25 at 17:01 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Here is the second version of the patch series to describe i2c adapter quirks
> in a generic way. For the motivation, please read description of patch 1. This
> is still RFC because I would like to do some more tests on my own, but I need
> to write a tool for that. However, I'd really like to have the driver authors
> to have a look already. Actual testing is very much appreciated. Thanks to the
> Mediatek guys for rebasing their new driver to this framework. That helps, too!
> 
> The branch is also here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks
> 
> Thanks,
> 
>    Wolfram
> 
> Major changes since V1:
> 
> * more fine-grained options to describe modes with combined messages.
>   This should also cover the Mediatek HW now as well as all other
>   permutations I can think of.
> 
> * the core code and at91 driver had to be refactored to reflect the
>   above change
> 
> * added the bcm-iproc driver which came to mainline recently
> 
> Wolfram Sang (12):
>   i2c: add quirk structure to describe adapter flaws
>   i2c: add quirk checks to core
>   i2c: at91: make use of the new infrastructure for quirks
>   i2c: opal: make use of the new infrastructure for quirks
>   i2c: qup: make use of the new infrastructure for quirks
> 

For QUP driver. 

Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>
Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Thanks,
Ivan
