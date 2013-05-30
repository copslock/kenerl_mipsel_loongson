Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 20:30:51 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:43052 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823608Ab3E3SaqRasjX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 20:30:46 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 30 May 2013 11:30:38 -0700
Subject: Re: [PATCH 10/18] KVM/MIPS32-VZ: Add API for VZ-ASE Capability
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <51A7875F.4080606@gmail.com>
Date:   Thu, 30 May 2013 11:30:36 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1850D149-1FA7-4D91-A08A-BAC1D283B358@kymasys.com>
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-11-git-send-email-sanjayl@kymasys.com> <51A4DC99.7040706@redhat.com> <51A7875F.4080606@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36650
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


On May 30, 2013, at 10:07 AM, David Daney wrote:

> On 05/28/2013 09:34 AM, Paolo Bonzini wrote:
>> Il 19/05/2013 07:47, Sanjay Lal ha scritto:
>>> - Add API to allow clients (QEMU etc.) to check whether the H/W
>>>   supports the MIPS VZ-ASE.
>> 
>> Why does this matter to userspace?  Do the userspace have some way to
>> detect if the kernel is unmodified or minimally-modified?
>> 
> 
> There are (will be) two types of VM presented by MIPS KVM:
> 
> 1) That provided by the initial patch where a faux-MIPS is emulated and all kernel code must be in the USEG address space.
> 
> 2) Real MIPS, addressing works as per the architecture specification.
> 
> Presumably the user-space client would like to know which of these are supported, as well as be able to select the desired model.
> 
> I don't know the best way to do this, but I agree that KVM_CAP_MIPS_VZ_ASE is probably not the best name for it.
> 
> My idea was to have the arg of the KVM_CREATE_VM ioctl specify the desired style
> 
> David Daney
> 
> 


Hi Paolo, just wanted to add to David's comments.  KVM/MIPS currently supports the two modes David mentioned, based on a kernel config option.   KVM_CAP_MIPS_VZ_ASE is used by QEMU to make sure that the kvm module currently loaded supports the H/W virtualization.

Its a bit cumbersome on MIPS, because you really can't fall back to trap and emulate, since the guest kernel for trap and emulate has a user mode link address.

I am open to other ways of doing this.

Regards
Sanjay
