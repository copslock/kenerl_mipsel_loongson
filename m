Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 15:49:33 +0200 (CEST)
Received: from mail-qc0-f170.google.com ([209.85.216.170]:54506 "EHLO
        mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011613AbaJPNtbrvvtZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 15:49:31 +0200
Received: by mail-qc0-f170.google.com with SMTP id m20so2789912qcx.15
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TX2H9pQEzCpMkZUwQDeIQpv7oGburMj5dDAFG06N+Ks=;
        b=T36Dw3TCJ0ScTYbwMGdMLHeyWIdO8Tvb4o1OdtLB2tO47AUQq9udLMox4PNaoi7QLj
         L+V+jEMq9ADlExOoaD6lCMRuFlqsor0s5V/2rIrcrcYmKNZBLHSfW2hu/2874gfHYZQk
         qifziRMnYyJ3Sq+CiQyU3sw64NYQAy3GmY/zpsEB6dHcskALDEFyU9sxDmfvFQQwClWS
         0HPdz8WFwz/vPhqzOBedsGIYmLcrVPW3/WRMCzcqNM5zWt8KvHxEu1IfcxHE8NJGpXqP
         7MvuXXEyODg8EjHYnR0G4Wqi3L0GjjlXsQCx6FDrvLXs//BWXX6okTIk5BDJCaTUy0vB
         LJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=TX2H9pQEzCpMkZUwQDeIQpv7oGburMj5dDAFG06N+Ks=;
        b=VHI1tkHJ0qzog24wAZ/W4WALM92SddOX40xHVGoIGtfV6OSiFCp4/XHuxe7B2CvE6k
         8Unra0yy3vXatfS/OBU2mrWAEaGLBoWYVkyfDt8d0vaeh7Q5SoKzAb2Hg4SERjB1qQbS
         0WJF2EK7vtjOhMBSmRyGo4YplSaqg3Z0PrhTWaPsQ0ApEtkj22pOvBL+LVEdsOmecdhh
         ofXLIC1aZTWk6D9wqRDsRyCZIxtjvMtEU4f2qUA3ERrzS7wWS0vxqokV9tSKmkKyuhMQ
         DtK4CyYV4sAfy9hltysFSdlhJCeP6Njy6Szzue62p4F7SBVNZ4eO3ctRs3KL+Asemx4q
         /y8g==
X-Gm-Message-State: ALoCoQk3RpfjRERIfte+vo0NIuTrfz8X0R+/d1NE59njSJFfQuF/kwhuE4brZkD2iSqidYXKnZJp
X-Received: by 10.224.45.65 with SMTP id d1mr2182755qaf.43.1413467365578; Thu,
 16 Oct 2014 06:49:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.161.79 with HTTP; Thu, 16 Oct 2014 06:49:05 -0700 (PDT)
In-Reply-To: <CAErSpo45JNAFM7gYM39hsAw=O+Pe2FLJYpj3WV0p2rDe-_t+xg@mail.gmail.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170617.4063.2807.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CAErSpo45JNAFM7gYM39hsAw=O+Pe2FLJYpj3WV0p2rDe-_t+xg@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 16 Oct 2014 07:49:05 -0600
Message-ID: <CAErSpo6978-uGD6Mq+tESXVZsmZSLWCuAwyBzO9pKHg_foNZPg@mail.gmail.com>
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
X-archive-position: 43304
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

[+cc Stephen]

On Wed, Oct 15, 2014 at 5:28 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-mips]
>
> On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> When the "weak" attribute is on a declaration in a header file, every
>> definition where the header is included becomes weak, and the linker
>> chooses one definition based on link order (see 10629d711ed7 ("PCI: Remove
>> __weak annotation from pcibios_get_phb_of_node decl")).
>>
>> Move the "weak" attribute from the declaration to the default definition so
>> we always prefer a non-weak definition over the weak one, independent of
>> link order.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-mips@linux-mips.org
>> ---
>>  arch/mips/include/asm/vpe.h |    2 +-
>>  arch/mips/kernel/vpe-mt.c   |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
>> index 7849f3978fea..80e70dbd1f64 100644
>> --- a/arch/mips/include/asm/vpe.h
>> +++ b/arch/mips/include/asm/vpe.h
>> @@ -122,7 +122,7 @@ void release_vpe(struct vpe *v);
>>  void *alloc_progmem(unsigned long len);
>>  void release_progmem(void *ptr);
>>
>> -int __weak vpe_run(struct vpe *v);
>> +int vpe_run(struct vpe *v);
>>  void cleanup_tc(struct tc *tc);
>>
>>  int __init vpe_module_init(void);
>> diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
>> index 2e003b11a098..0e5899a2cd96 100644
>> --- a/arch/mips/kernel/vpe-mt.c
>> +++ b/arch/mips/kernel/vpe-mt.c
>> @@ -23,7 +23,7 @@ static int major;
>>  static int hw_tcs, hw_vpes;
>>
>>  /* We are prepared so configure and start the VPE... */
>> -int vpe_run(struct vpe *v)
>> +int __weak vpe_run(struct vpe *v)
>>  {
>>         unsigned long flags, val, dmt_flag;
>>         struct vpe_notifications *notifier;
>>

Just FYI, this patch was in linux-next today, but I dropped it
temporarily because Fengguang's auto-builder found the following issue
with it:

All error/warnings:

   arch/mips/kernel/vpe.c: In function 'vpe_release':
>> arch/mips/kernel/vpe.c:830:29: error: the address of 'vpe_run' will always evaluate as 'true' [-Werror=address]
      if ((vpe_elfload(v) >= 0) && vpe_run) {
                                ^
   cc1: all warnings being treated as errors
