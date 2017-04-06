Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 10:49:12 +0200 (CEST)
Received: from mga06.intel.com ([134.134.136.31]:32360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbdDFItEL3bHK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Apr 2017 10:49:04 +0200
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 01:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,283,1488873600"; 
   d="scan'208";a="842574461"
Received: from jnikula-mobl.fi.intel.com (HELO localhost) ([10.237.72.162])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2017 01:48:49 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jes Sorensen <jes@trained-monkey.org>,
        Jiri Slaby <jslaby@suse.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Jarod Wilson <jarod@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Antonio Quartulli <a@unstable.cc>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kejian Yan <yankejian@huawei.com>,
        Daode Huang <huangdaode@hisilicon.com>,
        Qianqian Xie <xieqianqian@huawei.com>,
        Philippe Reynes <tremyfr@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Jason Litzinger <jlitzingerdev@gmail.com>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        linux-hippi@sunsite.dk, devel@driverdev.osuosl.org,
        kernel@stlinux.com, linux-serial@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] format-security: move static strings to const
In-Reply-To: <20170405214711.GA5711@beast>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20170405214711.GA5711@beast>
Date:   Thu, 06 Apr 2017 11:48:48 +0300
Message-ID: <87mvbtzztb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jani.nikula@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jani.nikula@linux.intel.com
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

On Thu, 06 Apr 2017, Kees Cook <keescook@chromium.org> wrote:
> While examining output from trial builds with -Wformat-security enabled,
> many strings were found that should be defined as "const", or as a char
> array instead of char pointer. This makes some static analysis easier,
> by producing fewer false positives.
>
> As these are all trivial changes, it seemed best to put them all in
> a single patch rather than chopping them up per maintainer.

> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index f6d4d9700734..1ff9d5912b83 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2331,7 +2331,7 @@ EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
>  int __init drm_fb_helper_modinit(void)
>  {
>  #if defined(CONFIG_FRAMEBUFFER_CONSOLE_MODULE) && !defined(CONFIG_EXPERT)
> -	const char *name = "fbcon";
> +	const char name[] = "fbcon";

I'd always write the former out of habit. Why should I start using the
latter? What makes it better?

What keeps the kernel from accumulating tons more of the former?

Here's an interesting comparison of the generated code. I'm a bit
surprised by what gcc does, I would have expected no difference, like
clang. https://godbolt.org/g/OdqUvN

The other changes adding const in this patch are, of course, good.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
