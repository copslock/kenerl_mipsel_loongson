Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 18:45:18 +0100 (CET)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:34565
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeAERpLku8h8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 18:45:11 +0100
Received: by mail-io0-x242.google.com with SMTP id q188so6533290iod.1
        for <linux-mips@linux-mips.org>; Fri, 05 Jan 2018 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0bXZlM0SPuFKG+7olLCEPnP4xvMqfK3EKaLkzizPEXk=;
        b=dnJw9ZkSoFP7bIKHlj3A72pcPKUpHj9ZJ5om+xrzCd5TuiNREyUIJTkmvkg/gLG7xJ
         eVMlr2vHGsFeFKgVFo+Um3WECJ+n2PiEBNQ6cIqRYMXD6umWGBZszAxFT6N51qKveve/
         3YXVjArTCnYd5S6J0LOU+Tso4eKhw3xey5uqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0bXZlM0SPuFKG+7olLCEPnP4xvMqfK3EKaLkzizPEXk=;
        b=BGxmF1EBHsCaowlIfMM1U7SEF+fbmYFxj6DaUkvLjsggKY0eMNzq3AmAM+tinAItS3
         oZo8FFSlc/L8fXkq5VYef056LCGPij0hgufi7eDYx82MAJxFQyiDaTgCwKYo9IoXzJ0q
         1XhqKDj1TlE6hwtwyXA1u0yO2/4mxZrZLX3Gns62uie14eCUIcZTfWAQqLV+uKSb0G4t
         sVvN+kfmUy3qNvc1oEJFinZok7ZaBA8vU3IZyxxA4hZgYiaGds8Ew8Xs8mAUXjElgXYG
         uO1pxFBkt0nzCgqrXF1mSkFa0i2EjcvqO+0vIzrHeczyoIYb/SNbbB18fxl8XEHFaxF0
         a2tg==
X-Gm-Message-State: AKGB3mJlqeO6Qrd6jB8hgvu5LaXfoMrxU03+znT2AypNaNfNf4O2qXQV
        9Dl9AgHFochQ+dox8vu7Dkll94xVrdJFIFNDc2Eo0Q==
X-Google-Smtp-Source: ACJfBosWuyq4nNq7mB11SquUi6sadV+TSlRCzsIGUu+H8XBxpOEdBgC4wG92Y/uRgN6kCJ/3H9nOlCOIVk/fSjgQ6IQ=
X-Received: by 10.107.11.86 with SMTP id v83mr3948066ioi.248.1515174305264;
 Fri, 05 Jan 2018 09:45:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.37.197 with HTTP; Fri, 5 Jan 2018 09:45:04 -0800 (PST)
In-Reply-To: <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-6-ard.biesheuvel@linaro.org> <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Jan 2018 17:45:04 +0000
Message-ID: <CAKv+Gu_1i_8zpYd3UXOLR-AnKNSEVKHGoZxzyNgn=Y46Ghq7iA@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] PCI: Add support for relative addressing in
 quirk tables
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <james.l.morris@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Garnier <thgarnie@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On 5 January 2018 at 17:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Jan 02, 2018 at 08:05:44PM +0000, Ard Biesheuvel wrote:
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 10684b17d0bd..b6d51b4d5ce1 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3556,9 +3556,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>>                    f->vendor == (u16) PCI_ANY_ID) &&
>>                   (f->device == dev->device ||
>>                    f->device == (u16) PCI_ANY_ID)) {
>> -                     calltime = fixup_debug_start(dev, f->hook);
>> -                     f->hook(dev);
>> -                     fixup_debug_report(dev, calltime, f->hook);
>> +                     void (*hook)(struct pci_dev *dev);
>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> +                     hook = (void *)((unsigned long)&f->hook_offset +
>> +                                     f->hook_offset);
>> +#else
>> +                     hook = f->hook;
>> +#endif
>
> More of a nitpick but I've seen this pattern in several places in your
> code, maybe worth defining a macro (couldn't come up with a better
> name):
>
> #define offset_to_ptr(off) \
>         ((void *)((unsigned long)&(off) + (off)))
>

Yeah, good point. Or even

static inline void *offset_to_ptr(const s32 *off)
{
    return (void *)((unsigned long)off + *off);
}
