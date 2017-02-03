Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 05:28:24 +0100 (CET)
Received: from mail-pg0-x22f.google.com ([IPv6:2607:f8b0:400e:c05::22f]:36338
        "EHLO mail-pg0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdBCE2RIcO2U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 05:28:17 +0100
Received: by mail-pg0-x22f.google.com with SMTP id v184so3010679pgv.3
        for <linux-mips@linux-mips.org>; Thu, 02 Feb 2017 20:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0a6aHRHTr1Qrf8+AKtlv+gAaiJ/9OIzqc0IfwUN/Koc=;
        b=LG9xi+kqYG/DiLgaGHVciDgfOsQ9qimn2B0iWaKhxAqj39jRw3L4a6D10o7ylL2DpM
         ThcFBNEqBTbj5OkhWWgjNfXaUn1ESSdvQfpKVT6Ee6SyK7USqHp7meVi6IWFVey/VgZU
         83qp3Te0Ruso0S3as/ytZnBfjGQSGTAZsFFO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0a6aHRHTr1Qrf8+AKtlv+gAaiJ/9OIzqc0IfwUN/Koc=;
        b=izsiCn3uKCn28L7kl3IT7jF/56EWHcIJa0xJdvkTjWEi+QWmE2k15yea/54BvyqrwE
         OzQiNp6+jBfu/yk3BSsV+9Ql051DQIrtQyIQxUcJKPhaWMbqrAPBVVtEcZtIQPDHWJps
         PFG2arJrInChrcpTXwjEtGYucBIpoFOTrI5Tnf2yiqrX/TYkwSSib/zlHDSc7hpTG2/p
         u6BTzfIYfl1/UI8CP9uV+NFcJ+f/mN+nQh8L9cmXWakIHS9XA0QHtN6Cjdc08r5daavH
         QbqwrM6yOm6CfFRmgN0dfPbLug+2QVsi8PUnp0fmrHWqrn0M99huzt/mvTFCXsR/urQc
         jEzg==
X-Gm-Message-State: AIkVDXJbA9IiUGbC31pXi4YXdeLDJUpIp0ewM7jOVKnw9XjwVj3AqgcNjLw6F5WOTfv3KSJ4
X-Received: by 10.98.30.4 with SMTP id e4mr15473197pfe.19.1486096089081;
        Thu, 02 Feb 2017 20:28:09 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id q19sm62393251pfl.21.2017.02.02.20.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 20:28:08 -0800 (PST)
Date:   Fri, 3 Feb 2017 09:58:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
Message-ID: <20170203042805.GK7458@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net>
 <20170202010601.75995-3-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170202010601.75995-3-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

You must be a cpufreq driver expert by now. What's the count? Is this the 3rd
one you have written ? :)

On 01-02-17, 17:06, Markus Mayer wrote:
> diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
> +static struct cpufreq_frequency_table *
> +bmips_cpufreq_get_freq_table(const struct cpufreq_policy *policy)

Maybe call it bmips_cpufreq_create_freq_table() as that's what you are doing.
But its all up to you only.

> +{
> +	struct cpufreq_frequency_table *table;
> +	struct cpufreq_compat *cc;
> +	unsigned long cpu_freq;
> +	int i;
> +
> +	cc = policy->driver_data;
> +	cpu_freq = htp_freq_to_cpu_freq(cc->clk_mult);
> +
> +	table = kzalloc((cc->max_freqs + 1) * sizeof(*table), GFP_KERNEL);

Maybe kmalloc as you are updating all the entries.

> +	if (!table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < cc->max_freqs; i++) {
> +		table[i].frequency = cpu_freq / (1 << i);
> +		table[i].driver_data = i;
> +	}
> +	table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	return table;
> +}
> +
> +static unsigned int bmips_cpufreq_get(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct cpufreq_compat *cc;
> +	unsigned long freq, cpu_freq;
> +	unsigned int div;
> +	uint32_t mode;
> +
> +	policy = cpufreq_cpu_get(cpu);

You need to do a corresponding cpufreq_cpu_put().

> +	cc = policy->driver_data;
> +
> +	switch (cc->bmips_type) {
> +	case BMIPS5200:
> +	case BMIPS5000:
> +		mode = read_c0_brcm_mode();
> +		div = ((mode >> BMIPS5_CLK_DIV_SHIFT) & BMIPS5_CLK_DIV_MASK);
> +		break;
> +	default:
> +		div = 0;
> +	}
> +
> +	cpu_freq = htp_freq_to_cpu_freq(cc->clk_mult);
> +	freq = cpu_freq / (1 << div);
> +
> +	return freq;
> +}
> +
> +static int bmips_cpufreq_target_index(struct cpufreq_policy *policy,
> +				      unsigned int index)
> +{
> +	struct cpufreq_compat *cc;
> +	unsigned int div;
> +
> +	cc = policy->driver_data;
> +	div = policy->freq_table[index].driver_data;
> +
> +	switch (cc->bmips_type) {
> +	case BMIPS5200:
> +	case BMIPS5000:
> +		change_c0_brcm_mode(BMIPS5_CLK_DIV_MASK << BMIPS5_CLK_DIV_SHIFT,
> +				    (1 << BMIPS5_CLK_DIV_SET_SHIFT) |
> +				    (div << BMIPS5_CLK_DIV_SHIFT));
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmips_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	kfree(policy->freq_table);
> +	policy->freq_table = NULL;

No need to set it to NULL.

> +
> +	return 0;
> +}
> +
> +static int bmips_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	int ret;
> +
> +	/* Store the compatibility data with the policy. */
> +	policy->driver_data = cpufreq_get_driver_data();

Hmm, I wouldn't mind keeping a global variable for this. This driver will be
probed only once and so we can simplify the code a bit. Up to you.

> +
> +	freq_table = bmips_cpufreq_get_freq_table(policy);
> +	if (IS_ERR(freq_table)) {
> +		ret = PTR_ERR(freq_table);
> +		pr_err("%s: couldn't determine frequency table (%d).\n",
> +			BMIPS_CPUFREQ_NAME, ret);
> +		return ret;
> +	}
> +
> +	ret = cpufreq_generic_init(policy, freq_table, TRANSITION_LATENCY);
> +	if (ret)
> +		bmips_cpufreq_exit(policy);
> +	else
> +		pr_info("%s: registered\n", BMIPS_CPUFREQ_NAME);
> +
> +	return ret;
> +}
> +
> +static struct cpufreq_driver bmips_cpufreq_driver = {
> +	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= bmips_cpufreq_target_index,
> +	.get		= bmips_cpufreq_get,
> +	.init		= bmips_cpufreq_init,
> +	.exit		= bmips_cpufreq_exit,
> +	.attr		= cpufreq_generic_attr,
> +	.name		= BMIPS_CPUFREQ_PREFIX,
> +};
> +
> +static int __init bmips_cpufreq_probe(void)
> +{
> +	struct cpufreq_compat *cc;
> +	struct device_node *np;
> +
> +	for (cc = bmips_cpufreq_compat; cc->compatible; cc++) {
> +		np = of_find_compatible_node(NULL, "cpu", cc->compatible);
> +		if (np) {
> +			of_node_put(np);
> +			bmips_cpufreq_driver.driver_data = cc;
> +			break;
> +		}
> +	}
> +
> +	/* We hit the guard element of the array. No compatible CPU found. */
> +	if (!cc->compatible)
> +		return -ENODEV;
> +
> +	return cpufreq_register_driver(&bmips_cpufreq_driver);
> +}
> +device_initcall(bmips_cpufreq_probe);
> +
> +MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
> +MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
> +MODULE_LICENSE("GPL");
> -- 
> 2.7.4

-- 
viresh
