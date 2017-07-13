Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2017 12:07:33 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:49968 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991073AbdGMKH0KcqMc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2017 12:07:26 +0200
To:     Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 01/18] clk: ingenic: Use const pointer to clk_ops in  struct
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 13 Jul 2017 12:07:25 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: 
In-Reply-To: <20170712232037.GR22780@codeaurora.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170702163016.6714-1-paul@crapouillou.net>
 <20170702163016.6714-2-paul@crapouillou.net>
 <20170712232037.GR22780@codeaurora.org>
Message-ID: <ca4da3fa3067a7301f8fc1539e9e4362@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Le 2017-07-13 01:20, Stephen Boyd a écrit :
> On 07/02, Paul Cercueil wrote:
>> The CGU common code does not modify the pointed clk_ops structure, so 
>> it
>> should be marked as const.
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
> 
> Sorry I forgot, did you want an ack for these clk patches or for
> me to take them through clk tree. If it's the ack case,
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> for patches 1 through 6.

I think ACK; then Ralf can take them in 4.13 :)

Thanks,

-Paul
