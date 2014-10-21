Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 22:05:40 +0200 (CEST)
Received: from mail-qg0-f44.google.com ([209.85.192.44]:57050 "EHLO
        mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012068AbaJUUFiT79VH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 22:05:38 +0200
Received: by mail-qg0-f44.google.com with SMTP id j5so1440393qga.31
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TpyoR92eRCro+83Wju7YwVxnbOk7WZ0sZHjQ2PVLIlM=;
        b=fSqNxBjKnTGUlZgZlPz1xZd06E1OhNmGVi9XHk5V0Wx3KUyrX2dgDgydm5iAzyjDh7
         32TjhDtoVbKxePdPGFEpU4SX2SMdYAZs8fdok8yZYJrzdyvkI77UdkPT/LJukZgfbwq0
         9JMDEzRs7UQ+8RXvzOwS5OzpVPCQkIBaXsGU381sZI9+mwsTUe1fVXhz9kMYeYjYBrHE
         toaE6u/veLbscTkdZJjlthAOTrUXR1tUZFmLs1KNBATfhOAqcsgQRyW9E8Yiwjz23Va2
         ETK9fu7NqTfsPb511d1ybfuaBFHQueYYzDa6LtqxAAygFl3NEzCfRdVU6ItD+0Sc43VZ
         tJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=TpyoR92eRCro+83Wju7YwVxnbOk7WZ0sZHjQ2PVLIlM=;
        b=dLmMQKhNyvVvlWKeqmwmVHp6nUc1eH96SiBP1Ev4Olp9UjM/i4YLggji+qKR0ZckFn
         TSBnACsQdLxLVfcaBCycsFILx8dUoigZaY7QkUJAwlQuqXdNBmQolb911Gvk5RJwSw83
         E/80Fvg9F48OimY0YIAJw8bgHnGV82XKI048iUKe+t3WuAf+bAF7rjSW8F+pmujjj55D
         77aPnwCvchtpH2vkRwHkYXq56Hh7I11fNtBhnEBmSDy/C4si2/dWrpEC+pT9Ei8qwJyt
         ylYpBdwhfcq9m/X82G5tSsW6ui84hjtneuCWfprQizxo4aMytdxZ5HPABfZjVU9fVQDL
         pLnA==
X-Gm-Message-State: ALoCoQkHeBKjfOS08W+xnh/9baBFhUJ/IdxqZWiAZMOjrNF05OkfWUcGHx1HXFlOpVCcn6+DI2AC
X-Received: by 10.140.35.228 with SMTP id n91mr47440135qgn.9.1413921931075;
 Tue, 21 Oct 2014 13:05:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.164.210 with HTTP; Tue, 21 Oct 2014 13:05:10 -0700 (PDT)
In-Reply-To: <CAErSpo6978-uGD6Mq+tESXVZsmZSLWCuAwyBzO9pKHg_foNZPg@mail.gmail.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170617.4063.2807.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAErSpo45JNAFM7gYM39hsAw=O+Pe2FLJYpj3WV0p2rDe-_t+xg@mail.gmail.com> <CAErSpo6978-uGD6Mq+tESXVZsmZSLWCuAwyBzO9pKHg_foNZPg@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 21 Oct 2014 14:05:10 -0600
Message-ID: <CAErSpo7D_vHMebzhTfGKyyX=dtg+H0GiJV3fw2VaMTfdkDfa8g@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] MIPS: MT: Move "weak" from vpe_run() declaration
 to definition
To:     Jason Wessel <jason.wessel@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43432
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

On Thu, Oct 16, 2014 at 7:49 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Stephen]
>
> On Wed, Oct 15, 2014 at 5:28 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc linux-mips]
>>
>> On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> When the "weak" attribute is on a declaration in a header file, every
>>> definition where the header is included becomes weak, and the linker
>>> chooses one definition based on link order (see 10629d711ed7 ("PCI: Remove
>>> __weak annotation from pcibios_get_phb_of_node decl")).
>>>
>>> Move the "weak" attribute from the declaration to the default definition so
>>> we always prefer a non-weak definition over the weak one, independent of
>>> link order.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> CC: linux-mips@linux-mips.org

Dropping this permanently since I haven't heard from any MIPS folks.

>>> ---
>>>  arch/mips/include/asm/vpe.h |    2 +-
>>>  arch/mips/kernel/vpe-mt.c   |    2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
>>> index 7849f3978fea..80e70dbd1f64 100644
>>> --- a/arch/mips/include/asm/vpe.h
>>> +++ b/arch/mips/include/asm/vpe.h
>>> @@ -122,7 +122,7 @@ void release_vpe(struct vpe *v);
>>>  void *alloc_progmem(unsigned long len);
>>>  void release_progmem(void *ptr);
>>>
>>> -int __weak vpe_run(struct vpe *v);
>>> +int vpe_run(struct vpe *v);
>>>  void cleanup_tc(struct tc *tc);
>>>
>>>  int __init vpe_module_init(void);
>>> diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
>>> index 2e003b11a098..0e5899a2cd96 100644
>>> --- a/arch/mips/kernel/vpe-mt.c
>>> +++ b/arch/mips/kernel/vpe-mt.c
>>> @@ -23,7 +23,7 @@ static int major;
>>>  static int hw_tcs, hw_vpes;
>>>
>>>  /* We are prepared so configure and start the VPE... */
>>> -int vpe_run(struct vpe *v)
>>> +int __weak vpe_run(struct vpe *v)
>>>  {
>>>         unsigned long flags, val, dmt_flag;
>>>         struct vpe_notifications *notifier;
>>>
>
> Just FYI, this patch was in linux-next today, but I dropped it
> temporarily because Fengguang's auto-builder found the following issue
> with it:
>
> All error/warnings:
>
>    arch/mips/kernel/vpe.c: In function 'vpe_release':
>>> arch/mips/kernel/vpe.c:830:29: error: the address of 'vpe_run' will always evaluate as 'true' [-Werror=address]
>       if ((vpe_elfload(v) >= 0) && vpe_run) {
>                                 ^
>    cc1: all warnings being treated as errors
