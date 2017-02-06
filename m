Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 22:22:16 +0100 (CET)
Received: from mail-wm0-x231.google.com ([IPv6:2a00:1450:400c:c09::231]:35439
        "EHLO mail-wm0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991955AbdBFVWHDflm3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 22:22:07 +0100
Received: by mail-wm0-x231.google.com with SMTP id b65so138332874wmf.0
        for <linux-mips@linux-mips.org>; Mon, 06 Feb 2017 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uh2BidAC2ZjgWzniu1bh40o0jVQzqWTdVyF+/cBm+8Y=;
        b=Kza09Cn1kIATGs67XvkCnKFPkVaDqBhxmewcjKYxAvSxu81zQjr0/f7B5h8yIpjvm+
         aVR3b+YDeFKmrKfSTNdhnxiexCJtjNNTSW9qUjh0UoupWuf1mNQhWRCHxv9MmJNNr0VY
         OhYAV/J8Wo1E6aoAHd2u99mfMyX7fAAdfc5Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uh2BidAC2ZjgWzniu1bh40o0jVQzqWTdVyF+/cBm+8Y=;
        b=j+jq2LzP76+hUtqK+jYlCRAAUuiLFyv7zq/1sK6LshuMToEyzgOG79VJUz4S6dxIAO
         yZAPMGQKgtiMoRR/GW8M16/5yQ2szgtNYlZebAMowKn6cHlLNnNRNsxCfug2At1sn1sZ
         cpe6hFOLgrz9LiBueBAn8pv6HZXcdXAbI+7Ac4uraRVIBYhoXA5Ga1faFFe2LU3qo3JE
         9dQIHkFOlbH+URPbpxwUfoz23C8hBXVh27o0WWrBmQVkxHoKCLkf1LoIjotiUpov3StQ
         dmSkgjTyYxKThXp54OyfzJwljIwdmD/GT14BHTIuLzIKhquPEyktlgkmreLTkqB8NG+u
         uJNg==
X-Gm-Message-State: AIkVDXLDVl0X9pHx8pHT1IPP+9XECWqXSFyA/vJ7u04ULNVp0Wt74nsJZ6ewDZ8fL5A2H7eqpI1LcKQZWkSZ3Aoc
X-Received: by 10.223.169.114 with SMTP id u105mr2206142wrc.173.1486416121303;
 Mon, 06 Feb 2017 13:22:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.152.117 with HTTP; Mon, 6 Feb 2017 13:22:00 -0800 (PST)
In-Reply-To: <20170203042805.GK7458@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net> <20170202010601.75995-3-code@mmayer.net>
 <20170203042805.GK7458@vireshk-i7>
From:   Markus Mayer <markus.mayer@broadcom.com>
Date:   Mon, 6 Feb 2017 13:22:00 -0800
Message-ID: <CAGt4E5sXxGOS=gNSc4Jst2iC=sRAJLQizz7OKBypTTUFRgkPDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's
 BMIPS SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <markus.mayer@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.mayer@broadcom.com
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

On 2 February 2017 at 20:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> You must be a cpufreq driver expert by now. What's the count? Is this the 3rd
> one you have written ? :)

Indeed. This is #3. We should be done now, though. We have ARM, legacy
ARM and BMIPS covered. :-)

> On 01-02-17, 17:06, Markus Mayer wrote:
>> diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
>> +static struct cpufreq_frequency_table *
>> +bmips_cpufreq_get_freq_table(const struct cpufreq_policy *policy)
>
> Maybe call it bmips_cpufreq_create_freq_table() as that's what you are doing.
> But its all up to you only.

I was about to change the name, but then realized that the other two
drivers use *get_freq_table(), too. So, I'd prefer to keep the name as
is, so we don't get naming oddities between various Broadcom cpufreq
drivers.

>> +{
>> +     struct cpufreq_frequency_table *table;
>> +     struct cpufreq_compat *cc;
>> +     unsigned long cpu_freq;
>> +     int i;
>> +
>> +     cc = policy->driver_data;
>> +     cpu_freq = htp_freq_to_cpu_freq(cc->clk_mult);
>> +
>> +     table = kzalloc((cc->max_freqs + 1) * sizeof(*table), GFP_KERNEL);
>
> Maybe kmalloc as you are updating all the entries.

Done.

>> +     if (!table)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     for (i = 0; i < cc->max_freqs; i++) {
>> +             table[i].frequency = cpu_freq / (1 << i);
>> +             table[i].driver_data = i;
>> +     }
>> +     table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +     return table;
>> +}
>> +
>> +static unsigned int bmips_cpufreq_get(unsigned int cpu)
>> +{
>> +     struct cpufreq_policy *policy;
>> +     struct cpufreq_compat *cc;
>> +     unsigned long freq, cpu_freq;
>> +     unsigned int div;
>> +     uint32_t mode;
>> +
>> +     policy = cpufreq_cpu_get(cpu);
>
> You need to do a corresponding cpufreq_cpu_put().

Actually, I don't need the policy at all anymore. I converted to a
global variable (as per suggestion below), which means no more policy
in this function. So, rather than adding cpufreq_cpu_put(), I removed
cpufreq_cpu_get().

>> +     cc = policy->driver_data;
>> +
>> +     switch (cc->bmips_type) {
>> +     case BMIPS5200:
>> +     case BMIPS5000:
>> +             mode = read_c0_brcm_mode();
>> +             div = ((mode >> BMIPS5_CLK_DIV_SHIFT) & BMIPS5_CLK_DIV_MASK);
>> +             break;
>> +     default:
>> +             div = 0;
>> +     }
>> +
>> +     cpu_freq = htp_freq_to_cpu_freq(cc->clk_mult);
>> +     freq = cpu_freq / (1 << div);
>> +
>> +     return freq;
>> +}
>> +
>> +static int bmips_cpufreq_target_index(struct cpufreq_policy *policy,
>> +                                   unsigned int index)
>> +{
>> +     struct cpufreq_compat *cc;
>> +     unsigned int div;
>> +
>> +     cc = policy->driver_data;
>> +     div = policy->freq_table[index].driver_data;
>> +
>> +     switch (cc->bmips_type) {
>> +     case BMIPS5200:
>> +     case BMIPS5000:
>> +             change_c0_brcm_mode(BMIPS5_CLK_DIV_MASK << BMIPS5_CLK_DIV_SHIFT,
>> +                                 (1 << BMIPS5_CLK_DIV_SET_SHIFT) |
>> +                                 (div << BMIPS5_CLK_DIV_SHIFT));
>> +             break;
>> +     default:
>> +             return -ENOTSUPP;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int bmips_cpufreq_exit(struct cpufreq_policy *policy)
>> +{
>> +     kfree(policy->freq_table);
>> +     policy->freq_table = NULL;
>
> No need to set it to NULL.

Removed.

>> +
>> +     return 0;
>> +}
>> +
>> +static int bmips_cpufreq_init(struct cpufreq_policy *policy)
>> +{
>> +     struct cpufreq_frequency_table *freq_table;
>> +     int ret;
>> +
>> +     /* Store the compatibility data with the policy. */
>> +     policy->driver_data = cpufreq_get_driver_data();
>
> Hmm, I wouldn't mind keeping a global variable for this. This driver will be
> probed only once and so we can simplify the code a bit. Up to you.

Done. Got rid of 10 lines of code overall.

>> +
>> +     freq_table = bmips_cpufreq_get_freq_table(policy);
>> +     if (IS_ERR(freq_table)) {
>> +             ret = PTR_ERR(freq_table);
>> +             pr_err("%s: couldn't determine frequency table (%d).\n",
>> +                     BMIPS_CPUFREQ_NAME, ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = cpufreq_generic_init(policy, freq_table, TRANSITION_LATENCY);
>> +     if (ret)
>> +             bmips_cpufreq_exit(policy);
>> +     else
>> +             pr_info("%s: registered\n", BMIPS_CPUFREQ_NAME);
>> +
>> +     return ret;
>> +}
>> +
>> +static struct cpufreq_driver bmips_cpufreq_driver = {
>> +     .flags          = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
>> +     .verify         = cpufreq_generic_frequency_table_verify,
>> +     .target_index   = bmips_cpufreq_target_index,
>> +     .get            = bmips_cpufreq_get,
>> +     .init           = bmips_cpufreq_init,
>> +     .exit           = bmips_cpufreq_exit,
>> +     .attr           = cpufreq_generic_attr,
>> +     .name           = BMIPS_CPUFREQ_PREFIX,
>> +};
>> +
>> +static int __init bmips_cpufreq_probe(void)
>> +{
>> +     struct cpufreq_compat *cc;
>> +     struct device_node *np;
>> +
>> +     for (cc = bmips_cpufreq_compat; cc->compatible; cc++) {
>> +             np = of_find_compatible_node(NULL, "cpu", cc->compatible);
>> +             if (np) {
>> +                     of_node_put(np);
>> +                     bmips_cpufreq_driver.driver_data = cc;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     /* We hit the guard element of the array. No compatible CPU found. */
>> +     if (!cc->compatible)
>> +             return -ENODEV;
>> +
>> +     return cpufreq_register_driver(&bmips_cpufreq_driver);
>> +}
>> +device_initcall(bmips_cpufreq_probe);
>> +
>> +MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
>> +MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.7.4
>
> --
> viresh
