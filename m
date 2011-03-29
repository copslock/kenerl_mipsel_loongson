Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 07:54:47 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:39631 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490985Ab1C2Fyo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2011 07:54:44 +0200
Received: by bwz1 with SMTP id 1so3557937bwz.36
        for <multiple recipients>; Mon, 28 Mar 2011 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JDKTP7hmXVnOW/UluIu7McPUEe1vTPMAJcKWbhLWmrs=;
        b=Mn+fVR//ceIhFUH8bf9eeVYCuQRPUG/Rs0FWDLlVi9viQ2+IckGnvKlI9YVy5Xk0D1
         uzQu6Hum+CpP/XX+oT6cKgWIWuxhQ0ZDINCABZLkf6KkAokp1DJRkHNm2PiqMfCbOZtM
         ZnVJeAXr+Qx29M4gDiPdhKj7b8M7BNaCyF1j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oG3Lvlv95KeMZWbhbic6pBIAYIlrQpquaO4t9MaeuASP1tokvxcTJTYZv3mTlObd1J
         ozzGwByD1evBvpwvmKzMjh+33YKNxOaGQrgFFtcsHRh17SP3sO1MkVU7GllQRhdVjXxT
         jFYavpclKoIl9OyvQi15+WSa7EUZHRjOkf7dk=
MIME-Version: 1.0
Received: by 10.204.151.204 with SMTP id d12mr4194763bkw.127.1301378078990;
 Mon, 28 Mar 2011 22:54:38 -0700 (PDT)
Received: by 10.204.26.209 with HTTP; Mon, 28 Mar 2011 22:54:38 -0700 (PDT)
In-Reply-To: <20110325172709.GC8483@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
        <20110325172709.GC8483@linux-mips.org>
Date:   Tue, 29 Mar 2011 11:24:38 +0530
Message-ID: <AANLkTimy6FPdgW=f8HOTBd6ORKmjvX3KFONXesacJ6Ms@mail.gmail.com>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

I am sorry, Yes they are VIPT,


On Fri, Mar 25, 2011 at 10:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Mar 25, 2011 at 02:38:13PM +0530, naveen yadav wrote:
>
>> We are working on 2.6.35.9 linux kernel on MIPS 34kce core and our
>> cache is VIVT having cache aliasing .
>
> No, they're VIPT unless you successfully modified your 34K core to
> change it from a less than perfect cache design to the most lunatic
> cache policy known to man kind ...
>
>> When I check the implementation on ARM I can check the implemenation
>> exists , but there is not similar implementation exists on MIPS.
>> These API's are used by XFS module:
>>
>> static inline void flush_kernel_vmap_range(void *vaddr, int size)
>> static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>> static inline void flush_kernel_dcache_page(struct page *page)
>
> A known problem for (too ...) long.  I'll finally take care of it.
>
>  Ralf
>
