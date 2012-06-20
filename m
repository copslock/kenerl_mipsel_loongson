Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 08:57:58 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59581 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903673Ab2FTG5x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 08:57:53 +0200
Received: by lbbgg6 with SMTP id gg6so181608lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wd6wgAjDLlFmwRUZE4apeVzgeVY16e/sqTW8idAVC0Y=;
        b=GxdaJfhXmZLdG07CXVG3oJWXrm7cNPCZQFt/qlK/CC2G1hica+N4n7ZuF55x01yFzo
         m5+gx5PFJgXV5ShjsQGuyPBiAl/eu2+Lulg9WXbylBjGHrfQ9WVXXoIt/GSdRIGwxGLs
         ZH2p6usW+rTQws712cmvrdBnnzPtqH+Ph0+AqDQwobz93LfHmsGIXBFz6rGWq6Z3Jclb
         lIHAk3jGXeBOeKej1+g+7caY1OXPjXiACftVayetc0Rz2HhEWl381wc78+j8miLPMYGs
         QaVJkknVE7LztENALH7kVLqSxlyGOwHkp6+wqlxZj7U21BqF/U8FMjCig0mmV67p5aI2
         5BzA==
MIME-Version: 1.0
Received: by 10.152.113.68 with SMTP id iw4mr1387271lab.50.1340175468236; Tue,
 19 Jun 2012 23:57:48 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 23:57:48 -0700 (PDT)
In-Reply-To: <20120620063642.GA8544@windriver.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-16-git-send-email-chenhc@lemote.com>
        <20120619093113.GB305@windriver.com>
        <CAAhV-H5cErPcKYV1Onc-b5S4qRunKbwZOACe2B8NLF0af6TrZQ@mail.gmail.com>
        <20120620063642.GA8544@windriver.com>
Date:   Wed, 20 Jun 2012 14:57:48 +0800
Message-ID: <CAAhV-H7RZoDFYo=4+GajQdOWTjN9w=HfyWdhkXzsO=teuUJdQA@mail.gmail.com>
Subject: Re: [PATCH V2 15/16] MIPS: Loongson 3: Add CPU Hotplug support.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Yong Zhang <yong.zhang@windriver.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

On Wed, Jun 20, 2012 at 2:36 PM, Yong Zhang <yong.zhang@windriver.com> wrote:
> On Tue, Jun 19, 2012 at 06:51:07PM +0800, Huacai Chen wrote:
>> On Tue, Jun 19, 2012 at 5:31 PM, Yong Zhang <yong.zhang@windriver.com> wrote:
>> > On Tue, Jun 19, 2012 at 02:50:23PM +0800, Huacai Chen wrote:
>> >> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> >> index e9a5fd7..69b17a9 100644
>> >> --- a/arch/mips/kernel/process.c
>> >> +++ b/arch/mips/kernel/process.c
>> >> @@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
>> >> ? ? ? ? ? ? ? ? ? ? ? }
>> >> ? ? ? ? ? ? ? }
>> >> ?#ifdef CONFIG_HOTPLUG_CPU
>> >> - ? ? ? ? ? ? if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
>> >> - ? ? ? ? ? ? ? ? (system_state == SYSTEM_RUNNING ||
>> >> - ? ? ? ? ? ? ? ? ?system_state == SYSTEM_BOOTING))
>> >> + ? ? ? ? ? ? if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
>> >> ? ? ? ? ? ? ? ? ? ? ? play_dead();
>> >
>> > I think patch like this should be separated from BSP code.
>> >
>> > BTW, what's the story behind this change?
>> When poweroff, disable_nonboot_cpus() is called, and if HOTPLUG_CPU is
>> configured, disable_nonboot_cpus() is not an empty function but try to
>> offline nonboot cores. If without this change, poweroff fails.
>
> Yeah. It's an issue. I think Cavium is also affected (Cc'ing David).
>
> So mind making this a single patch? We should also send it to -stable IMHO.
>
> Thanks,
> Yong
Ok, wait some time, please.
