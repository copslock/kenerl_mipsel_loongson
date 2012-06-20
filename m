Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 08:37:09 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:53373 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903609Ab2FTGhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 08:37:00 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5K6aj3i013847
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 19 Jun 2012 23:36:45 -0700 (PDT)
Received: from localhost (128.224.162.203) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Tue, 19 Jun
 2012 23:36:45 -0700
Date:   Wed, 20 Jun 2012 14:36:42 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH V2 15/16] MIPS: Loongson 3: Add CPU Hotplug support.
Message-ID: <20120620063642.GA8544@windriver.com>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
 <1340088624-25550-16-git-send-email-chenhc@lemote.com>
 <20120619093113.GB305@windriver.com>
 <CAAhV-H5cErPcKYV1Onc-b5S4qRunKbwZOACe2B8NLF0af6TrZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5cErPcKYV1Onc-b5S4qRunKbwZOACe2B8NLF0af6TrZQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.162.203]
X-archive-position: 33733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
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

On Tue, Jun 19, 2012 at 06:51:07PM +0800, Huacai Chen wrote:
> On Tue, Jun 19, 2012 at 5:31 PM, Yong Zhang <yong.zhang@windriver.com> wrote:
> > On Tue, Jun 19, 2012 at 02:50:23PM +0800, Huacai Chen wrote:
> >> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> >> index e9a5fd7..69b17a9 100644
> >> --- a/arch/mips/kernel/process.c
> >> +++ b/arch/mips/kernel/process.c
> >> @@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
> >> ? ? ? ? ? ? ? ? ? ? ? }
> >> ? ? ? ? ? ? ? }
> >> ?#ifdef CONFIG_HOTPLUG_CPU
> >> - ? ? ? ? ? ? if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
> >> - ? ? ? ? ? ? ? ? (system_state == SYSTEM_RUNNING ||
> >> - ? ? ? ? ? ? ? ? ?system_state == SYSTEM_BOOTING))
> >> + ? ? ? ? ? ? if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
> >> ? ? ? ? ? ? ? ? ? ? ? play_dead();
> >
> > I think patch like this should be separated from BSP code.
> >
> > BTW, what's the story behind this change?
> When poweroff, disable_nonboot_cpus() is called, and if HOTPLUG_CPU is
> configured, disable_nonboot_cpus() is not an empty function but try to
> offline nonboot cores. If without this change, poweroff fails.

Yeah. It's an issue. I think Cavium is also affected (Cc'ing David).

So mind making this a single patch? We should also send it to -stable IMHO.

Thanks,
Yong
