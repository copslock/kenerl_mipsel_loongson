Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 17:10:54 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:48070 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827651Ab3BOQKyLupgC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Feb 2013 17:10:54 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 15 Feb 2013 08:10:45 -0800
Subject: Re: [PATCH v2 11/18] KVM/MIPS32: Routines to handle specific traps/exceptions while executing the guest.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130206132018.GC7837@redhat.com>
Date:   Fri, 15 Feb 2013 11:10:46 -0500
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D2EC658F-5271-4221-8141-930E00D3FF84@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <1353551656-23579-12-git-send-email-sanjayl@kymasys.com> <20130206132018.GC7837@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35769
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


On Feb 6, 2013, at 8:20 AM, Gleb Natapov wrote:

> On Wed, Nov 21, 2012 at 06:34:09PM -0800, Sanjay Lal wrote:
>> +static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
>> +{
>> +	gpa_t gpa;
>> +	uint32_t kseg = KSEGX(gva);
>> +
>> +	if ((kseg == CKSEG0) || (kseg == CKSEG1))
> You seems to be using KVM_GUEST_KSEGX variants on gva in all other
> places. Why not here?

This function is invoked to handle 2 scenarios:
(1) Parse the boot code config tables setup by QEMU's Malta emulation. The pointers in the tables are actual KSEG0 addresses (unmapped, cached) and not Guest KSEG0 addresses.

(2) Handle I/O accesses by the guest.  On MIPS platforms, I/O device registers are mapped into the KSEG1 address space (unmapped, uncached).  Again like (1) these are actual KSEG1 addresses, which cause an exception and are passed onto QEMU for I/O emulation.

Regards
Sanjay
