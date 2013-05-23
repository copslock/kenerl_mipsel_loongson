Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 12:28:51 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:52077 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819547Ab3EWK2s4n08G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 May 2013 12:28:48 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NAScFa019625
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 23 May 2013 06:28:38 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4NASZ7K009094;
        Thu, 23 May 2013 06:28:37 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id A37A818D3DE; Thu, 23 May 2013 13:28:34 +0300 (IDT)
Date:   Thu, 23 May 2013 13:28:34 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 0/6] mips/kvm: Fix ABI for compatibility with 64-bit
 guests.
Message-ID: <20130523102834.GN4725@redhat.com>
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Wed, May 22, 2013 at 11:43:50AM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
Please regenerate against master. arch/mips/include/asm/kvm.h does not
exists any more.

> The initial patch set implementing MIPS KVM does not handle 64-bit
> guests or use of the FPU.  This patch set corrects these ABI issues,
> and does some very minor clean up.
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
>  arch/mips/include/asm/kvm.h      | 137 +++++++++++++++----
>  arch/mips/include/asm/kvm_host.h |   4 -
>  arch/mips/kvm/kvm_mips.c         | 278 ++++++++++++++++++++++++++++++++++++---
>  arch/mips/kvm/kvm_trap_emul.c    |  50 -------
>  4 files changed, 367 insertions(+), 102 deletions(-)
> 
> -- 
> 1.7.11.7

--
			Gleb.
