Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2011 07:06:22 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:35806 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491055Ab1FXFGT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Jun 2011 07:06:19 +0200
Received: by bwz1 with SMTP id 1so2700473bwz.36
        for <multiple recipients>; Thu, 23 Jun 2011 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jY3ZJjoiT4fwPASUxbTRA0U5FSzf0nk94ojcnvteRlQ=;
        b=QkOayfOUB6PbLrVgYIkx8Fs1CPmTxbyIJwrQjCIZFwBH3CnS2cO5equhYnJxGM4kVI
         hvliiQq2z9t3XZvz6mqdi8CGqIMmmMiFULHJmforcxcs/gjzaf5karVv3RfZV4vgJP57
         surXVWODmetVn02NbC3F9PjbW77m8j2F7R/6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Nm6IvKpWk15rIcPD5wX0E9YQrXv4E0YZhWjsrtgL72Xhif+IaT5tXC5nqDHFGJ7P5v
         dRZGab1pd8HPyQoxsG0NTtZlLrdygzsiGinQS5JWS4FyCRBAkfIUjA4C4A9K1YGFCzG2
         CXdr962RX4751VK+Q1txYfJzI1rtDS0r87KOs=
MIME-Version: 1.0
Received: by 10.204.2.141 with SMTP id 13mr1545147bkj.20.1308891973560; Thu,
 23 Jun 2011 22:06:13 -0700 (PDT)
Received: by 10.204.233.16 with HTTP; Thu, 23 Jun 2011 22:06:13 -0700 (PDT)
In-Reply-To: <20110620095625.GA3227@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
        <20110325172709.GC8483@linux-mips.org>
        <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
        <20110616180250.GA13025@lst.de>
        <20110617152028.GA14107@linux-mips.org>
        <4DFCA2DD.9060707@mvista.com>
        <20110620095625.GA3227@linux-mips.org>
Date:   Fri, 24 Jun 2011 10:36:13 +0530
Message-ID: <BANLkTi=HhABKb+FCtp5Z+W4i9hNvapoPLQ@mail.gmail.com>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20102

Dear Ralf and Sergei,

If we have L2 cache, then we need to invalidate them also ?

our system  have L2 cache(write back).

Regards


On Mon, Jun 20, 2011 at 3:26 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Jun 18, 2011 at 05:06:37PM +0400, Sergei Shtylyov wrote:
>
>> >+static inline void flush_kernel_vmap_range(void *vaddr, int size)
>> >+{
>> >+    if (cpu_has_dc_aliases)
>> >+            __flush_kernel_vmap_range((unsigned long) vaddr, size);
>> >+}
>> >+
>> >+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>> >+{
>> >+    if (cpu_has_dc_aliases)
>> >+            __flush_kernel_vmap_range((unsigned long) vaddr, size);
>>
>>    Not __invalidate_kernel_vmap_range()?
>
> No, for the moment both just do a writeback + invalidate.  I may change
> that for something more efficient later once I understand the consequences
> of this.
>
>  Ralf
>
