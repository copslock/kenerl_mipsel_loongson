Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2014 21:41:16 +0200 (CEST)
Received: from mail-qc0-f176.google.com ([209.85.216.176]:46920 "EHLO
        mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861307AbaGGTlOZO0BR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2014 21:41:14 +0200
Received: by mail-qc0-f176.google.com with SMTP id w7so4404436qcr.35
        for <linux-mips@linux-mips.org>; Mon, 07 Jul 2014 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YoRZN+7veR1yEKjpGXgnJFamm3ftqaxL7Fi1dabT0Zs=;
        b=lgZhYaKcmojg5jD1OXgtpVTsfdHUXNTH5v3rHT0OPZteG9BlN6J81FtKo1mehaSxeB
         gpJJ5jitFqJPETwhpvgaBEP7tS7AOb26gyjAgzyv1JczPJVm7h3cvAAZpD9ufrh+aXwb
         QhdDT8vQVLVcG1l9QWbR1WsNn/2shEEnXeA+PU3EggQcNVrXR5h0a7CWeGB3zIUN1zT2
         JqkG8S653emw4Vu0+XJCGuTg6wC5rnyv000imUAmf2B0Co9uSWSB0eCVZFGwkDY/fHJz
         W7WtKd5KlVfVgb8g5Fd3GMdLTZvv2YHi85CXbuGmyVhv5SXKqs6JqT/1qo0XnerX6dVy
         XUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YoRZN+7veR1yEKjpGXgnJFamm3ftqaxL7Fi1dabT0Zs=;
        b=BMOcWuh66Y5RaGLKZ4Mzk5THybdbUG8v9c6G1x33SgpPh2juet6NkgUANPur49Cqzg
         bAMvLF2JtvhyuspnfiSxlvSsa0C9Ws/P0roztRmKww++4m6lBTMGP30BiuT8pVORHoKH
         qYBKZDey0XcBqihuRN4Trvb2ONm5I5ZM9nouDOXv/bbmu5kOmg02Z7Y+qF2XPmi8rvp7
         JPCHnbN4yviHjz45fEt6RR3Fupyo1Cev93H5b8vxfmluMj1O7rGYkmxUE9Fz4qbSaPOf
         drX9VTHChIaJSdoAJqSxTZ3HCsDa+W3j3GRdrcNPbNw71ZVWVesvlp+fIrUusQoTKOd7
         KW2w==
X-Gm-Message-State: ALoCoQk/fYa3kjucy1gJ3RMGz64cCio8WIPCN6v076AUrmc5JkN9aoqimCTX/04lAbEf/Tz1SW5i
X-Received: by 10.140.51.175 with SMTP id u44mr48586315qga.69.1404762068594;
 Mon, 07 Jul 2014 12:41:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.17.198 with HTTP; Mon, 7 Jul 2014 12:40:48 -0700 (PDT)
In-Reply-To: <20140704085741.GA12247@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com> <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com> <20140704085741.GA12247@dhcp-26-207.brq.redhat.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 7 Jul 2014 13:40:48 -0600
Message-ID: <CAErSpo6f6RXWv0DEtLBZX0jXoSUYJeWrSm7mubSJ_F-O7tQp6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
        xen-devel@lists.xenproject.org,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41068
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

On Fri, Jul 4, 2014 at 2:57 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Wed, Jul 02, 2014 at 02:22:01PM -0600, Bjorn Helgaas wrote:
>> On Tue, Jun 10, 2014 at 03:10:30PM +0200, Alexander Gordeev wrote:
>> > There are PCI devices that require a particular value written
>> > to the Multiple Message Enable (MME) register while aligned on
>> > power of 2 boundary value of actually used MSI vectors 'nvec'
>> > is a lesser of that MME value:
>> >
>> >     roundup_pow_of_two(nvec) < 'Multiple Message Enable'
>> >
>> > However the existing pci_enable_msi_block() interface is not
>> > able to configure such devices, since the value written to the
>> > MME register is calculated from the number of requested MSIs
>> > 'nvec':
>> >
>> >     'Multiple Message Enable' = roundup_pow_of_two(nvec)
>>
>> For MSI, software learns how many vectors a device requests by reading
>> the Multiple Message Capable (MMC) field.  This field is encoded, so a
>> device can only request 1, 2, 4, 8, etc., vectors.  It's impossible
>> for a device to request 3 vectors; it would have to round up that up
>> to a power of two and request 4 vectors.
>>
>> Software writes similarly encoded values to MME to tell the device how
>> many vectors have been allocated for its use.  For example, it's
>> impossible to tell the device that it can use 3 vectors; the OS has to
>> round that up and tell the device it can use 4 vectors.
>
> Nod.
>
>> So if I understand correctly, the point of this series is to take
>> advantage of device-specific knowledge, e.g., the device requests 4
>> vectors via MMC, but we "know" the device is only capable of using 3.
>> Moreover, we tell the device via MME that 4 vectors are available, but
>> we've only actually set up 3 of them.
>
> Exactly.
>
>> This makes me uneasy because we're lying to the device, and the device
>> is perfectly within spec to use all 4 of those vectors.  If anything
>> changes the number of vectors the device uses (new device revision,
>> firmware upgrade, etc.), this is liable to break.
>
> If a device committed via non-MSI specific means to send only 3 vectors
> out of 4 available why should we expect it to send 4? The probability of
> a firmware sending 4/4 vectors in this case is equal to the probability
> of sending 5/4 or 16/4, with the very same reason - a bug in the firmware.
> Moreover, even vector 4/4 would be unexpected by the device driver, though
> it is perfectly within the spec.
>
> As of new device revision or firmware update etc. - it is just yet another
> case of device driver vs the firmware match/mismatch. Not including this
> change does not help here at all IMHO.
>
>> Can you quantify the benefit of this?  Can't a device already use
>> MSI-X to request exactly the number of vectors it can use?  (I know
>
> A Intel AHCI chipset requires 16 vectors written to MME while advertises
> (via AHCI registers) and uses only 6. Even attempt to init 8 vectors results
> in device's fallback to 1 (!).

Is the fact that it uses only 6 vectors documented in the public spec?

Is this a chipset erratum?  Are there newer versions of the chipset
that fix this, e.g., by requesting 8 vectors and using 6, or by also
supporting MSI-X?

I know this conserves vector numbers.  What does that mean in real
user-visible terms?  Are there systems that won't boot because of this
issue, and this patch fixes them?  Does it enable bigger
configurations, e.g., more I/O devices, than before?

Do you know how Windows handles this?  Does it have a similar interface?

As you can tell, I'm a little skeptical about this.  It's a fairly big
change, it affects the arch interface, it seems to be targeted for
only a single chipset (though it's widely used), and we already
support a standard solution (MSI-X, reducing the number of vectors
requested, or even operating with 1 vector).

Bjorn
