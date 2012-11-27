Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2012 20:36:13 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:48033 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823436Ab2K0TgII9BFf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2012 20:36:08 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Tue, 27 Nov 2012 11:35:58 -0800
Subject: Re: [PATCH v2 00/18] KVM for MIPS32 Processors
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <50B3BAC0.6070407@gmail.com>
Date:   Tue, 27 Nov 2012 14:35:27 -0500
Cc:     Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F6277AC4-0419-40EE-AC54-C144576166EF@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <50B3BAC0.6070407@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35149
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


On Nov 26, 2012, at 1:53 PM, David Daney wrote:

> 
> I have several general questions about this patch...
> 
> On 11/21/2012 06:33 PM, Sanjay Lal wrote:
>> The following patchset implements KVM support for MIPS32R2 processors,
>> using Trap & Emulate, with basic runtime binary translation to improve
>> performance.  The goal has been to keep the Guest kernel changes to a
>> minimum.
> 
> What is the point of minimizing guest kernel changes?
> 
> Because you are using an invented memory map, instead of the architecturally defined map, there is no hope of running a single kernel image both natively and as a guest.  So why do you care about how many changes there are.

It makes porting the code easier.  Since we need a special guest kernel, keeping the changes to minimum helps when migrating from one Linux version to another.  At this point we've migrated the code from 2.6.32 to 3.7 with 3.0 along the way, without any issues and anything more than an automatic merge.

> 
>> 
>> The patch is against Linux 3.7-rc6.  This is Version 2 of the patch set.
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
> 
> Unlike x86, there is no concept of a canonical MIPS system for you to implement.  So the choice of emulating a Malta or one of the SigmaDesigns boards doesn't seem to me to give you anything.
> 
> Why not just define the guest system to be exactly the facilities provided by the VirtIO drivers?

The above list is a list of "host systems" that we've tested KVM/MIPS on.  The guest kernel runs on the Malta system that is emulated by QEMU regardless of the host system.

And yes we do support VirtIO devices on the emulated Malta board to speed up I/O, but since they attach to the emulated systems' PCI bus, we still need a kernel and system that supports PCI.

Just an FYI, we'll be posting the QEMU patch set shortly.

> 
> 
> Perhaps it is obvious from the patches, but I wasn't able to figure out how you solve the problem of the Root/Host kernel clobbering the K0 and K1 registers in its exception handlers.  These registers are also used by the Guest kernel (aren't they)?

Yes k0/k1 do need to be saved as they are used by both the guest and host kernels.  The code is in kvm_locore.S around line 250 where the L1 exception vectors are installed.

Regards
Sanjay
