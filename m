Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 15:34:50 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:54970 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993955AbdFZNenlGDDP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 15:34:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 26 Jun 2017 15:34:38 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 01/17] clk: ingenic: Use const pointer to clk_ops in
 struct
In-Reply-To: <20170621215038.GG4493@codeaurora.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170620151855.19399-1-paul@crapouillou.net>
 <20170621215038.GG4493@codeaurora.org>
Message-ID: <580231557b0447d9019a20ac99292938@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58806
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

Hi,

Le 2017-06-21 23:50, Stephen Boyd a écrit :
> On 06/20, Paul Cercueil wrote:
>> The CGU common code does not modify the pointed clk_ops structure, so 
>> it
>> should be marked as const.
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
> 
> How did you want to merge this series? I can ack clk patches if
> you like, or apply the clk patches to the clk tree.

The clk patches refer to CONFIG_MACH_JZ4770 in the Kconfig, so they 
indirectly depend on the other patches. I think it's better that you ack 
them then.
