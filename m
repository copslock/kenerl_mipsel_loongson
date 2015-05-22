Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:48:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30271 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006699AbbEVRseKFp05 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:48:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1AB2E2923E710;
        Fri, 22 May 2015 18:48:26 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 18:48:29 +0100
Received: from [10.100.200.196] (10.100.200.196) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 18:48:28 +0100
Message-ID: <555F6B29.8030208@imgtec.com>
Date:   Fri, 22 May 2015 14:45:13 -0300
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
Subject: Re: [PATCH 7/9] clk: pistachio: Add a rate table for the MIPS PLL
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>      <1432252663-31318-8-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaHQjtVBNN8OB3TDLKSD9WszTQ2n+RwhoK-PMhtUAQYYtA@mail.gmail.com>
In-Reply-To: <CAL1qeaHQjtVBNN8OB3TDLKSD9WszTQ2n+RwhoK-PMhtUAQYYtA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.196]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47582
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



On 05/22/2015 02:45 PM, Andrew Bresticker wrote:
> On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
> <ezequiel.garcia@imgtec.com> wrote:
>> This commit adds a rate parameter table, which makes it possible for
>> the MIPS PLL to support rate change.
>>
>> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> ---
>>  drivers/clk/pistachio/clk-pistachio.c | 12 +++++++++++-
>>  drivers/clk/pistachio/clk.h           | 12 ++++++++++++
>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
>> index 22a7ebd..0ac7429 100644
>> --- a/drivers/clk/pistachio/clk-pistachio.c
>> +++ b/drivers/clk/pistachio/clk-pistachio.c
>> @@ -145,8 +145,18 @@ static struct pistachio_mux pistachio_muxes[] __initdata = {
>>         MUX(CLK_BT_PLL_MUX, "bt_pll_mux", mux_xtal_bt, 0x200, 17),
>>  };
>>
>> +static struct pistachio_pll_rate_table mips_pll_rates[] = {
>> +       MIPS_PLL_RATES(52000000, 416000000, 1, 16, 2, 1),
>> +       MIPS_PLL_RATES(52000000, 442000000, 1, 17, 2, 1),
>> +       MIPS_PLL_RATES(52000000, 468000000, 1, 18, 2, 1),
>> +       MIPS_PLL_RATES(52000000, 494000000, 1, 19, 2, 1),
>> +       MIPS_PLL_RATES(52000000, 520000000, 1, 20, 2, 1),
>> +       MIPS_PLL_RATES(52000000, 546000000, 1, 21, 2, 1),
>> +};
>> +
>>  static struct pistachio_pll pistachio_plls[] __initdata = {
>> -       PLL_FIXED(CLK_MIPS_PLL, "mips_pll", "xtal", PLL_GF40LP_LAINT, 0x0),
>> +       PLL(CLK_MIPS_PLL, "mips_pll", "xtal", PLL_GF40LP_LAINT, 0x0,
>> +           mips_pll_rates),
>>         PLL_FIXED(CLK_AUDIO_PLL, "audio_pll", "audio_refclk_mux",
>>                   PLL_GF40LP_FRAC, 0xc),
>>         PLL_FIXED(CLK_RPU_V_PLL, "rpu_v_pll", "xtal", PLL_GF40LP_LAINT, 0x20),
>> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
>> index 3bb6bbe..b5d22d6 100644
>> --- a/drivers/clk/pistachio/clk.h
>> +++ b/drivers/clk/pistachio/clk.h
>> @@ -121,6 +121,18 @@ struct pistachio_pll_rate_table {
>>         unsigned int frac;
>>  };
>>
>> +#define MIPS_PLL_RATES(_fref, _fout, _refdiv, _fbdiv,  \
>> +                      _postdiv1, _postdiv2)            \
>> +{                                                       \
>> +       .fref           = _fref,                        \
>> +       .fout           = _fout,                        \
>> +       .refdiv         = _refdiv,                      \
>> +       .fbdiv          = _fbdiv,                       \
>> +       .postdiv1       = _postdiv1,                    \
>> +       .postdiv2       = _postdiv2,                    \
>> +       .frac           = 0,                            \
>> +}
> 
> Wouldn't this be applicable to any integer PLL, not just MIPS_PLL?
> Also, maybe we should just populate fout_{min,max} here, setting them
> to _fout?  See my comment in patch 3/9.
> 

Yes, you are right. An INT_PLL_RATE would be OK, setting frac to 0 and
fout_{min,max} to fout.

I'll respin.
-- 
Ezequiel
