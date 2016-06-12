Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2016 20:45:28 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35389 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031333AbcFLSp0mVzwG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2016 20:45:26 +0200
Received: by mail-wm0-f65.google.com with SMTP id k184so10042237wme.2;
        Sun, 12 Jun 2016 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7xf7HbsC0l+m/rT9wD9pGIvoz1UdZwS5Hqt5eziB3hY=;
        b=jJwGaf9BJ3UbXi30MaFnZIlvfBcFCj+u4lxaVoMayqbO79MjBHlkW8n0yU0AiXv+eg
         pVWvt5xRN3Vn3vCz5mprRmd0sgf6GsSEwChIDXcr9LDfEhK3bzrzJnU8AXeQ6OPN8lzp
         OfHSbrd6B4fJE9srl9Zu56MNnsix72YZ6Dn6aSLNMXI4Z3Ht+YZtiTeA87vHcDzuqGFr
         OLUuXV428eqzYSl8Jgi1TyeOO14odt2oOYJA2sElKJEIxmjOOrFHFGx65VYyiAqx/uj2
         3DSYlhFkxpbqfCWGKpB8dRtu6zKFYX0gypxUbjbqjs/byIHWz7J3FuLsI9X1JISEfz/S
         jOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7xf7HbsC0l+m/rT9wD9pGIvoz1UdZwS5Hqt5eziB3hY=;
        b=Ko2TJAFjK4KvYWE2Y9zKUumMCKn8+IUPRWDKwkFgvPlbcJNrZZvRuXs10Nu+GFsKpI
         YOlq5FbEQoCr+poQ2gtLUEeJgdGgp7OXzRlW0x77gM4NAhJIBxqlY6gPiJxLM/jPaJTV
         G8Vs3OJAX6AhBKoxcCtYnWf1op0gEUsmUZIFcilZb2MagsWi50zmz7BA5uSufYzFdhG+
         x38MI4hhdOD65r3oOz0taVgcoTziOXd6lKxdLBnKW2NMmGvWyueqmdilkJfWuMXf0Cjz
         FOLdyOs0r9qQSDFeJoniKMy1ca+6X9BMU5djuugYdCcKY7xdz516NEs91C+HUk9DPvKo
         wCMg==
X-Gm-Message-State: ALyK8tKhDOFYLNF7J2E++9j4HoKTdWkTNoKJkmW4IaHqKv3945J1lZ6ewoky21nTm+hzrg==
X-Received: by 10.28.138.13 with SMTP id m13mr8442289wmd.3.1465757120828;
        Sun, 12 Jun 2016 11:45:20 -0700 (PDT)
Received: from [192.168.10.165] (94-39-188-118.adsl-ull.clienti.tiscali.it. [94.39.188.118])
        by smtp.googlemail.com with ESMTPSA id b200sm10285837wmb.9.2016.06.12.11.45.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Jun 2016 11:45:19 -0700 (PDT)
Subject: Re: [PATCH 0/4] MIPS: KVM: Module + non dynamic translating fixes
To:     James Hogan <james.hogan@imgtec.com>
References: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7625eaf3-2faa-690c-514b-c597da7dd3c4@redhat.com>
Date:   Sun, 12 Jun 2016 20:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54020
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



On 09/06/2016 11:50, James Hogan wrote:
> These patches fix a couple of issues I recently spotted when running KVM
> under QEMU (i.e. the host MIPS kernel is running under QEMU on a PC).
> 
> Patches 1-2: Fix modular KVM broken by QEMU TLB optimisation (Patch 1
> marked for stable).
> 
> Patches 3-4: Fix cache instruction emulation, exposed by having dynamic
> translation of emulated instructions accidentally turned off.
> 
> James Hogan (4):
>   MIPS: KVM: Fix modular KVM under QEMU
>   MIPS: KVM: Include bit 31 in segment matches
>   MIPS: KVM: Don't unwind PC when emulating CACHE
>   MIPS: KVM: Fix CACHE triggered exception emulation
> 
>  arch/mips/include/asm/kvm_host.h |  3 ++-
>  arch/mips/kvm/emulate.c          | 21 ++++++++++++++-------
>  arch/mips/kvm/interrupt.h        |  1 +
>  arch/mips/kvm/locore.S           |  1 +
>  arch/mips/kvm/mips.c             | 11 ++++++++++-
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org
> 

Queued for kvm/master.

Paolo
