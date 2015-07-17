Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 19:50:32 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36816 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010791AbbGQRuai1Z7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jul 2015 19:50:30 +0200
Received: by wgxm20 with SMTP id m20so87662543wgx.3
        for <linux-mips@linux-mips.org>; Fri, 17 Jul 2015 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nWqtWfHmlMNzefTieAte5HbGcQ4lYrvLfeBYpjuJw4I=;
        b=FXuVNqcrtyfFnuwyR7Ap6lE+ZAjsi8eRRrwa3MrygGmHLIh/Lehfuih4iCaaiAhmJs
         Z/isAKAbkrSAxqAOjViTT9VEDyMPeiyOWLSnD/by1kfzcrsBzZ39E6cBFJlA2ZyFK4AM
         lBMDI4g9cyTsCn92ipbMwul28p5VVn5ZmG7YCKMLd05OwZiUsJ2YlvFxSqgom3WShs6L
         K7EoX9nwconFiF25ChYdqDmtyKaC4+wso2lkazSIu2mSmDwUCL5tSVc6Q8QKiCoooEHR
         l+cpPkGQhuV5HX2oD8Je9lP1lAFRm5TyDgmFUCkDoV0i0r9xcYFVtbdFmv6FkVfQwpnX
         3yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=nWqtWfHmlMNzefTieAte5HbGcQ4lYrvLfeBYpjuJw4I=;
        b=bHd1E4Mg4OawSkwhQvrmkjs8798EEx8ERg0HbU04F+SIFxwixjGux2XWNhstm2vNZj
         tyt97aW2oO4uB5zIfBkzj9jYSwxWiD2AcxESmVvx9ZPtCBgG55+UV3wBKIGfKHtiax7v
         r6lgVuqcAWcZSa2+hzAtdicquAs7MYhQturQ+stZO828ScsT4cDpEPAZWqO0h6NkOQEr
         zYz97fbQKeDWUEvTqoYT2ZyNoJwRM+sFpUs1p/auknYIzgnpP8wJR04h9dDr4g5oz6/Q
         /ybwZ6gsbzgCSJ8SHsxF0O+oMH80efn504ZVIV1YQAlob2XNw8QruojNWJaaoPNEWAWm
         DJ2A==
X-Gm-Message-State: ALoCoQltDZyWzZLP2MxMymFVDK4JhpGWLgYDrZ4FmmuE7kS1kR4sfkXsrhbfu8u8N1RGOh/M2VWX
X-Received: by 10.180.79.134 with SMTP id j6mr19264778wix.83.1437155425344;
 Fri, 17 Jul 2015 10:50:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.210.74 with HTTP; Fri, 17 Jul 2015 10:50:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1507171558010.18576@nanos>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150712220154.7166.48327.stgit@bhelgaas-glaptop2.roam.corp.google.com> <alpine.DEB.2.11.1507171558010.18576@nanos>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 17 Jul 2015 12:50:05 -0500
Message-ID: <CAErSpo6HFN1i2cMwrLyFoYGrvaX-QFeVT_bJyRo9wpFLwma49g@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86, irq: Rename VECTOR_UNDEFINED and
 VECTOR_RETRIGGERED to IRQ_*
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
        "x86@kernel.org" <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48343
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

On Fri, Jul 17, 2015 at 9:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 12 Jul 2015, Bjorn Helgaas wrote:
>
>> The per-cpu vector_irq[] table is indexed by CPU vector numbers, and each
>> entry contains an IRQ number.
>>
>> Rename the special values VECTOR_UNDEFINED and VECTOR_RETRIGGERED to
>> IRQ_UNDEFINED and IRQ_RETRIGGERED to indicate that they are in the IRQ
>> number space, not the CPU vector number space.
>
> Makes some sense, but OTOH vector_irq actually reflects the vector
> state not the irq number state. The fact that we store the Linux irq
> number in vector_irq is just an implementation detail.
>
> VECTOR_UNDEFINED is certainly a misnomer; that should be VECTOR_UNUSED
>
> VECTOR_RETRIGGERED is pretty accurate. In the case we retrigger an
> interrupt, we merily use the Linux irq number to figure out which
> vector to kick. And after we retriggered it, we lose the association
> to the Linux irq number completely.
>
> That said, I'm working on storing the irq descriptor pointer in
> vector_irq instead of the irq number, which has the advantage that we
> avoid the lookup of the irq descriptor in the interrupt hotpath.

OK, I'll abandon this.  Thanks for taking a look!

Bjorn
