Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 10:45:00 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:49946 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010552AbcA0Jo6iJYwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 10:44:58 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0MejLU-1aiDss3P8S-00OIXy; Wed, 27 Jan
 2016 10:44:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date:   Wed, 27 Jan 2016 10:44:01 +0100
Message-ID: <3596300.IYfzmako0c@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20160127093018.GA21190@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <1947556.38OyJnvGS5@wuerfel> <20160127093018.GA21190@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:u4p4Pn+2jwn6DxtCQoFN3pLaHSLpaNJBmRAWcTAdeCcO3DbULq8
 dz4kMkPg2p+Z9XYsDf1h2ay+fPvMUHefuZf8CdxtUGMulO7s+6kUUeNiXgjRhV3o4Tbwcs1
 /DVI/jqPxeXo3jds3+6nom0eX4a0OU4Q4YrNRwLAijwWK6avuBvxIYlc5MoSG/KvPR7tPk5
 RNYvMJK0naE27siC79KZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+W4xYvSEUR4=:TQPqYcTNjAU1OT3I6ybNI2
 paEbE+Qx5OXARdxoNwcI2B+Yx89ocC/SogSXJx278QdpqUhf2Tltpx5C3axX4DDMHWGv4tAh5
 VCU2tuc8s8M6pi73Qq7J9nRKAA0yyGLIeHIKsCbvyTc54010v6C8ODqus6qHz3goXtrzPKecm
 QuZCL6Yqp0Yl6dwBXPxbDAFlk7xP6b1pR8D3npq8pP8Csmxag3ghBn1XOJjv3SyLPQ5UD6LHO
 iOY72KVkyem12L7qXkKmj8MnsoSGc8Ndu//bXdC35OsZ4z63Cvel5PCn4qkz2BH+/3auPxsUl
 IQiEhfTBPcBOEiqNlXNpCat+NDAWS4pro4Nn/4h+lfR4KbtXMzOgqI/Pl+qdE68cn6hkPqW+C
 oJ6RZ+AiC7/xUHl1p8tlTHgPkhYUCSNaqrNvRKFbo/FArmMRdSvk8HqAwca3I/m+FncKfBBA4
 7CywovTyJeFIZzrP1Y2b4nRvGeDyoi2QSXiFkkyIKEowlKIqL37vnMwgNjguk+QB2gL4pLedr
 JVf5Okp0uMITP0ErDBVN+zo3e4jkhsUB9RDO7/YzkghG0+V8ZBqW76FcSCWgzDzYTaQe1a5cA
 DlIFVx7FodrEET5RjbvJKP720lGXhVqqnGWGoEuagDhpZxptBBhgUCj8a27FKlPHEfxkbBRPu
 4xnRNTnpQAQ76hJUFUUUEi/CWkHr7jOI2wBuiUThNgE1/p+tYimtPxNGyPSGp6lW9wP7IWxEO
 06p7DFTVWLz0pcQA
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 27 January 2016 17:30:18 Fengguang Wu wrote:

> > Looks good, I'm just unsure about "multi_v8_defconfig", this does not
> > exist. Do you mean multi_v5_defconfig?

> Ah yes, multi_v8_defconfig does not exist actually.

Ok, can you include multi_v5_defconfig than?

I see you have one named "arm-arm5", which may be the same.

> > I also wonder if you include 'randconfig' builds for some architectures.
> > I have patches for all remaining errors and warnings that I see with
> > ARM randconfig builds today. Not all of them are merged yet, but I could
> > probably come up with a file to be used as input to KCONFIG_ALLCONFIG
> > to eliminate the known-broken configurations, if you are interested.
> 
> If the are mostly ready for upstream, it may be easier to wait until
> upstream randconfig works just fine for ARM.

I have around 130 patches for warnings that I'm submitting at the moment, but
there are a couple of really tricky ones that I don't currently have
a good plan for:

- in some configurations, you end up without any boards selected, hitting
  an #error in the final link
- ARMv3 support in gcc is rather broken and causes internal compiler errors
  among other things
- the old ELF format (OABI) doesn't work in some cases
- GCOV_PROFILE_ALL causes problems that need to be debugged
- XIP_KERNEL sometimes causes kallsyms to fail
- not all platforms implement the complete clk API, if they don't
  use CONFIG_COMMON_CLK (I have patch for that we can probably merge)
- CONFIG_PHYS_OFFSET needs to be entered manually to be a number
  in 'make config'
- same for DEBUG_LL

	Arnd
