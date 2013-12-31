Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 16:43:21 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:47726 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378Ab3LaPnTgtlb0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Dec 2013 16:43:19 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vy1TP-0002Xz-6s; Tue, 31 Dec 2013 16:43:15 +0100
Date:   Tue, 31 Dec 2013 16:43:15 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 02/12] MIPS: Loongson: Add basic Loongson-3 CPU
 support
Message-ID: <20131231154315.GE9794@hall.aurel32.net>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-3-git-send-email-chenhc@lemote.com>
 <20131230213354.GA20586@hall.aurel32.net>
 <20131231151751.GB7429@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20131231151751.GB7429@blackmetal.musicnaut.iki.fi>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Tue, Dec 31, 2013 at 05:17:51PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Dec 30, 2013 at 10:33:54PM +0100, Aurelien Jarno wrote:
> > >  		switch (c->processor_id & PRID_REV_MASK) {
> > >  		case PRID_REV_LOONGSON2E:
> > > +			c->cputype = CPU_LOONGSON2;
> > > +			__cpu_name[cpu] = "ICT Loongson-2E";
> > >  			set_elf_platform(cpu, "loongson2e");
> > >  			break;
> > >  		case PRID_REV_LOONGSON2F:
> > > +			c->cputype = CPU_LOONGSON2;
> > > +			__cpu_name[cpu] = "ICT Loongson-2F";
> > >  			set_elf_platform(cpu, "loongson2f");
> > 
> > I have mixed feelings about the Loongson-2 name change. On one side it's
> > clearly better to have 2E and 2F instead of 2 V0.2 and 2 V0.3, and it
> > should have been like that since the beginning. That said changing that
> > now is kind of breaking the userland. I know that it would break debian
> > installer support for example, though that should not be a real problem
> > as we ship the installer with a given kernel version. I don't know if
> > there are other usages that can cause a problem. Any opinion from
> > others?
> 
> Changing it would break also GCC's -march=native detection. So NACK.

Indeed, good catch. That said it already looks for both Godson2 and
Loongson-2, so I guess such a patch is acceptable if someone updates GCC
and waits a few years before submitting it again.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
