Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:56:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37670 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006684AbbEVR4BAKH2A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:56:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6B4DCE0AAFE2B;
        Fri, 22 May 2015 18:55:53 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 18:55:56 +0100
Received: from [10.100.200.196] (10.100.200.196) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 18:55:55 +0100
Message-ID: <555F6CE8.1070303@imgtec.com>
Date:   Fri, 22 May 2015 14:52:40 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 6/9] clk: pistachio: Propagate rate changes in the MIPS
 PLL clock sub-tree
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>      <1432252663-31318-7-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaEKeNXWWgcu=sX_Ly=6mSsNm4i6OuN0561=_z55MaE6DA@mail.gmail.com>
In-Reply-To: <CAL1qeaEKeNXWWgcu=sX_Ly=6mSsNm4i6OuN0561=_z55MaE6DA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.196]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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



On 05/22/2015 02:42 PM, Andrew Bresticker wrote:
> On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
> <ezequiel.garcia@imgtec.com> wrote:
>> This commit passes CLK_SET_RATE_PARENT to the "mips_div",
>> "mips_internal_div", and "mips_pll_mux" clocks. This flag is needed for the
>> "mips" clock to propagate rate changes up to the "mips_pll" root clock.
>>
>> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> 
> IIRC the clk core will prefer changing a downstream divider over
> propagating the rate change up another level.  So, for example, if
> MIPS_PLL is initially 400Mhz and we request a MIPS rate of 200Mhz,
> we'll change the first intermediate divider to /2 rather than
> propagate the rate change up to MIPS_PLL.  Wouldn't it be more
> power-efficient to set the MIPS_PLL directly to the requested rate
> rather than using external dividers to divide it down?
> 

Indeed.

Do you think we still want to be able to change the MIPS clk rate and
propagate the change up to the PLL? Otherwise, I'll drop this patch and
I'll drop the DIV_F and MUX_F macro patches.

-- 
Ezequiel
