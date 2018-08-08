Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 10:52:35 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:33923 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994723AbeHHIwaS7LaM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 10:52:30 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 01:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="79912435"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.39]) ([10.226.38.39])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2018 01:52:22 -0700
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
To:     Stephen Boyd <sboyd@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com,
        qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
Date:   Wed, 8 Aug 2018 16:52:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <yixin.zhu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yixin.zhu@linux.intel.com
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



On 8/8/2018 1:50 PM, Stephen Boyd wrote:
> Quoting Songjun Wu (2018-08-02 20:02:21)
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> This driver provides PLL clock registration as well as various clock
>> branches, e.g. MUX clock, gate clock, divider clock and so on.
>>
>> PLLs that provide clock to DDR, CPU and peripherals are shown below:
>>
>>                   +---------+
>>              |--->| LCPLL3 0|--PCIe clk-->
>>     XO       |    +---------+
>> +-----------|
>>              |    +---------+
>>              |    |        3|--PAE clk-->
>>              |--->| PLL0B  2|--GSWIP clk-->
>>              |    |        1|--DDR clk-->DDR PHY clk-->
>>              |    |        0|--CPU1 clk--+   +-----+
>>              |    +---------+            |--->0    |
>>              |                               | MUX |--CPU clk-->
>>              |    +---------+            |--->1    |
>>              |    |        0|--CPU0 clk--+   +-----+
>>              |--->| PLLOA  1|--SSX4 clk-->
>>                   |        2|--NGI clk-->
>>                   |        3|--CBM clk-->
>>                   +---------+
> Thanks for the picture!
Thanks for the review.

>
>> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index 0bb25dd009d1..d929ca4607cf 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -72,6 +72,9 @@ obj-$(CONFIG_ARCH_HISI)                       += hisilicon/
>>   obj-y                                  += imgtec/
>>   obj-$(CONFIG_ARCH_MXC)                 += imx/
>>   obj-$(CONFIG_MACH_INGENIC)             += ingenic/
>> +ifeq ($(CONFIG_COMMON_CLK), y)
>> +obj-y                                                  +=intel/
>> +endif
> Why not obj-$(CONFIG_INTEL_CCF) or something like that?
Will use obj-$(CONFIG_INTEL_CCF)

>>   obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
>>   obj-$(CONFIG_MACH_LOONGSON32)          += loongson1/
>>   obj-y                                  += mediatek/
>> diff --git a/drivers/clk/intel/Kconfig b/drivers/clk/intel/Kconfig
>> new file mode 100644
>> index 000000000000..c7d3fb1721fa
>> --- /dev/null
>> +++ b/drivers/clk/intel/Kconfig
>> @@ -0,0 +1,20 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config INTEL_CGU_CLK
>> +       depends on COMMON_CLK
>> +       depends on INTEL_MIPS || COMPILE_TEST
>> +       select MFD_SYSCON
>> +       bool "Intel clock controller support"
>> +       help
>> +         This driver support Intel CGU (Clock Generation Unit).
> Is it really called a clock generation unit? Or that's just copied from
> sunxi driver?
Yes,  It's called clock generation unit(CGU) in our HW chip spec.

>> +
>> +choice
>> +       prompt "SoC platform selection"
>> +       depends on INTEL_CGU_CLK
>> +       default INTEL_GRX500_CGU_CLK
>> +
>> +config INTEL_GRX500_CGU_CLK
>> +       bool "GRX500 CLK"
>> +       help
>> +         Clock driver of GRX500 platform.
>> +
>> +endchoice
>> diff --git a/drivers/clk/intel/Makefile b/drivers/clk/intel/Makefile
>> new file mode 100644
>> index 000000000000..16a0138e52c2
>> --- /dev/null
>> +++ b/drivers/clk/intel/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Makefile for intel specific clk
>> +
>> +obj-$(CONFIG_INTEL_CGU_CLK) += clk-cgu.o clk-cgu-pll.o
>> +ifneq ($(CONFIG_INTEL_GRX500_CGU_CLK),)
>> +       obj-y += clk-grx500.o
>> +endif
>> diff --git a/drivers/clk/intel/clk-cgu-pll.c b/drivers/clk/intel/clk-cgu-pll.c
>> new file mode 100644
>> index 000000000000..20759bc27e95
>> --- /dev/null
>> +++ b/drivers/clk/intel/clk-cgu-pll.c
>> @@ -0,0 +1,166 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2018 Intel Corporation.
>> + *  Zhu YiXin <Yixin.zhu@intel.com>
>> + */
>> +
>> +#include <linux/clk.h>
> Is this include used?
Not used. Will remove it.

>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk-cgu-pll.h"
>> +#include "clk-cgu.h"
>> +
>> +#define to_intel_clk_pll(_hw)  container_of(_hw, struct intel_clk_pll, hw)
>> +
>> +/*
>> + * Calculate formula:
>> + * rate = (prate * mult + (prate * frac) / frac_div) / div
>> + */
>> +static unsigned long
>> +intel_pll_calc_rate(unsigned long prate, unsigned int mult,
>> +                   unsigned int div, unsigned int frac,
>> +                   unsigned int frac_div)
>> +{
>> +       u64 crate, frate, rate64;
>> +
>> +       rate64 = prate;
>> +       crate = rate64 * mult;
>> +
>> +       if (frac) {
>> +               frate = rate64 * frac;
>> +               do_div(frate, frac_div);
>> +               crate += frate;
>> +       }
>> +       do_div(crate, div);
>> +
>> +       return (unsigned long)crate;
>> +}
>> +
>> +static void
>> +grx500_pll_get_params(struct intel_clk_pll *pll, unsigned int *mult,
>> +                     unsigned int *frac)
>> +{
>> +       *mult = intel_get_clk_val(pll->map, pll->reg, 2, 7);
>> +       *frac = intel_get_clk_val(pll->map, pll->reg, 9, 21);
>> +}
>> +
>> +static int intel_wait_pll_lock(struct intel_clk_pll *pll, int bit_idx)
>> +{
>> +       unsigned int val;
>> +
>> +       return regmap_read_poll_timeout(pll->map, pll->reg, val,
>> +                                       val & BIT(bit_idx), 10, 1000);
>> +}
>> +
>> +static unsigned long
>> +intel_grx500_pll_recalc_rate(struct clk_hw *hw, unsigned long prate)
>> +{
>> +       struct intel_clk_pll *pll = to_intel_clk_pll(hw);
>> +       unsigned int mult, frac;
>> +
>> +       grx500_pll_get_params(pll, &mult, &frac);
>> +
>> +       return intel_pll_calc_rate(prate, mult, 1, frac, BIT(20));
>> +}
>> +
>> +static int intel_grx500_pll_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct intel_clk_pll *pll = to_intel_clk_pll(hw);
>> +
>> +       if (intel_wait_pll_lock(pll, 1)) {
>> +               pr_err("%s: pll: %s is not locked!\n",
>> +                      __func__, clk_hw_get_name(hw));
>> +               return 0;
>> +       }
>> +
>> +       return intel_get_clk_val(pll->map, pll->reg, 1, 1);
>> +}
>> +
>> +const static struct clk_ops intel_grx500_pll_ops = {
> Should be static const struct ...
Will update it.

>> +       .recalc_rate = intel_grx500_pll_recalc_rate,
>> +       .is_enabled = intel_grx500_pll_is_enabled,
>> +};
>> +
>> +static struct clk
>> +*intel_clk_register_pll(struct intel_clk_provider *ctx,
>> +                       enum intel_pll_type type, const char *cname,
>> +                       const char *const *pname, u8 num_parents,
>> +                       unsigned long flags, unsigned int reg,
>> +                       const struct intel_pll_rate_table *table,
>> +                       unsigned int mult, unsigned int div, unsigned int frac)
>> +{
>> +       struct clk_init_data init;
>> +       struct intel_clk_pll *pll;
>> +       struct clk_hw *hw;
>> +       int ret, i;
>> +
>> +       if (type != pll_grx500) {
>> +               pr_err("%s: pll type %d not supported!\n",
>> +                      __func__, type);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +       init.name = cname;
>> +       init.ops = &intel_grx500_pll_ops;
>> +       init.flags = CLK_IS_BASIC;
> Don't use this flag unless you have some reason to need it.
Will remove it.

>> +       init.parent_names = pname;
>> +       init.num_parents = num_parents;
>> +
>> +       pll = kzalloc(sizeof(*pll), GFP_KERNEL);
>> +       if (!pll)
>> +               return ERR_PTR(-ENOMEM);
>> +       pll->map = ctx->map;
>> +       pll->reg = reg;
>> +       pll->flags = flags;
>> +       pll->mult = mult;
>> +       pll->div = div;
>> +       pll->frac = frac;
>> +       pll->hw.init = &init;
>> +       if (table) {
>> +               for (i = 0; table[i].rate != 0; i++)
>> +                       ;
>> +               pll->table_sz = i;
>> +               pll->rate_table = kmemdup(table, i * sizeof(table[0]),
>> +                                         GFP_KERNEL);
>> +               if (!pll->rate_table) {
>> +                       ret = -ENOMEM;
>> +                       goto err_free_pll;
>> +               }
>> +       }
>> +       hw = &pll->hw;
>> +       ret = clk_hw_register(NULL, hw);
>> +       if (ret)
>> +               goto err_free_pll;
>> +
>> +       return hw->clk;
>> +
>> +err_free_pll:
>> +       kfree(pll);
>> +       return ERR_PTR(ret);
>> +}
>> +
>> +void intel_clk_register_plls(struct intel_clk_provider *ctx,
>> +                            struct intel_pll_clk *list, unsigned int nr_clk)
>> +{
>> +       struct clk *clk;
>> +       int i;
>> +
>> +       for (i = 0; i < nr_clk; i++, list++) {
>> +               clk = intel_clk_register_pll(ctx, list->type, list->name,
>> +                               list->parent_names, list->num_parents,
>> +                               list->flags, list->reg, list->rate_table,
>> +                               list->mult, list->div, list->frac);
>> +               if (IS_ERR(clk)) {
>> +                       pr_err("%s: failed to register pll: %s\n",
>> +                              __func__, list->name);
>> +                       continue;
>> +               }
>> +
>> +               intel_clk_add_lookup(ctx, clk, list->id);
>> +       }
>> +}
>> diff --git a/drivers/clk/intel/clk-cgu-pll.h b/drivers/clk/intel/clk-cgu-pll.h
>> new file mode 100644
>> index 000000000000..3e7cff1d5e16
>> --- /dev/null
>> +++ b/drivers/clk/intel/clk-cgu-pll.h
>> @@ -0,0 +1,34 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Copyright(c) 2018 Intel Corporation.
>> + *  Zhu YiXin <Yixin.zhu@intel.com>
>> + */
>> +
>> +#ifndef __INTEL_CLK_PLL_H
>> +#define __INTEL_CLK_PLL_H
>> +
>> +enum intel_pll_type {
>> +       pll_grx500,
>> +};
>> +
>> +struct intel_pll_rate_table {
>> +       unsigned long   prate;
>> +       unsigned long   rate;
>> +       unsigned int    mult;
>> +       unsigned int    div;
>> +       unsigned int    frac;
>> +};
>> +
>> +struct intel_clk_pll {
>> +       struct clk_hw   hw;
>> +       struct regmap   *map;
>> +       unsigned int    reg;
>> +       unsigned long   flags;
>> +       unsigned int    mult;
>> +       unsigned int    div;
>> +       unsigned int    frac;
>> +       unsigned int    table_sz;
>> +       const struct intel_pll_rate_table *rate_table;
>> +};
>> +
>> +#endif /* __INTEL_CLK_PLL_H */
>> diff --git a/drivers/clk/intel/clk-cgu.c b/drivers/clk/intel/clk-cgu.c
>> new file mode 100644
>> index 000000000000..10cacbe0fbcd
>> --- /dev/null
>> +++ b/drivers/clk/intel/clk-cgu.c
>> @@ -0,0 +1,470 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2018 Intel Corporation.
>> + *  Zhu YiXin <Yixin.zhu@intel.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk-cgu-pll.h"
>> +#include "clk-cgu.h"
>> +
>> +#define GATE_HW_REG_STAT(reg)  (reg)
>> +#define GATE_HW_REG_EN(reg)    ((reg) + 0x4)
>> +#define GATE_HW_REG_DIS(reg)   ((reg) + 0x8)
>> +
>> +#define to_intel_clk_mux(_hw) container_of(_hw, struct intel_clk_mux, hw)
>> +#define to_intel_clk_divider(_hw) \
>> +               container_of(_hw, struct intel_clk_divider, hw)
>> +#define to_intel_clk_gate(_hw) container_of(_hw, struct intel_clk_gate, hw)
>> +
>> +void intel_set_clk_val(struct regmap *map, u32 reg, u8 shift,
>> +                      u8 width, u32 set_val)
>> +{
>> +       u32 mask = GENMASK(width + shift, shift);
>> +
>> +       regmap_update_bits(map, reg, mask, set_val << shift);
>> +}
>> +
>> +u32 intel_get_clk_val(struct regmap *map, u32 reg, u8 shift,
>> +                     u8 width)
>> +{
>> +       u32 val;
>> +
>> +       if (regmap_read(map, reg, &val)) {
>> +               WARN_ONCE(1, "Failed to read clk reg: 0x%x\n", reg);
>> +               return 0;
>> +       }
>> +       val >>= shift;
>> +       val &= BIT(width) - 1;
>> +
>> +       return val;
>> +}
>> +
>> +void intel_clk_add_lookup(struct intel_clk_provider *ctx,
>> +                         struct clk *clk, unsigned int id)
>> +{
>> +       pr_debug("Add clk: %s, id: %u\n", __clk_get_name(clk), id);
>> +       if (ctx->clk_data.clks && id)
>> +               ctx->clk_data.clks[id] = clk;
>> +}
>> +
>> +static struct clk
>> +*intel_clk_register_fixed(struct intel_clk_provider *ctx,
>> +                         struct intel_clk_branch *list)
>> +{
>> +       if (list->div_flags & CLOCK_FLAG_VAL_INIT)
>> +               intel_set_clk_val(ctx->map, list->div_off, list->div_shift,
>> +                                 list->div_width, list->div_val);
>> +
>> +       return clk_register_fixed_rate(NULL, list->name, list->parent_names[0],
>> +                                      list->flags, list->mux_flags);
>> +}
>> +
>> +static u8 intel_clk_mux_get_parent(struct clk_hw *hw)
>> +{
>> +       struct intel_clk_mux *mux = to_intel_clk_mux(hw);
>> +       u32 val;
>> +
>> +       val = intel_get_clk_val(mux->map, mux->reg, mux->shift, mux->width);
>> +       return clk_mux_val_to_index(hw, NULL, mux->flags, val);
>> +}
>> +
>> +static int intel_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +       struct intel_clk_mux *mux = to_intel_clk_mux(hw);
>> +       u32 val;
>> +
>> +       val = clk_mux_index_to_val(NULL, mux->flags, index);
>> +       intel_set_clk_val(mux->map, mux->reg, mux->shift, mux->width, val);
>> +
>> +       return 0;
>> +}
>> +
>> +static int intel_clk_mux_determine_rate(struct clk_hw *hw,
>> +                                       struct clk_rate_request *req)
>> +{
>> +       struct intel_clk_mux *mux = to_intel_clk_mux(hw);
>> +
>> +       return clk_mux_determine_rate_flags(hw, req, mux->flags);
>> +}
>> +
>> +const static struct clk_ops intel_clk_mux_ops = {
>> +       .get_parent = intel_clk_mux_get_parent,
>> +       .set_parent = intel_clk_mux_set_parent,
>> +       .determine_rate = intel_clk_mux_determine_rate,
>> +};
>> +
>> +static struct clk
>> +*intel_clk_register_mux(struct intel_clk_provider *ctx,
>> +                       struct intel_clk_branch *list)
>> +{
>> +       struct clk_init_data init;
>> +       struct clk_hw *hw;
>> +       struct intel_clk_mux *mux;
>> +       u32 reg = list->mux_off;
>> +       u8 shift = list->mux_shift;
>> +       u8 width = list->mux_width;
>> +       unsigned long cflags = list->mux_flags;
>> +       int ret;
>> +
>> +       mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>> +       if (!mux)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = list->name;
>> +       init.ops = &intel_clk_mux_ops;
>> +       init.flags = list->flags | CLK_IS_BASIC;
>> +       init.parent_names = list->parent_names;
>> +       init.num_parents = list->num_parents;
>> +
>> +       mux->map = ctx->map;
>> +       mux->reg = reg;
>> +       mux->shift = shift;
>> +       mux->width = width;
>> +       mux->flags = cflags;
>> +       mux->hw.init = &init;
>> +
>> +       hw = &mux->hw;
>> +       ret = clk_hw_register(NULL, hw);
>> +       if (ret) {
>> +               kfree(mux);
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       if (cflags & CLOCK_FLAG_VAL_INIT)
>> +               intel_set_clk_val(ctx->map, reg, shift, width, list->mux_val);
>> +
>> +       return hw->clk;
>> +}
>> +
>> +static unsigned long
>> +intel_clk_divider_recalc_rate(struct clk_hw *hw,
>> +                             unsigned long parent_rate)
>> +{
>> +       struct intel_clk_divider *divider = to_intel_clk_divider(hw);
>> +       unsigned int val;
>> +
>> +       val = intel_get_clk_val(divider->map, divider->reg,
>> +                               divider->shift, divider->width);
>> +       return divider_recalc_rate(hw, parent_rate, val, divider->table,
>> +                                  divider->flags, divider->width);
>> +}
>> +
>> +static long
>> +intel_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                            unsigned long *prate)
>> +{
>> +       struct intel_clk_divider *divider = to_intel_clk_divider(hw);
>> +
>> +       return divider_round_rate(hw, rate, prate, divider->table,
>> +                                 divider->width, divider->flags);
>> +}
>> +
>> +static int
>> +intel_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                          unsigned long prate)
>> +{
>> +       struct intel_clk_divider *divider = to_intel_clk_divider(hw);
>> +       int value;
>> +
>> +       value = divider_get_val(rate, prate, divider->table,
>> +                               divider->width, divider->flags);
>> +       if (value < 0)
>> +               return value;
>> +
>> +       intel_set_clk_val(divider->map, divider->reg,
>> +                         divider->shift, divider->width, value);
>> +
>> +       return 0;
>> +}
>> +
>> +const static struct clk_ops intel_clk_divider_ops = {
>> +       .recalc_rate = intel_clk_divider_recalc_rate,
>> +       .round_rate = intel_clk_divider_round_rate,
>> +       .set_rate = intel_clk_divider_set_rate,
>> +};
>> +
>> +static struct clk
>> +*intel_clk_register_divider(struct intel_clk_provider *ctx,
>> +                           struct intel_clk_branch *list)
>> +{
>> +       struct clk_init_data init;
>> +       struct clk_hw *hw;
>> +       struct intel_clk_divider *div;
>> +       u32 reg = list->div_off;
>> +       u8 shift = list->div_shift;
>> +       u8 width = list->div_width;
>> +       unsigned long cflags = list->div_flags;
>> +       int ret;
>> +
>> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
>> +       if (!div)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = list->name;
>> +       init.ops = &intel_clk_divider_ops;
>> +       init.flags = list->flags | CLK_IS_BASIC;
>> +       init.parent_names = &list->parent_names[0];
>> +       init.num_parents = 1;
>> +
>> +       div->map = ctx->map;
>> +       div->reg = reg;
>> +       div->shift = shift;
>> +       div->width = width;
>> +       div->flags = cflags;
>> +       div->table = list->div_table;
>> +       div->hw.init = &init;
>> +
>> +       hw = &div->hw;
>> +       ret = clk_hw_register(NULL, hw);
>> +       if (ret) {
>> +               pr_err("%s: register clk: %s failed!\n",
>> +                      __func__, list->name);
>> +               kfree(div);
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       if (cflags & CLOCK_FLAG_VAL_INIT)
>> +               intel_set_clk_val(ctx->map, reg, shift, width, list->div_val);
>> +
>> +       return hw->clk;
>> +}
>> +
>> +static struct clk
>> +*intel_clk_register_fixed_factor(struct intel_clk_provider *ctx,
>> +                                struct intel_clk_branch *list)
>> +{
>> +       struct clk_hw *hw;
>> +
>> +       hw = clk_hw_register_fixed_factor(NULL, list->name,
>> +                                         list->parent_names[0], list->flags,
>> +                                         list->mult, list->div);
>> +       if (IS_ERR(hw))
>> +               return ERR_CAST(hw);
>> +
>> +       if (list->div_flags & CLOCK_FLAG_VAL_INIT)
>> +               intel_set_clk_val(ctx->map, list->div_off, list->div_shift,
>> +                                 list->div_width, list->div_val);
>> +
>> +       return hw->clk;
>> +}
>> +
>> +static int
>> +intel_clk_gate_enable(struct clk_hw *hw)
>> +{
>> +       struct intel_clk_gate *gate = to_intel_clk_gate(hw);
>> +       unsigned int reg;
>> +
>> +       if (gate->flags & GATE_CLK_VT) {
>> +               gate->reg = 1;
>> +               return 0;
>> +       }
>> +
>> +       if (gate->flags & GATE_CLK_HW) {
>> +               reg = GATE_HW_REG_EN(gate->reg);
>> +       } else if (gate->flags & GATE_CLK_SW) {
>> +               reg = gate->reg;
>> +       } else {
>> +               pr_err("%s: gate clk: %s: flag 0x%lx not supported!\n",
>> +                      __func__, clk_hw_get_name(hw), gate->flags);
>> +               return 0;
>> +       }
>> +
>> +       intel_set_clk_val(gate->map, reg, gate->shift, 1, 1);
>> +
>> +       return 0;
>> +}
>> +
>> +static void
>> +intel_clk_gate_disable(struct clk_hw *hw)
>> +{
>> +       struct intel_clk_gate *gate = to_intel_clk_gate(hw);
>> +       unsigned int reg;
>> +       unsigned int set;
>> +
>> +       if (gate->flags & GATE_CLK_VT) {
>> +               gate->reg = 0;
>> +               return;
>> +       }
>> +
>> +       if (gate->flags & GATE_CLK_HW) {
>> +               reg = GATE_HW_REG_DIS(gate->reg);
>> +               set = 1;
>> +       } else if (gate->flags & GATE_CLK_SW) {
>> +               reg = gate->reg;
>> +               set = 0;
>> +       } else {
>> +               pr_err("%s: gate clk: %s: flag 0x%lx not supported!\n",
>> +                      __func__, clk_hw_get_name(hw), gate->flags);
>> +               return;
>> +       }
>> +
>> +       intel_set_clk_val(gate->map, reg, gate->shift, 1, set);
>> +}
>> +
>> +static int
>> +intel_clk_gate_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct intel_clk_gate *gate = to_intel_clk_gate(hw);
>> +       unsigned int reg;
>> +
>> +       if (gate->flags & GATE_CLK_VT)
>> +               return gate->reg;
>> +
>> +       if (gate->flags & GATE_CLK_HW) {
>> +               reg = GATE_HW_REG_STAT(gate->reg);
>> +       } else if (gate->flags & GATE_CLK_SW) {
>> +               reg = gate->reg;
>> +       } else {
>> +               pr_err("%s: gate clk: %s: flag 0x%lx not supported!\n",
>> +                      __func__, clk_hw_get_name(hw), gate->flags);
>> +               return 0;
>> +       }
>> +
>> +       return intel_get_clk_val(gate->map, reg, gate->shift, 1);
>> +}
>> +
>> +const static struct clk_ops intel_clk_gate_ops = {
>> +       .enable = intel_clk_gate_enable,
>> +       .disable = intel_clk_gate_disable,
>> +       .is_enabled = intel_clk_gate_is_enabled,
>> +};
>> +
>> +static struct clk
>> +*intel_clk_register_gate(struct intel_clk_provider *ctx,
>> +                        struct intel_clk_branch *list)
>> +{
>> +       struct clk_init_data init;
> Please init the init struct with { } so that future possible additions
> to the structure don't require us to hunt this silent corruption down
> later.
Will update it.

>> +       struct clk_hw *hw;
>> +       struct intel_clk_gate *gate;
>> +       u32 reg = list->gate_off;
>> +       u8 shift = list->gate_shift;
>> +       unsigned long cflags = list->gate_flags;
>> +       const char *pname = list->parent_names[0];
>> +       int ret;
>> +
>> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>> +       if (!gate)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = list->name;
>> +       init.ops = &intel_clk_gate_ops;
>> +       init.flags = list->flags | CLK_IS_BASIC;
>> +       init.parent_names = pname ? &pname : NULL;
>> +       init.num_parents = pname ? 1 : 0;
>> +
>> +       gate->map       = ctx->map;
>> +       gate->reg       = reg;
>> +       gate->shift     = shift;
>> +       gate->flags     = cflags;
>> +       gate->hw.init   = &init;
>> +
>> +       hw = &gate->hw;
>> +       ret = clk_hw_register(NULL, hw);
>> +       if (ret) {
>> +               kfree(gate);
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       if (cflags & CLOCK_FLAG_VAL_INIT)
>> +               intel_set_clk_val(ctx->map, reg, shift, 1, list->gate_val);
>> +
>> +       return hw->clk;
>> +}
>> +
>> +void intel_clk_register_branches(struct intel_clk_provider *ctx,
>> +                                struct intel_clk_branch *list,
>> +                                unsigned int nr_clk)
>> +{
>> +       struct clk *clk;
>> +       unsigned int idx;
>> +
>> +       for (idx = 0; idx < nr_clk; idx++, list++) {
>> +               switch (list->type) {
>> +               case intel_clk_fixed:
> Please use uppercase for enums.
Will update.

>
>> +                       clk = intel_clk_register_fixed(ctx, list);
>> +                       break;
>> +               case intel_clk_mux:
>> +                       clk = intel_clk_register_mux(ctx, list);
>> +                       break;
>> +               case intel_clk_divider:
>> +                       clk = intel_clk_register_divider(ctx, list);
>> +                       break;
>> +               case intel_clk_fixed_factor:
>> +                       clk = intel_clk_register_fixed_factor(ctx, list);
>> +                       break;
>> +               case intel_clk_gate:
>> +                       clk = intel_clk_register_gate(ctx, list);
>> +                       break;
>> +               default:
>> +                       pr_err("%s: type: %u not supported!\n",
>> +                              __func__, list->type);
>> +                       return;
>> +               }
>> +
>> +               if (IS_ERR(clk)) {
>> +                       pr_err("%s: register clk: %s, type: %u failed!\n",
>> +                              __func__, list->name, list->type);
>> +                       return;
>> +               }
>> +
>> +               intel_clk_add_lookup(ctx, clk, list->id);
>> +       }
>> +}
>> +
>> +struct intel_clk_provider * __init
>> +intel_clk_init(struct device_node *np, struct regmap *map, unsigned int nr_clks)
>> +{
>> +       struct intel_clk_provider *ctx;
>> +       struct clk **clks;
>> +
>> +       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +       if (!ctx)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       clks = kcalloc(nr_clks, sizeof(*clks), GFP_KERNEL);
>> +       if (!clks) {
>> +               kfree(ctx);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       memset_p((void **)clks, ERR_PTR(-ENOENT), nr_clks);
>> +       ctx->map = map;
>> +       ctx->clk_data.clks = clks;
>> +       ctx->clk_data.clk_num = nr_clks;
>> +       ctx->np = np;
>> +
>> +       return ctx;
>> +}
>> +
>> +void __init intel_clk_register_osc(struct intel_clk_provider *ctx,
>> +                                  struct intel_osc_clk *osc,
>> +                                  unsigned int nr_clks)
>> +{
>> +       u32 freq;
>> +       struct clk *clk;
>> +       int idx;
>> +
>> +       for (idx = 0; idx < nr_clks; idx++, osc++) {
>> +               if (!osc->dt_freq ||
>> +                   of_property_read_u32(ctx->np, osc->dt_freq, &freq))
>> +                       freq = osc->def_rate;
>> +
>> +               clk = clk_register_fixed_rate(NULL, osc->name, NULL, 0, freq);
> Should come from DT itself.
Yes. It can be defined as fixed-clock node in device tree.
Do you mean it should be defined in device tree and driver reference it 
via device tree?

>> +               iS_ERR(clk)) {
>> +                       pr_err("%s: Failed to register clock: %s\n",
>> +                              __func__, osc->name);
>> +                       return;
>> +               }
>> +
>> +               intel_clk_add_lookup(ctx, clk, osc->id);
>> +       }
>> +}
>> diff --git a/drivers/clk/intel/clk-cgu.h b/drivers/clk/intel/clk-cgu.h
>> new file mode 100644
>> index 000000000000..6dc4e45fc499
>> --- /dev/null
>> +++ b/drivers/clk/intel/clk-cgu.h
>> @@ -0,0 +1,259 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Copyright(c) 2018 Intel Corporation.
>> + *  Zhu YiXin <Yixin.zhu@intel.com>
>> + */
>> +
>> +#ifndef __INTEL_CLK_H
>> +#define __INTEL_CLK_H
>> +
>> +#define PNAME(x) static const char *const x[] __initconst
>> +
>> +struct intel_clk_mux {
>> +       struct clk_hw   hw;
>> +       struct regmap   *map;
>> +       unsigned int    reg;
>> +       u8              shift;
>> +       u8              width;
>> +       unsigned long   flags;
>> +};
>> +
>> +struct intel_clk_divider {
>> +       struct clk_hw   hw;
>> +       struct regmap   *map;
>> +       unsigned int    reg;
>> +       u8              shift;
>> +       u8              width;
>> +       unsigned long   flags;
>> +       const struct clk_div_table      *table;
>> +};
>> +
>> +struct intel_clk_gate {
>> +       struct clk_hw   hw;
>> +       struct regmap   *map;
>> +       unsigned int    reg;
>> +       u8              shift;
>> +       unsigned long   flags;
>> +};
>> +
>> +enum intel_clk_type {
>> +       intel_clk_fixed,
>> +       intel_clk_mux,
>> +       intel_clk_divider,
>> +       intel_clk_fixed_factor,
>> +       intel_clk_gate,
>> +};
>> +
>> +/**
>> + * struct intel_clk_provider
>> + * @map: regmap type base address for register.
>> + * @np: device node
>> + * @clk_data: array of hw clocks and clk number.
>> + */
>> +struct intel_clk_provider {
>> +       struct regmap           *map;
>> +       struct device_node      *np;
>> +       struct clk_onecell_data clk_data;
> Please register clk_hw pointers instead of clk pointers with the of
> provider APIs.
Sorry.  I'm not sure I understand you correctly.
If only registering clk_hw pointer,  not registering of_provider API, then
how to reference it in the user drivers ?
Could you please give me more hints ?

>> +};
>> +
>> +/**
>> + * struct intel_pll_clk
>> + * @id: plaform specific id of the clock.
>> + * @name: name of this pll clock.
>> + * @parent_names: name of the parent clock.
>> + * @num_parents: number of parents.
>> + * @flags: optional flags for basic clock.
>> + * @type: platform type of pll.
>> + * @reg: offset of the register.
>> + * @mult: init value of mulitplier.
>> + * @div: init value of divider.
>> + * @frac: init value of fraction.
>> + * @rate_table: table of pll clock rate.
> Please drop the full-stop on kernel doc one-liners like this.
Will update it.

>
>> + */
>> +struct intel_pll_clk {
>> +       unsigned int            id;
>> +       const char              *name;
>> +       const char              *const *parent_names;
>> +       u8                      num_parents;
> Can the PLL have multiple parents?
Yes. But not in this platform.
The define here make it easy to expand to support new platform.

>> +       unsigned long           flags;
>> +       enum intel_pll_type     type;
>> +       int                     reg;
>> +       unsigned int            mult;
>> +       unsigned int            div;
>> +       unsigned int            frac;
>> +       const struct intel_pll_rate_table *rate_table;
>> +};
>> +
>> +#define INTEL_PLL(_id, _type, _name, _pnames, _flags,  \
>> +           _reg, _rtable, _mult, _div, _frac)          \
>> +       {                                               \
>> +               .id             = _id,                  \
>> +               .type           = _type,                \
>> +               .name           = _name,                \
>> +               .parent_names   = _pnames,              \
>> +               .num_parents    = ARRAY_SIZE(_pnames),  \
>> +               .flags          = _flags,               \
>> +               .reg            = _reg,                 \
>> +               .rate_table     = _rtable,              \
>> +               .mult           = _mult,                \
>> +               .div            = _div,                 \
>> +               .frac           = _frac                 \
>> +       }
>> +
>> +/**
>> + * struct intel_osc_clk
>> + * @id: platform specific id of the clock.
>> + * @name: name of the osc clock.
>> + * @dt_freq: frequency node name in device tree.
>> + * @def_rate: default rate of the osc clock.
>> + * @flags: optional flags for basic clock.
> There aren't flags though. I'm very confused by this kernel-doc too.
> Looks like something that should be done with a fixed rate clk in DT.
Will remove the flags comments.

>> + */
>> +struct intel_osc_clk {
>> +       unsigned int            id;
>> +       const char              *name;
>> +       const char              *dt_freq;
>> +       const u32               def_rate;
>> +};
>> +
>> +#define INTEL_OSC(_id, _name, _freq, _rate)                    \
>> +       {                                               \
>> +               .id             = _id,                  \
>> +               .name           = _name,                \
>> +               .dt_freq        = _freq,                \
>> +               .def_rate       = _rate,                \
>> +       }
>> +
>> +struct intel_clk_branch {
> Seems to be more like intel_clk instead of intel_clk_branch because it
> does lots of stuff.
Will update.

>> +       unsigned int                    id;
>> +       enum intel_clk_type             type;
>> +       const char                      *name;
>> +       const char                      *const *parent_names;
>> +       u8                              num_parents;
>> +       unsigned long                   flags;
>> +       unsigned int                    mux_off;
>> +       u8                              mux_shift;
>> +       u8                              mux_width;
>> +       unsigned long                   mux_flags;
>> +       unsigned int                    mux_val;
>> +       unsigned int                    div_off;
>> +       u8                              div_shift;
>> +       u8                              div_width;
>> +       unsigned long                   div_flags;
>> +       unsigned int                    div_val;
>> +       const struct clk_div_table      *div_table;
>> +       unsigned int                    gate_off;
>> +       u8                              gate_shift;
>> +       unsigned long                   gate_flags;
>> +       unsigned int                    gate_val;
>> +       unsigned int                    mult;
>> +       unsigned int                    div;
>> +};
>> +
>> +/* clock flags definition */
>> +#define CLOCK_FLAG_VAL_INIT    BIT(16)
>> +#define GATE_CLK_HW            BIT(17)
>> +#define GATE_CLK_SW            BIT(18)
>> +#define GATE_CLK_VT            BIT(19)
> What does VT mean? Virtual?
Yes. VT means virtual here.
Will change to GATE_CLK_VIRT.

>> +
>> +#define INTEL_MUX(_id, _name, _pname, _f, _reg,                        \
>> +           _shift, _width, _cf, _v)                            \
>> +       {                                                       \
>> +               .id             = _id,                          \
>> +               .type           = intel_clk_mux,                \
>> +               .name           = _name,                        \
>> +               .parent_names   = _pname,                       \
>> +               .num_parents    = ARRAY_SIZE(_pname),           \
>> +               .flags          = _f,                           \
>> +               .mux_off        = _reg,                         \
>> +               .mux_shift      = _shift,                       \
>> +               .mux_width      = _width,                       \
>> +               .mux_flags      = _cf,                          \
>> +               .mux_val        = _v,                           \
>> +       }
>> +
>> +#define INTEL_DIV(_id, _name, _pname, _f, _reg,                        \
>> +           _shift, _width, _cf, _v, _dtable)                   \
>> +       {                                                       \
>> +               .id             = _id,                          \
>> +               .type           = intel_clk_divider,            \
>> +               .name           = _name,                        \
>> +               .parent_names   = (const char *[]) { _pname },  \
>> +               .num_parents    = 1,                            \
>> +               .flags          = _f,                           \
>> +               .div_off        = _reg,                         \
>> +               .div_shift      = _shift,                       \
>> +               .div_width      = _width,                       \
>> +               .div_flags      = _cf,                          \
>> +               .div_val        = _v,                           \
>> +               .div_table      = _dtable,                      \
>> +       }
>> +
>> +#define INTEL_GATE(_id, _name, _pname, _f, _reg,               \
>> +            _shift, _cf, _v)                                   \
>> +       {                                                       \
>> +               .id             = _id,                          \
>> +               .type           = intel_clk_gate,               \
>> +               .name           = _name,                        \
>> +               .parent_names   = (const char *[]) { _pname },  \
>> +               .num_parents    = !_pname ? 0 : 1,              \
>> +               .flags          = _f,                           \
>> +               .gate_off       = _reg,                         \
>> +               .gate_shift     = _shift,                       \
>> +               .gate_flags     = _cf,                          \
>> +               .gate_val       = _v,                           \
>> +       }
>> +
>> +#define INTEL_FIXED(_id, _name, _pname, _f, _reg,              \
>> +             _shift, _width, _cf, _freq, _v)                   \
>> +       {                                                       \
>> +               .id             = _id,                          \
>> +               .type           = intel_clk_fixed,              \
>> +               .name           = _name,                        \
>> +               .parent_names   = (const char *[]) { _pname },  \
>> +               .num_parents    = !_pname ? 0 : 1,              \
>> +               .flags          = _f,                           \
>> +               .div_off        = _reg,                         \
>> +               .div_shift      = _shift,                       \
>> +               .div_width      = _width,                       \
>> +               .div_flags      = _cf,                          \
>> +               .div_val        = _v,                           \
>> +               .mux_flags      = _freq,                        \
>> +       }
>> +
>> +#define INTEL_FIXED_FACTOR(_id, _name, _pname, _f, _reg,       \
>> +              _shift, _width, _cf, _v, _m, _d)                 \
>> +       {                                                       \
>> +               .id             = _id,                          \
>> +               .type           = intel_clk_fixed_factor,       \
>> +               .name           = _name,                        \
>> +               .parent_names   = (const char *[]) { _pname },  \
>> +               .num_parents    = 1,                            \
>> +               .flags          = _f,                           \
>> +               .div_off        = _reg,                         \
>> +               .div_shift      = _shift,                       \
>> +               .div_width      = _width,                       \
>> +               .div_flags      = _cf,                          \
>> +               .div_val        = _v,                           \
>> +               .mult           = _m,                           \
>> +               .div            = _d,                           \
>> +       }
>> +
>> +void intel_set_clk_val(struct regmap *map, u32 reg, u8 shift,
>> +                      u8 width, u32 set_val);
>> +u32 intel_get_clk_val(struct regmap *map, u32 reg, u8 shift, u8 width);
>> +void intel_clk_add_lookup(struct intel_clk_provider *ctx,
>> +                         struct clk *clk, unsigned int id);
>> +void __init intel_clk_of_add_provider(struct device_node *np,
>> +                                     struct intel_clk_provider *ctx);
>> +struct intel_clk_provider * __init
>> +intel_clk_init(struct device_node *np, struct regmap *map,
>> +              unsigned int nr_clks);
>> +void __init intel_clk_register_osc(struct intel_clk_provider *ctx,
>> +                                  struct intel_osc_clk *osc,
>> +                                  unsigned int nr_clks);
> Remove __init from headers files. It does nothing.
Will remove it.

>
>> +void intel_clk_register_branches(struct intel_clk_provider *ctx,
>> +                                struct intel_clk_branch *list,
>> +                                unsigned int nr_clk);
>> +void intel_clk_register_plls(struct intel_clk_provider *ctx,
>> +                            struct intel_pll_clk *list, unsigned int nr_clk);
>> +#endif /* __INTEL_CLK_H */
>> diff --git a/drivers/clk/intel/clk-grx500.c b/drivers/clk/intel/clk-grx500.c
>> new file mode 100644
>> index 000000000000..5c2546f82579
>> --- /dev/null
>> +++ b/drivers/clk/intel/clk-grx500.c
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2018 Intel Corporation.
>> + *  Zhu YiXin <Yixin.zhu@intel.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spinlock.h>
> Used?
Will remove it

>> +#include <dt-bindings/clock/intel,grx500-clk.h>
>> +
>> +#include "clk-cgu-pll.h"
>> +#include "clk-cgu.h"
>> +
>> +#define PLL_DIV_WIDTH          4
>> +
>> +/* Gate1 clock shift */
>> +#define G_VCODEC_SHIFT         2
>> +#define G_DMA0_SHIFT           5
>> +#define G_USB0_SHIFT           6
>> +#define G_SPI1_SHIFT           7
>> +#define G_SPI0_SHIFT           8
>> +#define G_CBM_SHIFT            9
>> +#define G_EBU_SHIFT            10
>> +#define G_SSO_SHIFT            11
>> +#define G_GPTC0_SHIFT          12
>> +#define G_GPTC1_SHIFT          13
>> +#define G_GPTC2_SHIFT          14
>> +#define G_UART_SHIFT           17
>> +#define G_CPYTO_SHIFT          20
>> +#define G_SECPT_SHIFT          21
>> +#define G_TOE_SHIFT            22
>> +#define G_MPE_SHIFT            23
>> +#define G_TDM_SHIFT            25
>> +#define G_PAE_SHIFT            26
>> +#define G_USB1_SHIFT           27
>> +#define G_SWITCH_SHIFT         28
>> +
>> +/* Gate2 clock shift */
>> +#define G_PCIE0_SHIFT          1
>> +#define G_PCIE1_SHIFT          17
>> +#define G_PCIE2_SHIFT          25
>> +
>> +/* Register definition */
>> +#define GRX500_PLL0A_CFG0      0x0004
>> +#define GRX500_PLL0A_CFG1      0x0008
>> +#define GRX500_PLL0B_CFG0      0x0034
>> +#define GRX500_PLL0B_CFG1      0x0038
>> +#define GRX500_LCPLL_CFG0      0x0094
>> +#define GRX500_LCPLL_CFG1      0x0098
>> +#define GRX500_IF_CLK          0x00c4
>> +#define GRX500_CLK_GSR1                0x0120
>> +#define GRX500_CLK_GSR2                0x0130
>> +
>> +static const struct clk_div_table pll_div[] = {
>> +       {1,     2},
> Please write it like
>
> 	  { 1,    2 },
>
> instead.
Will update.

>> +       {2,     3},
>> +       {3,     4},
>> +       {4,     5},
>> +       {5,     6},
>> +       {6,     8},
>> +       {7,     10},
>> +       {8,     12},
>> +       {9,     16},
>> +       {10,    20},
>> +       {11,    24},
>> +       {12,    32},
>> +       {13,    40},
>> +       {14,    48},
>> +       {15,    64}
>> +};
>> +
>> +enum grx500_plls {
>> +       pll0a, pll0b, pll3,
>> +};
> What's the point of the enum?
Will remove it.

>> +
>> +PNAME(pll_p)   = { "osc" };
>> +PNAME(cpu_p)   = { "cpu0", "cpu1" };
>> +
>> +static struct intel_osc_clk grx500_osc_clks[] __initdata = {
>> +       INTEL_OSC(CLK_OSC, "osc", "intel,osc-frequency", 40000000),
>> +};
>> +
>> +static struct intel_pll_clk grx500_pll_clks[] __initdata = {
>> +       [pll0a] = INTEL_PLL(CLK_PLL0A, pll_grx500, "pll0a",
>> +                     pll_p, 0, GRX500_PLL0A_CFG0, NULL, 0, 0, 0),
>> +       [pll0b] = INTEL_PLL(CLK_PLL0B, pll_grx500, "pll0b",
>> +                     pll_p, 0, GRX500_PLL0B_CFG0, NULL, 0, 0, 0),
>> +       [pll3] = INTEL_PLL(CLK_PLL3, pll_grx500, "pll3",
>> +                    pll_p, 0, GRX500_LCPLL_CFG0, NULL, 0, 0, 0),
>> +};
>> +
>> +static struct intel_clk_branch grx500_branch_clks[] __initdata = {
>> +       INTEL_DIV(CLK_CBM, "cbm", "pll0a", 0, GRX500_PLL0A_CFG1,
>> +                 0, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_NGI, "ngi", "pll0a", 0, GRX500_PLL0A_CFG1,
>> +                 4, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_SSX4, "ssx4", "pll0a", 0, GRX500_PLL0A_CFG1,
>> +                 8, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_CPU0, "cpu0", "pll0a", 0, GRX500_PLL0A_CFG1,
>> +                 12, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_PAE, "pae", "pll0b", 0, GRX500_PLL0B_CFG1,
>> +                 0, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_GSWIP, "gswip", "pll0b", 0, GRX500_PLL0B_CFG1,
>> +                 4, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_DDR, "ddr", "pll0b", 0, GRX500_PLL0B_CFG1,
>> +                 8, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_DIV(CLK_CPU1, "cpu1", "pll0b", 0, GRX500_PLL0B_CFG1,
>> +                 12, PLL_DIV_WIDTH, 0, 0, pll_div),
>> +       INTEL_MUX(CLK_CPU, "cpu", cpu_p, CLK_SET_RATE_PARENT,
>> +                 GRX500_PLL0A_CFG1, 29, 1, 0, 0),
>> +       INTEL_GATE(GCLK_DMA0, "g_dma0", NULL, 0, GRX500_CLK_GSR1,
>> +                  G_DMA0_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_USB0, "g_usb0", NULL, 0, GRX500_CLK_GSR1,
>> +                  G_USB0_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_GPTC0, "g_gptc0", NULL, 0, GRX500_CLK_GSR1,
>> +                  G_GPTC0_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_GPTC1, "g_gptc1", NULL, 0, GRX500_CLK_GSR1,
>> +                  G_GPTC1_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_GPTC2, "g_gptc2", NULL, 0, GRX500_CLK_GSR1,
>> +                  G_GPTC2_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_UART, "g_uart", NULL, 0, GRX500_CLK_GSR1,
>> +                  G_UART_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_PCIE0, "g_pcie0", NULL, 0, GRX500_CLK_GSR2,
>> +                  G_PCIE0_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_PCIE1, "g_pcie1", NULL, 0, GRX500_CLK_GSR2,
>> +                  G_PCIE1_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_PCIE2, "g_pcie2", NULL, 0, GRX500_CLK_GSR2,
>> +                  G_PCIE2_SHIFT, GATE_CLK_HW, 0),
>> +       INTEL_GATE(GCLK_I2C, "g_i2c", NULL, 0, 0, 0, GATE_CLK_VT, 0),
>> +       INTEL_FIXED(CLK_VOICE, "voice", NULL, 0, GRX500_IF_CLK, 14, 2,
>> +                   CLOCK_FLAG_VAL_INIT, 8192000, 2),
>> +       INTEL_FIXED_FACTOR(CLK_DDRPHY, "ddrphy", "ddr", 0, 0, 0,
>> +                          0, 0, 0, 2, 1),
>> +       INTEL_FIXED_FACTOR(CLK_PCIE, "pcie", "pll3", 0, 0, 0,
>> +                          0, 0, 0, 1, 40),
>> +};
>> +
>> +static void __init grx500_clk_init(struct device_node *np)
>> +{
>> +       struct intel_clk_provider *ctx;
>> +       struct regmap *map;
>> +
>> +       map = syscon_node_to_regmap(np);
>> +       if (IS_ERR(map))
>> +               return;
>> +
>> +       ctx = intel_clk_init(np, map, CLK_NR_CLKS);
>> +       if (IS_ERR(ctx)) {
>> +               regmap_exit(map);
>> +               return;
>> +       }
>> +
>> +       intel_clk_register_osc(ctx, grx500_osc_clks,
>> +                              ARRAY_SIZE(grx500_osc_clks));
>> +       intel_clk_register_plls(ctx, grx500_pll_clks,
>> +                               ARRAY_SIZE(grx500_pll_clks));
>> +       intel_clk_register_branches(ctx, grx500_branch_clks,
>> +                                   ARRAY_SIZE(grx500_branch_clks));
>> +       of_clk_add_provider(np, of_clk_src_onecell_get, &ctx->clk_data);
>> +
>> +       pr_debug("%s clk init done!\n", __func__);
> Yay!!!
>
>> +}
>> +
>> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);
> Any reason a platform driver can't be used instead of CLK_OF_DECLARE()?
It provides CPU clock which is used in early boot stage.
