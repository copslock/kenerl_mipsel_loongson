Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 13:41:32 +0200 (CEST)
Received: from mail-ee0-f53.google.com ([74.125.83.53]:41439 "EHLO
        mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827530Ab3E1LlbNSCEK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 May 2013 13:41:31 +0200
Received: by mail-ee0-f53.google.com with SMTP id c1so4606572eek.40
        for <multiple recipients>; Tue, 28 May 2013 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=0+4O/M/a4DxsZbt2wNEEDMsJgMxI28ewB0W7q9LVpl8=;
        b=vZejCPUcV1tOSobHDuotpztujjooYjUQFZJmAGMHAXxBbXt4fq/ZrJ73upL34YBMxl
         YRAIIlZk89sDSwQH00HXMRbCpWNiYgudcqNBkCuXiQzb1Xb/3xEsOFn8TKkyCtoQTEq5
         tLwwEgl6fbRLL5tmEy7PNr5pKiTo0GOFdKXGajVfziWEpY5KYXdnEagXZhmff6AKaWEN
         SuKIZ4gfMh2XSG7qApM6WADtg4FTBDda2fqNSgD0+h8/ctkR3CkSNAS/tBGlGMyzZIZc
         p+cfBhKjZYFj+1n+A4lO7enlKxGi0wndXTBBoqg3oP5ALmCtP9kC0qFQ0pucIZoCyaAe
         5N4A==
X-Received: by 10.14.7.198 with SMTP id 46mr57809231eep.17.1369741285805;
        Tue, 28 May 2013 04:41:25 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-138-128.cust.dsl.vodafone.it. [37.117.138.128])
        by mx.google.com with ESMTPSA id bp51sm47331581eeb.5.2013.05.28.04.41.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 04:41:24 -0700 (PDT)
Message-ID: <51A497DA.50803@redhat.com>
Date:   Tue, 28 May 2013 13:41:14 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v6 0/6] mips/kvm: Fix ABI for compatibility with 64-bit
 guests.
References: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36619
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

Il 23/05/2013 18:49, David Daney ha scritto:
> From: David Daney <david.daney@cavium.com>
> 
> The initial patch set implementing MIPS KVM does not handle 64-bit
> guests or use of the FPU.  This patch set corrects these ABI issues,
> and does some very minor clean up.
> 
> Changes from v5: Adjust for kvm.h moving to uapi/asm.  Code formatting
>                  to achieve line lengths <= 80.
> 
> Changes from v4: No code change, just keep more of the code in
>                  kvm_mips.c rather than kvm_trap_emul.c
> 
> Changes from v3: Use KVM_SET_ONE_REG instead of KVM_SET_MSRS.  Added
>                  ENOIOCTLCMD patch.
> 
> Changes from v2: Split into five parts, no code change.
> 
> David Daney (6):
>   mips/kvm: Fix ABI for use of FPU.
>   mips/kvm: Fix ABI for use of 64-bit registers.
>   mips/kvm: Fix name of gpr field in struct kvm_regs.
>   mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in
>     kvm_arch_vcpu_ioctl_{s,g}et_regs
>   mips/kvm: Fix ABI by moving manipulation of CP0 registers to
>     KVM_{G,S}ET_ONE_REG
>   mips/kvm: Use ENOIOCTLCMD to indicate unimplemented ioctls.
> 
>  arch/mips/include/asm/kvm_host.h |   4 -
>  arch/mips/include/uapi/asm/kvm.h | 137 +++++++++++++++----
>  arch/mips/kvm/kvm_mips.c         | 280 ++++++++++++++++++++++++++++++++++++---
>  arch/mips/kvm/kvm_trap_emul.c    |  50 -------
>  4 files changed, 369 insertions(+), 102 deletions(-)
> 

Applied, thanks.

Paolo
