Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 16:59:20 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:35178 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6833453Ab3AXP7ObBD7W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 16:59:14 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 24 Jan 2013 07:59:02 -0800
Subject: Re: [PATCH v2 00/18] KVM for MIPS32 Processors
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130124150518.GA1593@linux-mips.org>
Date:   Thu, 24 Jan 2013 10:59:00 -0500
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
Message-Id: <9B190B73-399D-4518-8CDF-EEAC9A12B71E@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <20130124150518.GA1593@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35544
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


On Jan 24, 2013, at 10:05 AM, Ralf Baechle wrote:

> On Wed, Nov 21, 2012 at 06:33:58PM -0800, Sanjay Lal wrote:
> 
> I've queued the patch set.  I've done a few stylistic changes such as
> getting rid of all use of ulong and u_long data types in favor of
> unsigned long.  I also ran into the following modpost error
> 
>  ERROR: "kvm_arch_vcpu_postcreate" [arch/mips/kvm/kvm.ko] undefined!
> 
> which I fixed by adding a trivial kvm_arch_vcpu_postcreate function:
> 
> intkvm_arch_vcpu_postcreate((struct kvm_vcpu *vcpu)
> {
>        return 0;
> }
> 
> which may or may not be sufficient.
> 
> Enabling CONFIG_KVM_MIPS_VZ was causing build errors.  Since the support
> code for the VZ ASE is not part of this series, I've ripped that out
> entirely.
> 
> As for the __unused references, some are indeed unused with no apparent
> reason for why the variables shouldn't be removed.  There are also
> variables marked __unused which are being used - so no point in marking
> them.  I've sorted that, too.
> 
>  Ralf


Thanks Ralf. the kvm_arch_vcpu_postcreate() fix is fine, as are the others.

Regards
Sanjay
