Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Mar 2013 15:54:48 +0100 (CET)
Received: from hydra.sisk.pl ([212.160.235.94]:43455 "EHLO hydra.sisk.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab3CXOyrxEbhg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Mar 2013 15:54:47 +0100
Received: from vostro.rjw.lan (afcg217.neoplus.adsl.tpnet.pl [95.49.58.217])
        by hydra.sisk.pl (Postfix) with ESMTPSA id AA2D3E52B5;
        Sun, 24 Mar 2013 15:53:30 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@sisk.pl>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Francesco Lavra <francescolavra.fl@gmail.com>, Fengguang Wu <fengguang.wu@intel.com>, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Liviu.Dudau@arm.com, sparclinux@vger.kernel.org, linaro-kernel@lists.linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, arvind.chauhan@arm.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jesper Nilsson <jesper.nilsson@axis.com>, robin.randhawa@arm.com, Stephen Warren <swarren@wwwdotorg.org>, cpufreq@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, cbe-oss-dev@lists.ozlabs.org, Fenghua Yu <fenghua.yu@intel.com>, Steve.Bannister@arm.com, Mike Frysinger <vapier@gentoo.org>, linux-pm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mikael Starvik <starvik@axis.com>, Kukjin Kim <kgene.kim@samsung.com>, Borislav Petkov <bp@alien8.de>, Ben Dooks <ben-linux@fluff.org>, Thomas Renninger <trenn@suse.de>, linux-arm-k
 ernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Sascha Hauer <kernel@pengutronix.de>, charles.garcia-tobin@arm.com, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
Date:   Sun, 24 Mar 2013 16:02:05 +0100
Message-ID: <2484099.i284xF0hri@vostro.rjw.lan>
User-Agent: KMail/4.9.5 (Linux/3.9.0-rc3+; KDE/4.9.5; x86_64; ; )
In-Reply-To: <CAKohpomznLtxYZYx31xg+V5FesNiMwOqNDN0QNqOqUw_7g4Uhw@mail.gmail.com>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org> <514F0FB0.8030109@gmail.com> <CAKohpomznLtxYZYx31xg+V5FesNiMwOqNDN0QNqOqUw_7g4Uhw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 35969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
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

On Sunday, March 24, 2013 08:23:27 PM Viresh Kumar wrote:
> On 24 March 2013 20:07, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
> > On 03/24/2013 02:48 PM, Viresh Kumar wrote:
> >> policy->cpus contains all online cpus that have single shared clock line. And
> >> their frequencies are always updated together.
> >>
> >> Many SMP system's cpufreq drivers take care of this in individual drivers but
> >> the best place for this code is in cpufreq core.
> >>
> >> This patch modifies cpufreq_notify_transition() to notify frequency change for
> >> all cpus in policy->cpus and hence updates all users of this API.
> 
> One thing about this work. I compiled it for ARM and Intel. Also this
> stuff is tested
> by "Fengguang Wu" <fengguang.wu@intel.com> automated build system.
> 
> I am not sure if that builds all architectures or not.
> I tried to review my patch closely but their can be some minor mistakes.
> 
> I thought of adding this in the patch details but forgot at last.
> 
> Is their a simple way to compile stuff for all platforms? Sorry i am
> not aware of
> it :(
> 
> >> diff --git a/arch/blackfin/mach-common/cpufreq.c b/arch/blackfin/mach-common/cpufreq.c
> >> +     ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
> >> +     if (ret != 0) {
> >> +             WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
> >> +             break;
> >
> > This doesn't even compile, as the break statement isn't in the
> > for_each_online_cpu() loop anymore.
> 
> I tried to review it very carefully but this situation was a bit tricky :)
> Thanks for trying it out.
> 
> Following should fix it for you:
> 
> commit 942ca8a6bc87e3c42beabc9102755136493e5355
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Sun Mar 24 20:21:43 2013 +0530
> 
>     fixup! cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
> ---
>  arch/blackfin/mach-common/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/blackfin/mach-common/cpufreq.c
> b/arch/blackfin/mach-common/cpufreq.c
> index 4e67368..995511e80 100644
> --- a/arch/blackfin/mach-common/cpufreq.c
> +++ b/arch/blackfin/mach-common/cpufreq.c
> @@ -164,7 +164,7 @@ static int bfin_target(struct cpufreq_policy *policy,
>         ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
>         if (ret != 0) {
>                 WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
> -               break;
> +               return ret;
>         }
>  #endif
>         on_each_cpu(bfin_adjust_core_timer, &index, 1);
> 
> 
> @Rafael: Let me add fixups for now, i will send final patch later after others
> also review their part.

OK


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
