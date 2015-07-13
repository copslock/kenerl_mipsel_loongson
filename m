Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 20:35:36 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34227 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010659AbbGMSfe45890 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 20:35:34 +0200
Received: by wibud3 with SMTP id ud3so37187313wib.1
        for <linux-mips@linux-mips.org>; Mon, 13 Jul 2015 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mNz0sbM31F25o3BT2ZvjVjjSJUkp6GLmqTPCWr+eQYA=;
        b=YyDVY5iB7mP61wgPFSvY3RWVrzHI9XjPgw+1egLn2Lo5sT4D4cLVgYZ8DYiyhR+6aw
         H8crkJ+dm9On4DkeiNCJk6GTUuGoM6K/jaKI+yA1Gv/p4i9Aju2OZpxKlOjBgUXqUl3F
         IYpU9DpjKR3HjYpDgJsa9MRgjZnM9iLSMtgSCS7MWftdkIgGl526wRe9XxaqbpN342Ef
         HEpwVy7oAcbNYkufsJiTZ6HxD8CkYv/+XF+U63TL9ZU14Y+bkaAYCYxbs60P7gb2zbUS
         Z8zTbh0qZ+o0lmdvSTAhmF6hFanpRLSAU0VkmLMlh64LmTdPi/a5HRNopmNuhOVJu9jv
         mEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mNz0sbM31F25o3BT2ZvjVjjSJUkp6GLmqTPCWr+eQYA=;
        b=GN/+4mPMUf/qE4JSG873pqFlat8PovBBuL5ThBUmKns2Ay0jFNoplJDsm3zqAo+xWE
         rACcjzJkdHMDBXeDZUcI+vn1B9wI9aHbbUYt25ZLeMT6i+8uLbmAowZ3n3WEmm5Tkemx
         PF14qjewKEw0JxPW0ro8/CQ7d1iC3fVetxOb2H9euSeG6QqG8lwvW88A5YhcAOzJTu6+
         PV+kDWP+v13nwyceR7Fw1DpGCFvimPIJa26ti6ZVld9peCIuQwzFMsTHVPs2dhrGwq5I
         C6iTOW+PxepWhACnrO7KJUmiZNMpVWm1PjwVbxK02keQtW5f4U0bkXaqDV0nNlMAzgNO
         3CdA==
X-Gm-Message-State: ALoCoQl9W+LyQUVjX2oyM+swpueKOdO+tUF0IXdBI0EgK1Me+4j1rWXBjz9Nd1jeOriCdHys5WeA
X-Received: by 10.194.87.102 with SMTP id w6mr12347243wjz.111.1436812529563;
 Mon, 13 Jul 2015 11:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.210.74 with HTTP; Mon, 13 Jul 2015 11:35:09 -0700 (PDT)
In-Reply-To: <20150713032303.D49801402B1@ozlabs.org>
References: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150713032303.D49801402B1@ozlabs.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 13 Jul 2015 13:35:09 -0500
Message-ID: <CAErSpo52Kk0c=1UHQzxntJc3ph_CX8vcY+QdULBKv-HGUHBK9Q@mail.gmail.com>
Subject: Re: [3/3] IRQ: Print "unexpected IRQ" messages consistently across architectures
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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
X-archive-position: 48229
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

On Sun, Jul 12, 2015 at 10:23 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sun, 2015-12-07 at 22:02:11 UTC, Bjorn Helgaas wrote:
>> Many architectures use a variant of "unexpected IRQ trap at vector %x" to
>> log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
>> number, but "vector" more often refers to a CPU vector number, and (b) it
>> prints the IRQ number in hex with no base indication, while Linux IRQ
>> numbers are usually printed in decimal.
>>
>> Print the same text ("unexpected IRQ %d") across all architectures.
>>
>> No functional change other than the output text.
>
> There's already a fallback version in asm-generic, so shouldn't you instead
> just delete all the versions that are identical to that?
>
> eg. on powerpc we have:
>
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -     printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +     printk(KERN_CRIT "unexpected IRQ %d\n", irq);
>>  }
>
> And the generic version is:
>
>>  #ifndef ack_bad_irq
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -     printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +     printk(KERN_CRIT "unexpected IRQ %d\n", irq);
>>  }
>>  #endif
>
> So we can just delete the powerpc version?

Wow, I really didn't do my homework here.  Not only is there a generic
version already, but there's also print_irq_desc(), which prints way
more information than any of the ack_bad_irq() implementations.

I'll try again :)

Bjorn
