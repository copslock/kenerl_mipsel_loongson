Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 16:05:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48278 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6833444Ab3AXPFVSV6Hb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 16:05:21 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0OF5JIu002103;
        Thu, 24 Jan 2013 16:05:19 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0OF5ItU002101;
        Thu, 24 Jan 2013 16:05:18 +0100
Date:   Thu, 24 Jan 2013 16:05:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 00/18] KVM for MIPS32 Processors
Message-ID: <20130124150518.GA1593@linux-mips.org>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Nov 21, 2012 at 06:33:58PM -0800, Sanjay Lal wrote:

I've queued the patch set.  I've done a few stylistic changes such as
getting rid of all use of ulong and u_long data types in favor of
unsigned long.  I also ran into the following modpost error

  ERROR: "kvm_arch_vcpu_postcreate" [arch/mips/kvm/kvm.ko] undefined!

which I fixed by adding a trivial kvm_arch_vcpu_postcreate function:

int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
{
        return 0;
}

which may or may not be sufficient.

Enabling CONFIG_KVM_MIPS_VZ was causing build errors.  Since the support
code for the VZ ASE is not part of this series, I've ripped that out
entirely.

As for the __unused references, some are indeed unused with no apparent
reason for why the variables shouldn't be removed.  There are also
variables marked __unused which are being used - so no point in marking
them.  I've sorted that, too.

  Ralf
