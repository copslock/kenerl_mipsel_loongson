Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 22:22:15 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35977 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbcKIVWIBzGk7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 22:22:08 +0100
Received: by mail-wm0-f66.google.com with SMTP id c17so31695853wmc.3;
        Wed, 09 Nov 2016 13:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=garv8mZFTfYVKGwPkMboSgSQMkcPlBG9Aj/5cEUqnoA=;
        b=U5/H77Puc2gu/AZ8aTh5G7OCZGJNef/ZU/KP9I8CugD+0rB/+W/U7e6B4GzO1hQn4u
         CiSY2Tca3/Btmv3IfBe9B1W2WhODrUFJ7pRqoPoxHwRUs/uVyCPaWsBISHaypzBnQ/Ym
         PeSzFcvVkqK7CVdyQtZwqs2cLnv74P7AmJFjAeD2+0KZv0jmc9RpYekgs/3dwTq0FAH3
         3FgjhMHrlI5pGhU9LkP1VJZGnU+Y/qocofUz52uMEvYoglA+LRjJBbXxA0VaZE9xSYBo
         Ekf4Xp5ePBhE75QK9Ry7RIZUMsjvmeAS3viUjK96GlAKZNUVdElRMnJZJPE1qJ4FSC5L
         jtPg==
X-Gm-Message-State: ABUngve1DjRRW+gkEMCOSBNuCsCjzqMlrL5+Zkpk/DNIKMQCbMAkMGIGSvGVsA73yX5G4A==
X-Received: by 10.28.52.201 with SMTP id b192mr2367835wma.118.1478726522635;
        Wed, 09 Nov 2016 13:22:02 -0800 (PST)
Received: from [192.168.0.102] (ip-78-45-88-157.net.upcbroadband.cz. [78.45.88.157])
        by smtp.gmail.com with ESMTPSA id 125sm2406808wmh.14.2016.11.09.13.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2016 13:22:01 -0800 (PST)
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <20161109144624.16683-1-james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
Date:   Wed, 9 Nov 2016 22:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161109144624.16683-1-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 11/09/2016, 03:46 PM, James Hogan wrote:
> commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.
> 
> When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
> TLB entries on the local CPU. This doesn't work correctly on an SMP host
> when the guest is migrated to a different physical CPU, as it could pick
> up stale TLB mappings from the last time the vCPU ran on that physical
> CPU.
> 
> Therefore invalidate both user and kernel host ASIDs on other CPUs,
> which will cause new ASIDs to be generated when it next runs on those
> CPUs.
> 
> We're careful only to do this if the TLB entry was already valid, and
> only for the kernel ASID where the virtual address it mapped is outside
> of the guest user address range.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 3.10.x-
> Cc: Jiri Slaby <jslaby@suse.cz>
> [james.hogan@imgtec.com: Backport to 3.10..3.16]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
> Unfortunately the original commit went in to v3.12.65 as commit
> 168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
> tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
> already had a correct backport outstanding (sorry!). That commit should
> be reverted before applying this backport to 3.12.

Thanks, reverted and applied. I wonder the builders didn't break given 4
mips configurations are tested. I indeed could reproduce locally.


-- 
js
suse labs
