Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 15:02:20 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34838 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028649AbcEJNCStNdFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 15:02:18 +0200
Received: by mail-wm0-f68.google.com with SMTP id e201so2569005wme.2;
        Tue, 10 May 2016 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Q1ykQrR7qrxnlrJ9ba/N3BgejiIFg655YYR5670kMk4=;
        b=ENx1EQWPzBqyY8VEcsjgTqdhxanZosj9DLLcOfkANghR4e0QgYuDS5kaQ7YnHdPtyp
         IthjqUFr4zIJUtu+90nUUzO96MwgSmkwWb5wxOTWlguE0/HBUgTnIPhYz/1oihfhoJwU
         jxWUVfIlz+qNst0v9z6jo99ogbKHJtbo0Zs+/eP7S4KvknuykRH5y7k68iRDIajGQ5Po
         HpLBX+7mtVtsLeQ34q2ZtCGL+J6rtFL+y7+igkMu8Ccdylcs7vfnATgvCGOZ1Tfn3Sbn
         JXNmreupJT6lOaYyYgt5/FJBMWgggZCS6gNPlPYEjvjhh9AqPIMEaXs4/Tc69k2g6+zu
         63yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Q1ykQrR7qrxnlrJ9ba/N3BgejiIFg655YYR5670kMk4=;
        b=Das4iWFRCgKpPFcnl8yJ+ia3vBGQPROL2Nrb4q4BUuEzwljQ86WKB9+UzCI5cX7Xfl
         7tS5fx7yUVvMTQF5DCRpQHJ2jFZqdn8AyrkKr18wQP27Nu+QPzUeETn2GqFrWABtw1ye
         YxE9dUPKAoERM2UQEYZeOpruzS5a//vizz7eViXTmNJHOJeT4gIxNyge+wAt7cfj8YOp
         kzli3FHg2JOo8bQNkmkuHDRaw/JNFujtwbCHaCm+LU9Cekf/l4trzYid35qGs4i2b8Pe
         a30WbWcJBoaKyzcsdwuhPKV4GAWiL1yh4TM/H711bm5fN7kXUr+GS9PDFkod6XzSHkxj
         FcbQ==
X-Gm-Message-State: AOPr4FWXboSrzYGnB7RKdW51q0N5GG2wyGLIC1faavi9v6LXodn0j0U3RVUvmzq0BtHjqg==
X-Received: by 10.194.11.36 with SMTP id n4mr41828017wjb.10.1462885333490;
        Tue, 10 May 2016 06:02:13 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-252-58.clienti.tiscali.it. [78.12.252.58])
        by smtp.googlemail.com with ESMTPSA id d23sm2911421wmd.1.2016.05.10.06.02.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2016 06:02:12 -0700 (PDT)
Subject: Re: [PATCH 0/5] MIPS: KVM: A few misc fixes
To:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1461317929-4991-1-git-send-email-james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5731DBD3.50200@redhat.com>
Date:   Tue, 10 May 2016 15:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1461317929-4991-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53343
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



On 22/04/2016 11:38, James Hogan wrote:
> Here are a few misc fixes for KVM on MIPS, including 2 guest timer race
> fixes, 2 preemption fixes, and missing hazard barriers after disabling
> FPU.
> 
> James Hogan (5):
>   MIPS: KVM: Fix timer IRQ race when freezing timer
>   MIPS: KVM: Fix timer IRQ race when writing CP0_Compare
>   MIPS: KVM: Fix preemptable kvm_mips_get_*_asid() calls
>   MIPS: KVM: Fix preemption warning reading FPU capability
>   MIPS: KVM: Add missing disable FPU hazard barriers
> 
>  arch/mips/include/asm/kvm_host.h |  2 +-
>  arch/mips/kvm/emulate.c          | 89 ++++++++++++++++++++++------------------
>  arch/mips/kvm/mips.c             |  8 +++-
>  arch/mips/kvm/tlb.c              | 32 ++++++++++-----
>  arch/mips/kvm/trap_emul.c        |  2 +-
>  5 files changed, 79 insertions(+), 54 deletions(-)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> 

Queued to kvm/next, thanks.

Paolo
