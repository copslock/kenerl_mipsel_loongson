Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 15:50:55 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:56882 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993922AbdFZNurouftP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 15:50:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 26 Jun 2017 15:50:11 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: Add Ingenic jz4770 CGU driver
In-Reply-To: <20170607205943.GO20170@codeaurora.org>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-5-paul@crapouillou.net>
 <20170607205943.GO20170@codeaurora.org>
Message-ID: <639b492cc57200bab14572ac591ef8af@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58807
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

Le 2017-06-07 22:59, Stephen Boyd a écrit :
> On 06/07, Paul Cercueil wrote:
>> Add support for the clocks provided by the CGU in the Ingenic JZ4770
>> SoC.
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>

[...]

>> diff --git a/include/dt-bindings/clock/jz4770-cgu.h 
>> b/include/dt-bindings/clock/jz4770-cgu.h
>> new file mode 100644
>> index 000000000000..54b8b2ae4a73
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/jz4770-cgu.h
> 
> Can you split this file off into a different patch? That way clk
> tree can apply clk patches on top of a stable branch where this
> file lives by itself.

Oops, I forgot that in the v2.

The jz4770-cgu.c file includes and uses 
<dt-bindings/clock/jz4770-cgu.h>, so I don't think
it would make sense to split it, since it wouldn't compile without it.
