Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 16:32:57 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:44258 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2HUOcv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 16:32:51 +0200
Received: by vbbfo1 with SMTP id fo1so7055694vbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WdDpmWNBQok8gDEdQ3IqOjm4hZGBxtMrFvODpButr1U=;
        b=J+F6N8k+39m2j034HwEGuE4/f6m9tmbfVEmkAu7EA2EaqW5vWWXmMrn3HyXYwbHYV9
         gPvtqLIYRD0TQ36zPlVdOb4lJClIs4lDjZq/KSxNfkw3/KJ4t0lwvhhi1e54N3tMHWF6
         h9oKydO1AnrT4jiJmAlEhDkHhiea2/5jE5UInEFKUsjsPSNc0b9mYow0eMWUu9cOt+xF
         9jIh4SrzjxUX6ZIll8Gsc3h/chTEnv4b1nCaYlD28XG/wHz5u4AzV/3dKGJe5ZPlryTX
         YZWQDBpaK5cD0/5lfVFaHQhRk7rHl/t0UW4+RsEFNS9qJ/qSvjw57qm96TuNGhHhxflN
         qpAg==
MIME-Version: 1.0
Received: by 10.221.11.71 with SMTP id pd7mr13713501vcb.45.1345559565412; Tue,
 21 Aug 2012 07:32:45 -0700 (PDT)
Received: by 10.220.22.202 with HTTP; Tue, 21 Aug 2012 07:32:45 -0700 (PDT)
In-Reply-To: <20120820053036.GA23166@kroah.com>
References: <502E8115.90507@gmail.com>
        <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
        <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
        <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
        <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
        <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
        <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
        <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
        <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
        <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
        <20120820053036.GA23166@kroah.com>
Date:   Tue, 21 Aug 2012 16:32:45 +0200
X-Google-Sender-Auth: bTg9oyA7vGitvzoMLOUeUCeqHfw
Message-ID: <CAMuHMdWfhATFQrP-ZiMi6Ub3ZbOgUhe7S_fVUzc7zOwDxRNsyw@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@avionic-design.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Greg,

On Mon, Aug 20, 2012 at 7:30 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Aug 17, 2012 at 11:32:47PM +0200, Thierry Reding wrote:
>> On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
>> > On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
>> > <thierry.reding@avionic-design.de> wrote:
>> > > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
>> > >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
>> > > [...]
>> > >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
>> > >> > affect you?  I think we would still have to change some __inits to
>> > >> > __devinit, including pcibios_update_irq(), but it might be more
>> > >> > manageable.
>> > >>
>> > >> You said that depending on HOTPLUG wouldn't be enough because it would
>> > >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
>> > >> theoretically possible to build a kernel without HOTPLUG but have the
>> > >> enumeration start after init because of deferred probing. Those cases
>> > >> won't work if we keep __init or __devinit respectively, right?
>> > >
>> > > Another possibility would be to make PCI select HOTPLUG or depend on it.
>> > > That way it would be made sure that __devinit wouldn't cause all the
>> > > functions to be discarded after init.
>> >
>> > There's been some discussion recently about whether CONFIG_HOTPLUG is
>> > worth keeping any more, but nothing's been resolved yet.  If we did
>> > decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
>> > just remove all the __devinit annotations because they'd be
>> > superfluous.
>>
>> I've missed that discussion. Can you point me to it?
>
> It's pretty much just me saying the whole thing is a mess, causes
> problems, and really doesn't solve any memory usage issues.  Ideally we
> should just:
>         - remove CONFIG_HOTPLUG and assume it is enabled
>         - because of that, we can delete the large majority of the
>           __dev* markings
>
> The memory savings these days are so tiny, if at all, and everyone,
> including me, gets it wrong all the time.
>
> As we pretty much allow anything to be disabled/enabled at any point in
> time after boot, we are all running systems that rely on CONFIG_HOTPLUG
> anyway.  To find a static system that doesn't need it is quite rare from
> what I have found.

Anyone who disables CONFIG_HOTPLUG in his defconfig files?

$ git grep CONFIG_HOTPLUG arch/*/*config
arch/frv/defconfig:# CONFIG_HOTPLUG is not set
arch/h8300/defconfig:# CONFIG_HOTPLUG is not set
arch/um/defconfig:CONFIG_HOTPLUG=y
$

Yep, (at least --- not all defconfigs are up-to-date) frv and h8300.

It seems to be hard, as it's enabled for all non-CONFIG_EXPERT (and
before that non-CONFIG_EMBEDDED) builds since Nov 2005
(full-history-linux commit 712f47cea7703a340406fde61e84eb86ce781988
 "[PATCH] HOTPLUG: always enable the .config option, unless EMBEDDED").

$ git grep CONFIG_EXPERT arch/*/*config
arch/frv/defconfig:CONFIG_EXPERT=y
arch/h8300/defconfig:CONFIG_EXPERT=y
arch/s390/defconfig:CONFIG_EXPERT=y
arch/um/defconfig:# CONFIG_EXPERT is not set
$

The same architectures, plus s390, who used to be an explicit negative
dependency before the commit above.

For a quick test, I enabled CONFIG_EXPERT and disabled CONFIG_HOTPLUG
in my Atari defconfig build, and it saved 168 bytes of code and 112 bytes of
data. Note that Atari doesn't have any hotpluggable hardware, hence no
real hotpluggable drivers.
Anyway, I'll sleep better now ;-)

FWIW, both tile and xtensa have their own duplicates of CONFIG_HOTPLUG:

$ git grep -w 'config HOTPLUG' -- "*Kconf*"
arch/tile/Kconfig:config HOTPLUG
arch/xtensa/Kconfig:config HOTPLUG
init/Kconfig:config HOTPLUG
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
