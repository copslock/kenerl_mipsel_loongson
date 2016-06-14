Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:06:09 +0200 (CEST)
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37111 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042031AbcFNKGHVsB7n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:06:07 +0200
Received: by mail-wm0-f51.google.com with SMTP id k204so115346576wmk.0;
        Tue, 14 Jun 2016 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gB/ayujhrymxuNhJngdLHSYWxGVp19nCoNeus32MrUY=;
        b=z3Jin5UNqSuKUjvp5nyoftZvG/fleHZl9l99o6Xaj86pF3N2IVKcaTmFXn2GYkRwGr
         pG6tlRe8U0k9FeUhb2QvrAFVWRnF3gISUODIRek9cGDauNFXNcYQox6BdANUXnIu1/xV
         9MiFilvp0gpSwQBKCFs8QSe2MDh5SHicoNX7wPQ+lOPWSlsXuZ5Wa3gNcLj043efbnyK
         Xx1t1YrzR5MyAXVrxzDpM4dwKqJxzFr//w/ZyY55nylak5ya8iXvo5j3utEnbZY5di6/
         q134k0o58SdgubB3giz+KnC5miCCE5MHej+qbSXuaqrPt5K+kw0Noueq/KiGRz3RBijx
         jzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gB/ayujhrymxuNhJngdLHSYWxGVp19nCoNeus32MrUY=;
        b=GUQMl6nNZxz92dI/nq0c2+L+67B0rQzRG0wGh8u0ueJ8slwqF1o/XZS7sgMl1WP+ae
         qharwQBuVY7XOz+Kf7yvc+g3INXSE+F5k1LGsQ3F1r47YRaz3sPG++49Xc2py1AUd8Cj
         AyNo6gzkRHHuRM2kpmk+RoSMlcOfzxnurVSJ3CNiidb80ho6/3kwKBlHBo/ophWEba9l
         vC5qUPDpP54CuYpFQFwqSIk1BOUupxdsCrWtycDOT/YnCGkVhbhXEwTVeWuARwvWTpPv
         WZRBRYorTio/UTsJ04oNmCinF+cxf6WWHgv3KIzGjAHYHMqxzEI/8rEx3IghrUAy4Kuu
         94/Q==
X-Gm-Message-State: ALyK8tJm858ngHGEPCGFgtTVSl7frrdvyccD2kd8xMF/QklWjs2mPKXMXZxWW0m/2B9Z2w==
X-Received: by 10.194.83.136 with SMTP id q8mr5646978wjy.146.1465895001810;
        Tue, 14 Jun 2016 02:03:21 -0700 (PDT)
Received: from [192.168.10.150] (94-39-188-118.adsl-ull.clienti.tiscali.it. [94.39.188.118])
        by smtp.googlemail.com with ESMTPSA id t198sm2996143wmt.16.2016.06.14.02.03.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2016 02:03:20 -0700 (PDT)
Subject: Re: [PATCH 0/4] MIPS: KVM: Module + non dynamic translating fixes
To:     James Hogan <james.hogan@imgtec.com>
References: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
 <7625eaf3-2faa-690c-514b-c597da7dd3c4@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b065ed66-0884-2649-bd6e-37eac745f42a@redhat.com>
Date:   Tue, 14 Jun 2016 11:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <7625eaf3-2faa-690c-514b-c597da7dd3c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 12/06/2016 20:45, Paolo Bonzini wrote:
> 
> 
> On 09/06/2016 11:50, James Hogan wrote:
>> These patches fix a couple of issues I recently spotted when running KVM
>> under QEMU (i.e. the host MIPS kernel is running under QEMU on a PC).
>>
>> Patches 1-2: Fix modular KVM broken by QEMU TLB optimisation (Patch 1
>> marked for stable).
>>
>> Patches 3-4: Fix cache instruction emulation, exposed by having dynamic
>> translation of emulated instructions accidentally turned off.
>>
>> James Hogan (4):
>>   MIPS: KVM: Fix modular KVM under QEMU
>>   MIPS: KVM: Include bit 31 in segment matches
>>   MIPS: KVM: Don't unwind PC when emulating CACHE
>>   MIPS: KVM: Fix CACHE triggered exception emulation
>>
>>  arch/mips/include/asm/kvm_host.h |  3 ++-
>>  arch/mips/kvm/emulate.c          | 21 ++++++++++++++-------
>>  arch/mips/kvm/interrupt.h        |  1 +
>>  arch/mips/kvm/locore.S           |  1 +
>>  arch/mips/kvm/mips.c             | 11 ++++++++++-
>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: kvm@vger.kernel.org
>> Cc: linux-mips@linux-mips.org
>> Cc: stable@vger.kernel.org
>>
> 
> Queued for kvm/master.

... and kvm/next too, since your patches conflict with this one.

Paolo
