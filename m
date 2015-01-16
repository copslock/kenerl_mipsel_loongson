Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 09:18:48 +0100 (CET)
Received: from mailgw01.mediatek.com ([210.61.82.183]:48814 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008783AbbAPISqpt9Za (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 09:18:46 +0100
X-Listener-Flag: 11101
Received: from mtkhts07.mediatek.inc [(172.21.101.69)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1009028994; Fri, 16 Jan 2015 16:18:17 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkhts07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 14.3.181.6; Fri, 16 Jan 2015
 16:18:15 +0800
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Xudong Chen <xudong.chen@mediatek.com>,
        Liguo Zhang <Liguo.Zhang@mediatek.com>
In-Reply-To: <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
         <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 16 Jan 2015 16:18:15 +0800
Message-ID: <1421396295.11671.50.camel@mtksdaap41>
MIME-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-MTK:  N
Return-Path: <yingjoe.chen@mediatek.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yingjoe.chen@mediatek.com
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

On Fri, 2015-01-09 at 18:21 +0100, Wolfram Sang wrote:
> The number of I2C adapters which are not fully I2C compatible is rising,
> sadly. Drivers usually do handle the flaws, still the user receives only
> some errno for a transfer which normally can be expected to work. This
> patch introduces a formal description of flaws. One advantage is that
> the core can check before the actual transfer if the messages could be
> transferred at all. This is done in the next patch. Another advantage is
> that we can pass this information to the user so the restrictions are
> exactly known and further actions can be based on that. This will be
> done later after some stabilization period for this description.

Hi Wolfram,

This can describe the behavior of our current upstream driver[1], which
only support combine write-then-read.

After checking with Xudong & HW guys, it seems our HW can do more. 
On MT8135, it can support at most 2 messages, no matter read or write,
with the limitation that the length of the second message must <=
31bytes.

So this RFC is enough for our driver, but it would be better if we could
also support other case.

Joe.C

[1]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305468.html
