Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 18:14:19 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:60603 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823039Ab2KBROSjFWcx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2012 18:14:18 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 2 Nov 2012 10:14:10 -0700
Subject: Re: [PATCH 00/20] KVM for MIPS32 Processors
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type:   text/plain; charset=US-ASCII
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <50928C83.60609@redhat.com>
Date:   Fri, 2 Nov 2012 13:14:09 -0400
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7BIT
Message-Id: <72741470-10BE-4F90-9BB7-66088FC08D48@kymasys.com>
References: <C5B4CB07-2946-4536-9854-9F66893D2C2B@kymasys.com> <50928C83.60609@redhat.com>
To:     Avi Kivity <avi@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On Nov 1, 2012, at 10:51 AM, Avi Kivity wrote:

> On 10/31/2012 05:17 PM, Sanjay Lal wrote:
>> The following patchset implements KVM support for MIPS32R2 processors,
>> using Trap & Emulate, with basic runtime binary translation to improve
>> performance.  The goal has been to keep the Guest kernel changes to a
>> minimum.
>> 
>> The patch is against Linux 3.7-rc2.  
>> 
>> There is a companion patchset for QEMU that adds KVM support for the 
>> MIPS target.
>> 
>> KVM/MIPS should support MIPS32-R2 processors and beyond.
>> It has been tested on the following platforms:
>>  - Malta Board with FPGA based 34K (Little Endian).
>>  - Sigma Designs TangoX board with a 24K based 8654 SoC (Little Endian).
>>  - Malta Board with 74K @ 1GHz (Little Endian).
>>  - OVPSim MIPS simulator from Imperas emulating a Malta board with 
>>    24Kc and 1074Kc cores (Little Endian).
>> 
>> Both Guest kernel and Guest Userspace execute in UM. The Guest address space is
>> as folows:
>> Guest User address space:   0x00000000 -> 0x40000000
>> Guest Kernel Unmapped:      0x40000000 -> 0x60000000
>> Guest Kernel Mapped:        0x60000000 -> 0x80000000
>> 
>> As a result, Guest Usermode virtual memory is limited to 1GB.
>> 
>> Relase Notes
>> ============
>> (1) 16K Page Size:
>>    Both Host Kernel and Guest Kernel should have the same page size, 
>>    currently at least 16K.  Note that due to cache aliasing issues, 
>>    4K page sizes are NOT supported.
>> 
>> (2) No HugeTLB/Large Page Support:
>>    Both the host kernel and Guest kernel should have the page size 
>>    set to at least 16K.
>>    This will be implemented in a future release.
>> 
>> (3) SMP Guests to not work
>>    Linux-3.7-rc2 based SMP guest hangs due to the following code sequence 
>>    in the generated TLB handlers:
>>         LL/TLBP/SC
>>    Since the TLBP instruction causes a trap the reservation gets cleared
>>    when we ERET back to the guest. This causes the guest to hang in an 
>>    infinite loop.
>>    As a workaround, make sure that CONFIG_SMP is disabled for Guest kernels.
>>    This will be fixed in a future release.
>> 
>> (4) FPU support:
>>    Currently KVM/MIPS emulates a 24K CPU without a FPU.
>>    This will be fixed in a future release
>> 
> 
> Thanks for posting this, new architectures are always a welcome addition.
> 
> Some general notes:
> - please read and follow Documentation/CodingStyle.  In general the
> patches are okay except for indentation (use tabs, not spaces, and set
> your editor tab width to 8).

I'll definitely be re-formatting the code based on the recommended coding style and running the patches through checkpatch.pl for v2 of the patch set.

Regards
Sanjay
