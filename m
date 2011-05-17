Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 03:27:29 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56002 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab1EQB1Y convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2011 03:27:24 +0200
Received: by pzk28 with SMTP id 28so18475pzk.36
        for <multiple recipients>; Mon, 16 May 2011 18:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tOYvDOUFzlZUbskSkl0xgPvPTU0PLeKfMO0ly5uDEzg=;
        b=hkHe9tw5UZiWc0jVVHNYFD1WwL14UWJ+Wqj9O0GzL3CoN/4+vF7PsBM6FJ+xNPk/sj
         v1jNmtEhMl/rcBy+brnevTisDedYSJWRyOiyvVz8WepQzUyFyMQwH49qmUK8Qgdh04pM
         wHVQt7quNgKhdmGFkd+JfX5htEgqo38+h1e9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=guQreLhK67RvubHDTafsGfgVBHYp3DKEJx9Xh72TL1QhN200jmtOnZTzjUmg12LKxF
         h/+qbIDvhg929EQ2r+3mOwU0mHkQzZGF7egG98e/7R0eFCcvPW2IujxpUssI8jOeAaVY
         HcdGQ0Yv7FlsYNrsBH6RhCwDXMFnpCdF7IrAE=
MIME-Version: 1.0
Received: by 10.68.19.131 with SMTP id f3mr110000pbe.379.1305595637791; Mon,
 16 May 2011 18:27:17 -0700 (PDT)
Received: by 10.68.51.72 with HTTP; Mon, 16 May 2011 18:27:17 -0700 (PDT)
In-Reply-To: <4DD1BD72.2000408@caviumnetworks.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
        <4DD1BD72.2000408@caviumnetworks.com>
Date:   Mon, 16 May 2011 18:27:17 -0700
Message-ID: <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
Subject: Re: patch to support topdown mmap allocation in MIPS
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Jian Peng <jipeng@broadcom.com>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2011 at 5:12 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 05/16/2011 02:09 PM, Jian Peng wrote:
>>  #define COLOUR_ALIGN(addr,pgoff)                              \
>>        ((((addr) + shm_align_mask)&  ~shm_align_mask) +        \
>>         (((pgoff)<<  PAGE_SHIFT)&  shm_align_mask))

I see COLOUR_ALIGN in arch/{arm,mips,sh,sparc} .  All sorts of
embedded platforms have to worry about cache aliases nowadays.

Do you think this logic could be folded into the generic
implementations in mm/mmap.c ?  Or is there something else inside our
arch_get_unmapped_area* functions that's really, irreparably unique to
MIPS?

>> +#ifdef CONFIG_32BIT
>> +       task_size = TASK_SIZE;
>> +#else /* Must be CONFIG_64BIT*/
>> +       task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
>> TASK_SIZE;
>> +#endif

Can the "#else" clause and "task_size" local variable be eliminated?
TASK_SIZE now performs this check automatically (although that wasn't
always the case).
