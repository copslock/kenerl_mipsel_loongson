Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 15:51:56 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:39843 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825875Ab2KAOvz4X1Qe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2012 15:51:55 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA1Epp9J021354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 1 Nov 2012 10:51:52 -0400
Received: from balrog.usersys.tlv.redhat.com (dhcp-4-121.tlv.redhat.com [10.35.4.121])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA1EpmXp011411;
        Thu, 1 Nov 2012 10:51:49 -0400
Message-ID: <50928C83.60609@redhat.com>
Date:   Thu, 01 Nov 2012 16:51:47 +0200
From:   Avi Kivity <avi@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 00/20] KVM for MIPS32 Processors
References: <C5B4CB07-2946-4536-9854-9F66893D2C2B@kymasys.com>
In-Reply-To: <C5B4CB07-2946-4536-9854-9F66893D2C2B@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 34843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avi@redhat.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/31/2012 05:17 PM, Sanjay Lal wrote:
> The following patchset implements KVM support for MIPS32R2 processors,
> using Trap & Emulate, with basic runtime binary translation to improve
> performance.  The goal has been to keep the Guest kernel changes to a
> minimum.
> 
> The patch is against Linux 3.7-rc2.  
> 
> There is a companion patchset for QEMU that adds KVM support for the 
> MIPS target.
> 
> KVM/MIPS should support MIPS32-R2 processors and beyond.
> It has been tested on the following platforms:
>   - Malta Board with FPGA based 34K (Little Endian).
>   - Sigma Designs TangoX board with a 24K based 8654 SoC (Little Endian).
>   - Malta Board with 74K @ 1GHz (Little Endian).
>   - OVPSim MIPS simulator from Imperas emulating a Malta board with 
>     24Kc and 1074Kc cores (Little Endian).
> 
> Both Guest kernel and Guest Userspace execute in UM. The Guest address space is
> as folows:
>  Guest User address space:   0x00000000 -> 0x40000000
>  Guest Kernel Unmapped:      0x40000000 -> 0x60000000
>  Guest Kernel Mapped:        0x60000000 -> 0x80000000
> 
> As a result, Guest Usermode virtual memory is limited to 1GB.
> 
> Relase Notes
> ============
> (1) 16K Page Size:
>     Both Host Kernel and Guest Kernel should have the same page size, 
>     currently at least 16K.  Note that due to cache aliasing issues, 
>     4K page sizes are NOT supported.
> 
> (2) No HugeTLB/Large Page Support:
>     Both the host kernel and Guest kernel should have the page size 
>     set to at least 16K.
>     This will be implemented in a future release.
> 
> (3) SMP Guests to not work
>     Linux-3.7-rc2 based SMP guest hangs due to the following code sequence 
>     in the generated TLB handlers:
>          LL/TLBP/SC
>     Since the TLBP instruction causes a trap the reservation gets cleared
>     when we ERET back to the guest. This causes the guest to hang in an 
>     infinite loop.
>     As a workaround, make sure that CONFIG_SMP is disabled for Guest kernels.
>     This will be fixed in a future release.
> 
> (4) FPU support:
>     Currently KVM/MIPS emulates a 24K CPU without a FPU.
>     This will be fixed in a future release
> 

Thanks for posting this, new architectures are always a welcome addition.

Some general notes:
- please read and follow Documentation/CodingStyle.  In general the
patches are okay except for indentation (use tabs, not spaces, and set
your editor tab width to 8).
- please use 'git send-email' to send the entire patchset, this keeps
all the patches in a single thread which is easier to follow.
- please add a general architecture document to Documentation/virtual/kvm
- Update Documentation/virtual/kvm/api.txt as needed.

What is the intended use case?

-- 
error compiling committee.c: too many arguments to function
