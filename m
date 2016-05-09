Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 14:32:30 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:55373 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028406AbcEIMc2UIR0R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 14:32:28 +0200
Received: from [10.41.20.11] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.181.6; Mon, 9 May 2016
 05:32:20 -0700
Subject: Re: [PATCH v10 2/3] clk: microchip: Add PIC32 clock driver
To:     Stephen Boyd <sboyd@codeaurora.org>
References: <1458731208-25333-1-git-send-email-purna.mandal@microchip.com>
 <1458731208-25333-3-git-send-email-purna.mandal@microchip.com>
 <20160507001056.GL3492@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
Message-ID: <573082EC.7010803@microchip.com>
Date:   Mon, 9 May 2016 18:00:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20160507001056.GL3492@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

On 05/07/2016 05:40 AM, Stephen Boyd wrote:

> Mostly nitpicks, although I'm worried about the iomem casting and
> addition stuff. I suppose if those are fixed up at some later
> time then I'm fine with this going through MIPS tree.
>
> On 03/23, Purna Chandra Mandal wrote:
>> +static int pbclk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			  unsigned long parent_rate)
>> +{
>> +	struct pic32_periph_clk *pb = clkhw_to_pbclk(hw);
>> +	unsigned long flags;
>> +	u32 v, div;
>> +	int err;
>> +
>> +	/* check & wait for DIV_READY */
>> +	err = readl_poll_timeout_atomic(pb->ctrl_reg, v, v & PB_DIV_READY,
>> +					1, LOCK_TIMEOUT_US);
>> +	if (err)
>> +		return err;
>> +
>> +	/* calculate clkdiv and best rate */
>> +	div = DIV_ROUND_CLOSEST(parent_rate, rate);
>> +
>> +	spin_lock_irqsave(&lock, flags);
>> +
>> +	/* apply new div */
>> +	v = readl(pb->ctrl_reg);
>> +	v &= ~PB_DIV_MASK;
>> +	v |= (div - 1);
>> +
>> +	pic32_syskey_unlock();
>> +
>> +	writel(v, pb->ctrl_reg);
>> +
>> +	spin_unlock_irqrestore(&lock, flags);
>> +
>> +	/* wait again, for pbdivready */
>> +	err = readl_poll_timeout_atomic(pb->ctrl_reg, v, v & PB_DIV_READY,
>> +					1, LOCK_TIMEOUT_US);
> why atomic? The spinlock was released already.
>
ack. Will fix.

>> +	if (err)
>> +		return err;
>> +
>> +	/* confirm that new div is applied correctly */
>> +	return (pbclk_read_pbdiv(pb) == div) ? 0 : -EBUSY;
>> +}
>> +
>> +const struct clk_ops pic32_pbclk_ops = {
>> +	.enable		= pbclk_enable,
>> +	.disable	= pbclk_disable,
>> +	.is_enabled	= pbclk_is_enabled,
>> +	.recalc_rate	= pbclk_recalc_rate,
>> +	.round_rate	= pbclk_round_rate,
>> +	.set_rate	= pbclk_set_rate,
>> +};
>> +
>> +struct clk *pic32_periph_clk_register(struct pic32_periph_clk *pbclk,
>> +				      void __iomem *clk_iobase)
>> +{
>> +	struct clk *clk;
>> +
>> +	pbclk->ctrl_reg += (ulong)clk_iobase;
>> +
>> +	clk = clk_register(NULL, &pbclk->hw);
>> +	if (IS_ERR(clk)) {
>> +		pr_err("%s: clk_register() failed\n", __func__);
>> +		return clk;
>> +	}
>> +
>> +	return clk;
> These two last lines are the same, just print an error and always
> return clk.

ack.

>> +}
>> +
>> +/* Reference Oscillator operations */
>> +#define clkhw_to_refosc(_hw)	container_of(_hw, struct pic32_ref_osc, hw)
>> +
>> +static int roclk_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +
>> +	return readl(refo->regs) & REFO_ON;
>> +}
>> +
>> +static int roclk_enable(struct clk_hw *hw)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +
>> +	writel(REFO_ON | REFO_OE, PIC32_SET(refo->regs));
>> +	return 0;
>> +}
>> +
>> +static void roclk_disable(struct clk_hw *hw)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +
>> +	writel(REFO_ON | REFO_OE, PIC32_CLR(refo->regs));
>> +}
>> +
>> +static void roclk_init(struct clk_hw *hw)
>> +{
>> +	/* initialize clock in disabled state */
>> +	roclk_disable(hw);
>> +}
>> +
>> +static u8 roclk_get_parent(struct clk_hw *hw)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +	u32 v, i;
>> +
>> +	v = (readl(refo->regs) >> REFO_SEL_SHIFT) & REFO_SEL_MASK;
>> +
>> +	if (!refo->parent_map)
>> +		return (u8)v;
>> +
>> +	for (i = 0; i < clk_hw_get_num_parents(hw); i++)
>> +		if (refo->parent_map[i] == v)
>> +			return (u8)i;
> That cast is implicit already.
>
ack.

>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static unsigned long roclk_calc_rate(unsigned long parent_rate,
>> +				     u32 rodiv, u32 rotrim)
>> +{
>> +	u64 rate64;
>> +
>> +	/* fout = fin / [2 * {div + (trim / 512)}]
>> +	 *	= fin * 512 / [1024 * div + 2 * trim]
>> +	 *	= fin * 256 / (512 * div + trim)
>> +	 *	= (fin << 8) / ((div << 9) + trim)
>> +	 */
>> +	if (rotrim) {
>> +		rodiv = (rodiv << 9) + rotrim;
>> +		rate64 = parent_rate;
>> +		rate64 <<= 8;
>> +		do_div(rate64, rodiv);
>> +	} else if (rodiv) {
>> +		rate64 = parent_rate / (rodiv << 1);
>> +	} else {
>> +		rate64 = parent_rate;
>> +	}
>> +	return (unsigned long)rate64;
>> +}
>> +
>> +static void roclk_calc_div_trim(unsigned long rate,
>> +				unsigned long parent_rate,
>> +				u32 *rodiv_p, u32 *rotrim_p)
>> +{
>> +	u32 div, rotrim, rodiv;
>> +	u64 frac;
>> +
>> +	/* Find integer approximation of floating-point arithmetic.
>> +	 *      fout = fin / [2 * {rodiv + (rotrim / 512)}] ... (1)
>> +	 * i.e. fout = fin / 2 * DIV
>> +	 *      whereas DIV = rodiv + (rotrim / 512)
>> +	 *
>> +	 * Since kernel does not perform floating-point arithmatic so
>> +	 * (rotrim/512) will be zero. And DIV & rodiv will result same.
>> +	 *
>> +	 * ie. fout = (fin * 256) / [(512 * rodiv) + rotrim]  ... from (1)
>> +	 * ie. rotrim = ((fin * 256) / fout) - (512 * DIV)
>> +	 */
>> +	if (parent_rate <= rate) {
>> +		div = 0;
>> +		frac = 0;
>> +		rodiv = 0;
>> +		rotrim = 0;
>> +	} else {
>> +		div = parent_rate / (rate << 1);
>> +		frac = parent_rate;
>> +		frac <<= 8;
>> +		do_div(frac, rate);
>> +		frac -= (u64)(div << 9);
>> +
>> +		rodiv = (div > REFO_DIV_MASK) ? REFO_DIV_MASK : div;
>> +		rotrim = (frac >= REFO_TRIM_MAX) ? REFO_TRIM_MAX : frac;
>> +	}
>> +
>> +	if (rodiv_p)
>> +		*rodiv_p = rodiv;
>> +
>> +	if (rotrim_p)
>> +		*rotrim_p = rotrim;
>> +}
>> +
>> +static unsigned long roclk_recalc_rate(struct clk_hw *hw,
>> +				       unsigned long parent_rate)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +	u32 v, rodiv, rotrim;
>> +
>> +	/* get rodiv */
>> +	v = readl(refo->regs);
>> +	rodiv = (v >> REFO_DIV_SHIFT) & REFO_DIV_MASK;
>> +
>> +	/* get trim */
>> +	v = readl(refo->regs + REFO_TRIM_REG);
>> +	rotrim = (v >> REFO_TRIM_SHIFT) & REFO_TRIM_MASK;
>> +
>> +	return roclk_calc_rate(parent_rate, rodiv, rotrim);
>> +}
>> +
>> +static long roclk_round_rate(struct clk_hw *hw, unsigned long rate,
>> +			     unsigned long *parent_rate)
>> +{
>> +	u32 rotrim, rodiv;
>> +
>> +	/* calculate dividers for new rate */
>> +	roclk_calc_div_trim(rate, *parent_rate, &rodiv, &rotrim);
>> +
>> +	/* caclulate new rate (rounding) based on new rodiv & rotrim */
>> +	return roclk_calc_rate(*parent_rate, rodiv, rotrim);
>> +}
>> +
>> +static int roclk_determine_rate(struct clk_hw *hw,
>> +				struct clk_rate_request *req)
>> +{
>> +	struct clk_hw *parent_clk, *best_parent_clk = NULL;
>> +	unsigned int i, delta, best_delta = -1;
>> +	unsigned long parent_rate, best_parent_rate = 0;
>> +	unsigned long best = 0, nearest_rate;
>> +
>> +	/* find a parent which can generate nearest clkrate >= rate */
>> +	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
>> +		/* get parent */
>> +		parent_clk = clk_hw_get_parent_by_index(hw, i);
>> +		if (!parent_clk)
>> +			continue;
>> +
>> +		/* skip if parent runs slower than target rate */
>> +		parent_rate = clk_hw_get_rate(parent_clk);
>> +		if (req->rate > parent_rate)
>> +			continue;
>> +
>> +		nearest_rate = roclk_round_rate(hw, req->rate, &parent_rate);
>> +		delta = abs(nearest_rate - req->rate);
>> +		if ((nearest_rate >= req->rate) && (delta < best_delta)) {
>> +			best_parent_clk = parent_clk;
>> +			best_parent_rate = parent_rate;
>> +			best = nearest_rate;
>> +			best_delta = delta;
>> +
>> +			if (delta == 0)
>> +				break;
>> +		}
>> +	}
>> +
>> +	/* if no match found, retain old rate */
>> +	if (!best_parent_clk) {
>> +		pr_err("%s:%s, no parent found for rate %lu.\n",
>> +		       __func__, clk_hw_get_name(hw), req->rate);
>> +		best_parent_clk = clk_hw_get_parent(hw);
>> +		best_parent_rate = clk_hw_get_rate(best_parent_clk);
> The core would already fill these things in by default so we
> don't really need to get it again.

ack. Will drop above two lines and return from here with old-rate.

>> +		best = clk_hw_get_rate(hw);
>> +	}
>> +
>> +	pr_debug("%s,rate %lu, best_parent(%s, %lu), best %lu, delta %d\n",
>> +		 clk_hw_get_name(hw), req->rate,
>> +		 clk_hw_get_name(best_parent_clk), best_parent_rate,
>> +		 best, best_delta);
>> +
>> +	if (req->best_parent_rate)
>> +		req->best_parent_rate = best_parent_rate;
>> +
>> +	if (req->best_parent_hw)
>> +		req->best_parent_hw = best_parent_clk;
>> +
>> +	return best;
>> +}
>> +
>> +static int roclk_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +	unsigned long flags;
>> +	u32 v;
>> +	int err;
>> +
>> +	if (refo->parent_map)
>> +		index = refo->parent_map[index];
>> +
>> +	/* wait until ACTIVE bit is zero or timeout */
>> +	err = readl_poll_timeout_atomic(refo->regs, v, !(v & REFO_ACTIVE),
> Why atomic?

will replace with non-atomic variant.

>> +					1, LOCK_TIMEOUT_US);
>> +	if (err) {
>> +		pr_err("%s: poll failed, clk active\n", clk_hw_get_name(hw));
>> +		return err;
>> +	}
>> +
>> +	spin_lock_irqsave(&lock, flags);
>> +
>> +	pic32_syskey_unlock();
>> +
>> +	/* calculate & apply new */
>> +	v = readl(refo->regs);
>> +	v &= ~(REFO_SEL_MASK << REFO_SEL_SHIFT);
>> +	v |= index << REFO_SEL_SHIFT;
>> +
>> +	writel(v, refo->regs);
>> +
>> +	spin_unlock_irqrestore(&lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int roclk_set_rate_and_parent(struct clk_hw *hw,
>> +				     unsigned long rate,
>> +				     unsigned long parent_rate,
>> +				     u8 index)
>> +{
>> +	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
>> +	unsigned long flags;
>> +	u32 trim, rodiv, v;
>> +	int err;
>> +
>> +	/* calculate new rodiv & rotrim for new rate */
>> +	roclk_calc_div_trim(rate, parent_rate, &rodiv, &trim);
>> +
>> +	pr_debug("parent_rate = %lu, rate = %lu, div = %d, trim = %d\n",
>> +		 parent_rate, rate, rodiv, trim);
>> +
>> +	/* wait till source change is active */
>> +	err = readl_poll_timeout_atomic(refo->regs, v,
> Why atomic?

will replace with non-atomic variant.

>> +					!(v & (REFO_ACTIVE | REFO_DIVSW_EN)),
>> +					1, LOCK_TIMEOUT_US);
>> +	if (err) {
>> +		pr_err("%s: poll timedout, clock is still active\n", __func__);
>> +		return err;
>> +	}
>> +
>> +	spin_lock_irqsave(&lock, flags);
>> +	v = readl(refo->regs);
>> +
>> +	pic32_syskey_unlock();
>> +
>> +	/* apply parent, if required */
>> +	if (refo->parent_map)
>> +		index = refo->parent_map[index];
>> +
>> +	v &= ~(REFO_SEL_MASK << REFO_SEL_SHIFT);
>> +	v |= index << REFO_SEL_SHIFT;
>> +
>> +	/* apply RODIV */
>> +	v &= ~(REFO_DIV_MASK << REFO_DIV_SHIFT);
>> +	v |= rodiv << REFO_DIV_SHIFT;
>> +	writel(v, refo->regs);
>> +
>> +	/* apply ROTRIM */
>> +	v = readl(refo->regs + REFO_TRIM_REG);
>> +	v &= ~(REFO_TRIM_MASK << REFO_TRIM_SHIFT);
>> +	v |= trim << REFO_TRIM_SHIFT;
>> +	writel(v, refo->regs + REFO_TRIM_REG);
>> +
>> +	/* enable & activate divider switching */
>> +	writel(REFO_ON | REFO_DIVSW_EN, PIC32_SET(refo->regs));
>> +
>> +	/* wait till divswen is in-progress */
>> +	err = readl_poll_timeout_atomic(refo->regs, v, !(v & REFO_DIVSW_EN),
>> +					1, LOCK_TIMEOUT_US);
>> +	/* leave the clk gated as it was */
>> +	writel(REFO_ON, PIC32_CLR(refo->regs));
>> +
>> +	spin_unlock_irqrestore(&lock, flags);
>> +
>> +	return err;
>> +}
>> +
>> +static int roclk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			  unsigned long parent_rate)
>> +{
>> +	u8 index = roclk_get_parent(hw);
>> +
>> +	return roclk_set_rate_and_parent(hw, rate, parent_rate, index);
>> +}
>> +
>> +const struct clk_ops pic32_roclk_ops = {
>> +	.enable			= roclk_enable,
>> +	.disable		= roclk_disable,
>> +	.is_enabled		= roclk_is_enabled,
>> +	.get_parent		= roclk_get_parent,
>> +	.set_parent		= roclk_set_parent,
>> +	.determine_rate		= roclk_determine_rate,
>> +	.recalc_rate		= roclk_recalc_rate,
>> +	.set_rate_and_parent	= roclk_set_rate_and_parent,
>> +	.set_rate		= roclk_set_rate,
>> +	.init			= roclk_init,
>> +};
>> +
>> +struct clk *pic32_refo_clk_register(struct pic32_ref_osc *refo,
>> +				    void __iomem *clk_iobase)
>> +{
>> +	struct clk *clk;
>> +
>> +	refo->regs += (ulong)clk_iobase;
> What happens if we do this and then the driver probe fails for
> some weird reason and we retry probe later? The whole += thing is
> not very appealing to me. We probably need some sort of
> descriptor structure that we generate the final structure out of
> and populate any required fields with.

Thanks for pointing it. Will fix by having constant 'reg_offset' field
populated by SoC variant and clk-core will calculate final 'reg' base
out of it.

>> +
>> +	clk = clk_register(NULL, &refo->hw);
>> +	if (IS_ERR(clk)) {
>> +		pr_err("%s: clk_register() failed\n", __func__);
>> +		return clk;
>> +	}
>> +
>> +	return clk;
>> +}
>> +
>> +#define clkhw_to_spll(_hw)	container_of(_hw, struct pic32_sys_pll, hw)
>> +
>> +static inline u32 spll_odiv_to_divider(u32 odiv)
>> +{
>> +	odiv = clamp_val(odiv, PLL_ODIV_MIN, PLL_ODIV_MAX);
>> +
>> +	return 1 << odiv;
>> +}
>> +
>> +static unsigned long spll_calc_mult_div(struct pic32_sys_pll *pll,
>> +					unsigned long rate,
>> +					unsigned long parent_rate,
>> +					u32 *mult_p, u32 *odiv_p)
>> +{
>> +	u32 mul, div, best_mul = 1, best_div = 1;
>> +	unsigned long new_rate, best_rate = rate;
>> +	unsigned int best_delta = -1, delta, match_found = 0;
>> +	u64 rate64;
>> +
>> +	parent_rate /= pll->idiv;
>> +
>> +	for (mul = 1; mul <= PLL_MULT_MAX; mul++) {
>> +		for (div = PLL_ODIV_MIN; div <= PLL_ODIV_MAX; div++) {
>> +			rate64 = parent_rate;
>> +			rate64 *= mul;
>> +			do_div(rate64, 1 << div);
>> +			new_rate = (u32)rate64;
>> +			delta = abs(rate - new_rate);
>> +			if ((new_rate >= rate) && (delta < best_delta)) {
>> +				best_delta = delta;
>> +				best_rate = new_rate;
>> +				best_mul = mul;
>> +				best_div = div;
>> +				match_found = 1;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (!match_found) {
>> +		pr_warn("spll: no match found\n");
>> +		return 0;
>> +	}
>> +
>> +	pr_debug("rate %lu, par_rate %lu/mult %u, div %u, best_rate %lu\n",
>> +		 rate, parent_rate, best_mul, best_div, best_rate);
>> +
>> +	if (mult_p)
>> +		*mult_p = best_mul - 1;
>> +
>> +	if (odiv_p)
>> +		*odiv_p = best_div;
>> +
>> +	return best_rate;
>> +}
>> +
>> +static unsigned long spll_clk_recalc_rate(struct clk_hw *hw,
>> +					  unsigned long parent_rate)
>> +{
>> +	struct pic32_sys_pll *pll = clkhw_to_spll(hw);
>> +	unsigned long pll_in_rate;
>> +	u32 mult, odiv, div, v;
>> +	u64 rate64;
>> +
>> +	v = readl(pll->ctrl_reg);
>> +	odiv = ((v >> PLL_ODIV_SHIFT) & PLL_ODIV_MASK);
>> +	mult = ((v >> PLL_MULT_SHIFT) & PLL_MULT_MASK) + 1;
>> +	div = spll_odiv_to_divider(odiv);
>> +
>> +	/* pll_in_rate = parent_rate / idiv
>> +	 * pll_out_rate = pll_in_rate * mult / div;
>> +	 */
>> +	pll_in_rate = parent_rate / pll->idiv;
>> +	rate64 = pll_in_rate;
>> +	rate64 *= mult;
>> +	do_div(rate64, div);
>> +
>> +	return (unsigned long)rate64;
> Cast is useless (it's implicit).

ack.

>> +}
>> +
>> +static long spll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>> +				unsigned long *parent_rate)
>> +{
>> +	struct pic32_sys_pll *pll = clkhw_to_spll(hw);
>> +
>> +	return spll_calc_mult_div(pll, rate, *parent_rate, NULL, NULL);
>> +}
>> +
>> +static int spll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			     unsigned long parent_rate)
>> +{
>> +	struct pic32_sys_pll *pll = clkhw_to_spll(hw);
>> +	unsigned long ret, flags;
>> +	u32 mult, odiv, v;
>> +	int err;
>> +
>> +	ret = spll_calc_mult_div(pll, rate, parent_rate, &mult, &odiv);
>> +	if (!ret)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * We can't change SPLL counters when it is in-active use
>> +	 * by SYSCLK. So ensure that PLL clock is not active
>> +	 * parent of SYSCLK before applying new counter/rate.
>> +	 */
>> +
>> +	/* Is spll_clk active parent of sys_clk ? */
>> +	if (unlikely(clk_hw_get_parent(pic32_sclk_hw) == hw)) {
> Why can't we use CLK_SET_RATE_GATE here?

Here we do not want to gate PLL clock, instead check one of the
possible children SYSCLK is not using the PLL as parent.

Please note, CPU is driven by SYSCLK so changing PLL clock rate will
eventually impact CPU behavior. So safer option is to drive SYSCLK by
some other clock(like LPRC), then set new rate to PLL and finally
switch back SYSCLK to PLL once locked at new rate.

>> +		pr_err("%s: failed, clk in-use\n", __func__);
>> +		return -EBUSY;
>> +	}
>> +
>> +	spin_lock_irqsave(&lock, flags);
>> +
>> +	/* apply new multiplier & divisor (read-modify-write) */
>> +	v = readl(pll->ctrl_reg);
>> +	v &= ~(PLL_MULT_MASK << PLL_MULT_SHIFT);
>> +	v &= ~(PLL_ODIV_MASK << PLL_ODIV_SHIFT);
>> +	v |= (mult << PLL_MULT_SHIFT) | (odiv << PLL_ODIV_SHIFT);
>> +
>> diff --git a/drivers/clk/microchip/clk-core.h b/drivers/clk/microchip/clk-core.h
>> new file mode 100644
>> index 0000000..276869a
>> --- /dev/null
>> +++ b/drivers/clk/microchip/clk-core.h
>> @@ -0,0 +1,78 @@
>> +/*
>> + * Purna Chandra Mandal,<purna.mandal@microchip.com>
>> + * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
>> + *
>> + * This program is free software; you can distribute it and/or modify it
>> + * under the terms of the GNU General Public License (Version 2) as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> + * for more details.
>> + */
>> +#ifndef __MICROCHIP_CLK_PIC32_H_
>> +#define __MICROCHIP_CLK_PIC32_H_
>> +
>> +struct clk_hw;
> Not sure why we forward declare this. struct clk_hw is not used
> as a pointer below, so we really need to include clk-provider.h
> here.

ack.

>> +
>> +/* System PLL clock */
>> +struct pic32_sys_pll {
>> +	struct clk_hw hw;
>> +	void __iomem *ctrl_reg;
>> +	void __iomem *status_reg;
>> +	u32 lock_mask;
>> +	u32 idiv; /* PLL iclk divider, treated fixed */
>> +};
>> +
> [..]
>> +#endif /* __MICROCHIP_CLK_PIC32_H_*/
>> diff --git a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
>> new file mode 100644
>> index 0000000..e92e581
>> --- /dev/null
>> +++ b/drivers/clk/microchip/clk-pic32mzda.c
>> @@ -0,0 +1,240 @@
>> +/*
>> + * Purna Chandra Mandal,<purna.mandal@microchip.com>
>> + * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
>> + *
>> + * This program is free software; you can distribute it and/or modify it
>> + * under the terms of the GNU General Public License (Version 2) as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> + * for more details.
>> + */
>> +#include <dt-bindings/clock/microchip,pic32-clock.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <asm/traps.h>
>> +
>> +#include "clk-core.h"
>> +
>> +static void __iomem *pic32_clk_iobase;
>> +static DEFINE_SPINLOCK(lock);
> Please use a better name. pic32_clk_lock? That way when we get
> the lockdep info it doesn't say 'lock'.

Good catch. Will rename.

>> +
>> +/* FRC Postscaler */
>> +#define OSC_FRCDIV_MASK		0x07
>> +#define OSC_FRCDIV_SHIFT	24
>> +
>> +/* SPLL fields */
>> +#define PLL_ICLK_MASK		0x01
>> +#define PLL_ICLK_SHIFT		7
>> +
> [...]
>> +
>> +static struct pic32_sec_osc sosc_clk = {
>> +	.enable_reg = (void __iomem *)0x0,
>> +	.status_reg = (void __iomem *)0x1d0,
>> +	.enable_bitmask = BIT(1),
>> +	.status_bitmask = BIT(4),
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sosc_clk",
>> +		.parent_names = NULL,
>> +		.num_parents = 0,
> This is static data so = 0 is pretty useless.

Will drop.

>> +		.flags = CLK_IS_ROOT,
> This flag is going away. Please don't use it.

Will drop.

>> +		.ops = &pic32_sosc_ops,
>> +	},
>> +};
>> +
>> +static int pic32_fscm_nmi(struct notifier_block *nb,
>> +			  unsigned long action, void *data)
>> +{
>> +	if (readl(pic32_clk_iobase) & BIT(2))
> Why can't we pass this to the notifier by making a wrapper
> structure to hold the iomem pointer and notifier block? That way
> we don't have a static global for this iomem region.

For sake of simplicity we haven't made any effort to wrap it in
structure and avoid all static globals.

>> +		pr_err("pic32-clk: FSCM detected clk failure.\n");
> That's it? No recovery? Is this for debugging (i.e. pr_debug)? 

Currently it only for debugging purpose. Will add comment.

There could be number of reasons which might trigger this event.
Logic detecting reasons and recovery is application dependent and
work-in-progress. 

>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block failsafe_clk_notifier = {
> pic32_failsafe_clk_notifier?

ack.

>> +	.notifier_call = pic32_fscm_nmi,
>> +};
>> +
>> +static int pic32mzda_clk_probe(struct platform_device *pdev)
>> +{
>> +	const char *const pll_mux_parents[] = {"posc_clk", "frc_clk"};
>> +	struct device_node *np = pdev->dev.of_node;
>> +	static struct clk_onecell_data onecell_data;
>> +	static struct clk *clks[MAXCLKS];
>> +	struct clk *pll_mux_clk;
>> +	int nr_clks = 0, i;
>> +
>> +	pic32_clk_iobase = of_io_request_and_map(np, 0, of_node_full_name(np));
>> +	if (IS_ERR(pic32_clk_iobase))
>> +		panic("pic32-clk: failed to map registers\n");
> Just return an error? Panic in probe is not too nice.

ok.

>> +
>> +	/* register fixed rate clocks */
>> +	clks[POSCCLK] = clk_register_fixed_rate(NULL, "posc_clk", NULL,
>> +						CLK_IS_ROOT, 24000000);
>> +	clks[FRCCLK] =  clk_register_fixed_rate(NULL, "frc_clk", NULL,
>> +						CLK_IS_ROOT, 8000000);
>> +	clks[BFRCCLK] = clk_register_fixed_rate(NULL, "bfrc_clk", NULL,
>> +						CLK_IS_ROOT, 8000000);
>> +	clks[LPRCCLK] = clk_register_fixed_rate(NULL, "lprc_clk", NULL,
>> +						CLK_IS_ROOT, 32000);
>> +	clks[UPLLCLK] = clk_register_fixed_rate(NULL, "usbphy_clk", NULL,
>> +						CLK_IS_ROOT, 24000000);
>> +	/* fixed rate (optional) clock */
>> +	if (of_find_property(np, "microchip,pic32mzda-sosc", NULL)) {
>> +		pr_info("pic32-clk: dt requests SOSC.\n");
>> +		clks[SOSCCLK] = pic32_sosc_clk_register(&sosc_clk,
>> +							pic32_clk_iobase);
>> +	}
>> +	/* divider clock */
>> +	clks[FRCDIVCLK] = clk_register_divider(NULL, "frcdiv_clk",
>> +					       "frc_clk", 0,
>> +					       pic32_clk_iobase,
>> +					       OSC_FRCDIV_SHIFT,
>> +					       OSC_FRCDIV_MASK,
>> +					       CLK_DIVIDER_POWER_OF_TWO,
>> +					       &lock);
>> +	/* PLL ICLK mux */
>> +	pll_mux_clk = clk_register_mux(NULL, "spll_mux_clk",
> Please pass device to register functions. Who knows, we may
> start using that someday.

Will add in this and in others as well.

>> +				       pll_mux_parents, 2, 0,
>> +				       pic32_clk_iobase + 0x020,
>> +				       PLL_ICLK_SHIFT, 1, 0, &lock);
>> +	if (IS_ERR(pll_mux_clk))
>> +		panic("spll_mux_clk: clk register failed\n");
>> +	/* PLL */
>> +	clks[PLLCLK] = pic32_spll_clk_register(&sys_pll, pic32_clk_iobase);
>> +	/* SYSTEM clock */
>> +	clks[SCLK] = pic32_sys_clk_register(&sys_mux_clk, pic32_clk_iobase);
>> +	/* Peripheral bus clocks */
>> +	for (nr_clks = PB1CLK, i = 0; nr_clks <= PB7CLK; i++, nr_clks++)
>> +		clks[nr_clks] = pic32_periph_clk_register(&periph_clocks[i],
>> +							  pic32_clk_iobase);
>> +
>> +	/* Reference oscillator clock */
>> +	for (nr_clks = REF1CLK, i = 0; nr_clks <= REF5CLK; i++, nr_clks++)
>> +		clks[nr_clks] = pic32_refo_clk_register(&ref_clks[i],
>> +							pic32_clk_iobase);
>> +	/* register clkdev */
>> +	for (i = 0; i < MAXCLKS; i++) {
>> +		if (IS_ERR(clks[i]))
>> +			continue;
>> +		clk_register_clkdev(clks[i], NULL, __clk_get_name(clks[i]));
>> +	}
>> +	/* register clock provider */
>> +	onecell_data.clks = clks;
>> +	onecell_data.clk_num = MAXCLKS;
>> +	of_clk_add_provider(np, of_clk_src_onecell_get, &onecell_data);
> Check for errors please.

ack.

>> +
>> +	/* register NMI for failsafe clock monitor */
>> +	return register_nmi_notifier(&failsafe_clk_notifier);
>> +}
