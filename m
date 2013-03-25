Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 06:19:13 +0100 (CET)
Received: from mail-oa0-f43.google.com ([209.85.219.43]:52265 "EHLO
        mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825880Ab3CYFTMHGvR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Mar 2013 06:19:12 +0100
Received: by mail-oa0-f43.google.com with SMTP id l10so5998180oag.2
        for <linux-mips@linux-mips.org>; Sun, 24 Mar 2013 22:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=VxQSITry7NHprUgRg5qKnAglUv7A0K10IxqNK7dUtqU=;
        b=husDCNZEazKr2cnPpBhvpBS6lwwERF+Mr22QESQYTdj5MBVMSqx3vO33eGKZsMVhqS
         SKBsZCVtbSqHZYbPa78S3TUrFfPiCI/V6ZVCqntjDDtG+IXWULDLyWNr5lfQ7JLmoor9
         d5gIJE0Idx+owuAJmwU+WCSeR537p0OjKKXSB83cH1PhnsJGHCyPGwGQb6YEUyyAwSQs
         nFTACpf2eINUJ0aU5PJii4gOk3ipwP5odqOv+Eo7NYj6xNagI8Dy5WkkcnxV7UKxKC2G
         fJ3GDsZjzwhSF3SwCvW2ynR4MgFhAi1u3hEEdp5GfBBpTrgs1LyWIWUfJRd8fVHUaOXB
         ixLg==
MIME-Version: 1.0
X-Received: by 10.60.22.34 with SMTP id a2mr9757397oef.97.1364188745400; Sun,
 24 Mar 2013 22:19:05 -0700 (PDT)
Received: by 10.182.52.198 with HTTP; Sun, 24 Mar 2013 22:19:05 -0700 (PDT)
In-Reply-To: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
Date:   Mon, 25 Mar 2013 10:49:05 +0530
Message-ID: <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rjw@sisk.pl
Cc:     cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arvind.chauhan@arm.com,
        robin.randhawa@arm.com, Steve.Bannister@arm.com,
        Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
        linaro-kernel@lists.linaro.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Renninger <trenn@suse.de>,
        Borislav Petkov <bp@alien8.de>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        cbe-oss-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQn04YbnqWKwNtkCVwQhFJRhVShue6LBXeJFbxSDZqR3Cl+GA0YyraHUrkVtT1Iy+iFiy9VF
X-archive-position: 35972
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> policy->cpus contains all online cpus that have single shared clock line. And
> their frequencies are always updated together.
>
> Many SMP system's cpufreq drivers take care of this in individual drivers but
> the best place for this code is in cpufreq core.
>
> This patch modifies cpufreq_notify_transition() to notify frequency change for
> all cpus in policy->cpus and hence updates all users of this API.

Another fixup for tegra:

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 3b441d6..11ca730 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -106,7 +106,8 @@ out:
        return ret;
 }

-static int tegra_update_cpu_speed(unsigned long rate)
+static int tegra_update_cpu_speed(struct cpufreq_policy *policy,
+               unsigned long rate)
 {
        int ret = 0;
        struct cpufreq_freqs freqs;
@@ -179,7 +180,7 @@ static int tegra_target(struct cpufreq_policy *policy,

        target_cpu_speed[policy->cpu] = freq;

-       ret = tegra_update_cpu_speed(tegra_cpu_highest_speed());
+       ret = tegra_update_cpu_speed(policy, tegra_cpu_highest_speed());

 out:
        mutex_unlock(&tegra_cpu_lock);
@@ -191,10 +192,12 @@ static int tegra_pm_notify(struct notifier_block
*nb, unsigned long event,
 {
        mutex_lock(&tegra_cpu_lock);
        if (event == PM_SUSPEND_PREPARE) {
+               struct cpufreq_policy *policy = cpufreq_cpu_get(0);
                is_suspended = true;
                pr_info("Tegra cpufreq suspend: setting frequency to %d kHz\n",
                        freq_table[0].frequency);
-               tegra_update_cpu_speed(freq_table[0].frequency);
+               tegra_update_cpu_speed(policy, freq_table[0].frequency);
+               cpufreq_cpu_put(policy);
        } else if (event == PM_POST_SUSPEND) {
                is_suspended = false;
        }
