Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 14:55:09 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:23120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822969Ab3EVMzGyPx6Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 14:55:06 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4MCstFk018394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 22 May 2013 08:54:55 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r4MCss7b012682;
        Wed, 22 May 2013 08:54:54 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 10EE518D3DE; Wed, 22 May 2013 15:54:54 +0300 (IDT)
Date:   Wed, 22 May 2013 15:54:53 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 0/6] mips/kvm: Fix ABI for compatibility with 64-bit
 guests.
Message-ID: <20130522125453.GN14287@redhat.com>
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36522
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

On Tue, May 21, 2013 at 01:54:49PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The initial patch set implementing MIPS KVM does not handle 64-bit
> guests or use of the FPU.  This patch set corrects these ABI issues,
> and does some very minor clean up.
> 
Sanjay, is this looks good to you. 

What userspace MIPS is using for machine emulation? Is there corresponding
patches to the userspace?

> Chandes from v3: Use KVM_SET_ONE_REG instead of KVM_SET_MSRS.  Added
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
>  arch/mips/include/asm/kvm.h      | 137 ++++++++++++----
>  arch/mips/include/asm/kvm_host.h |   4 -
>  arch/mips/kvm/kvm_mips.c         | 118 +++-----------
>  arch/mips/kvm/kvm_trap_emul.c    | 338 ++++++++++++++++++++++++++++++++++-----
>  4 files changed, 430 insertions(+), 167 deletions(-)
> 
> -- 
> 1.7.11.7

--
			Gleb.
