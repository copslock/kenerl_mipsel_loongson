Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 23:46:52 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:39792 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2HQVqr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 23:46:47 +0200
Received: by ghbf20 with SMTP id f20so4723004ghb.36
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2012 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=JHk0tx2BrnmiWkt9Wyt8EmI5ts93Qlctl2WzL9Ve/Mo=;
        b=KS88xAgpLtBpV8kvUhVpto4IjXlLg4jXwkqvN0DpHd/oZ/vCjz9lToZL5thOK1+UWI
         i9Eq+8FQ2hmgKjPqR+bTeoGoVlMclww2Ac8nt87XiT8khZkqnnMz6dYED/uCYC0U5byq
         w4ROGKhPKRW/+tp9Sdc3x2MheVD+DtDpWOEG3QolqSdKz8Djx5I3/U44mFHNq0oWstum
         lbjmYYLtDvnaURoSA13ldMTK9NfPpMyJXdIZzyzVJLC04SIv5//gjqNGLlbFqOTvrx30
         0XiPGIRXGUP/ZBljL9fEDmQixfi84Q22nVShf/rpuK9ns9A4G0+CiURlusH2NKlF2tZj
         6LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=JHk0tx2BrnmiWkt9Wyt8EmI5ts93Qlctl2WzL9Ve/Mo=;
        b=E8Xt7VBGDjOSvIWFiWIkm9lg3fmcgSvbfe9YNtI4D1QGMhBIdIPPjXlPBGMhlgbbHD
         fbZ81ZgMQcZLR/1bfx0MpaIAymqrTqcUufrnxGfAnhuo0r9yci3abkv9uUQf0hHNg0fU
         IemLh+CFM+WibaNvMnF3/IjMumTMd2Ro3gZYBukxRhyHE7XXLDlwavJNhuHPDENFtlpg
         earAka6aJEUTZK+J8N5xh1SKal5MItI4Qs/yjLzHIXuXWx80z1WQKJBU+9/o4AH6Y3fc
         xo385C6Hmx5vE8F+/Oem1TJlEcotJlAoYCFzOTIseAlZ3lb0dmldqi+rVsryhKl+kFCP
         BeaA==
Received: by 10.50.189.134 with SMTP id gi6mr3315904igc.55.1345240001327;
        Fri, 17 Aug 2012 14:46:41 -0700 (PDT)
Received: by 10.50.189.134 with SMTP id gi6mr3315892igc.55.1345240001136; Fri,
 17 Aug 2012 14:46:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.26.99 with HTTP; Fri, 17 Aug 2012 14:46:20 -0700 (PDT)
In-Reply-To: <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com> <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 17 Aug 2012 15:46:20 -0600
Message-ID: <CAErSpo7D8HSKQ7o9peWBE6e30UcYOBj8KTEENzyxhTNKSUmYWg@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQl3Lag9b0lZp9MjcBWsm67aJZghVa8UhkUctYMbVNyqw4lObZHZ1BRE6U1z2ZstI6vPwEZB/EYbMZ0o1okCHJqVZBRG5cqhya4wpurv+DnyouIWKAVxDnUKlL3PNdW8+GRbZYl+FBCgRnksLipQ8geBTR6ZKl7MZb6aWBShibXaECRpd4D+DbMicPjk031/6HynlDLeVJSR/H7sw5nqB/Yzo8jQ3A==
X-archive-position: 34268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Fri, Aug 17, 2012 at 3:32 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
>> On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
>> >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
>> > [...]
>> >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
>> >> > affect you?  I think we would still have to change some __inits to
>> >> > __devinit, including pcibios_update_irq(), but it might be more
>> >> > manageable.
>> >>
>> >> You said that depending on HOTPLUG wouldn't be enough because it would
>> >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
>> >> theoretically possible to build a kernel without HOTPLUG but have the
>> >> enumeration start after init because of deferred probing. Those cases
>> >> won't work if we keep __init or __devinit respectively, right?
>> >
>> > Another possibility would be to make PCI select HOTPLUG or depend on it.
>> > That way it would be made sure that __devinit wouldn't cause all the
>> > functions to be discarded after init.
>>
>> There's been some discussion recently about whether CONFIG_HOTPLUG is
>> worth keeping any more, but nothing's been resolved yet.  If we did
>> decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
>> just remove all the __devinit annotations because they'd be
>> superfluous.
>
> I've missed that discussion. Can you point me to it?

Sure: http://lists.linux-foundation.org/pipermail/ksummit-2012-discuss/2012-June/000051.html

>From previous email:
>> This is the situation (deferred probing with CONFIG_HOTPLUG=n) that
>> I'm suggesting might not need to work.  After all, hotplug essentially
>> means "adding devices after init."

> Yes, I guess that would be appropriate. However I don't see how this
> could be expressed in Kconfig unless the deferred probing itself is
> conditionalized on HOTPLUG. Even in that case it would still be possible
> to build a PCIe controller driver as a module and load it at runtime
> after init.

That's exactly it -- the deferred probing and any loadable PCI host
bridge drivers would have to depend on HOTPLUG.  That seems like the
most straightforward, least-surprises, approach for now.

Bjorn
