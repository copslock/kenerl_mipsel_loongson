Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2013 10:44:58 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:65502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816354Ab3BRJo4drKMo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Feb 2013 10:44:56 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1I9iqE6021110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 18 Feb 2013 04:44:52 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r1I9ipTK005431;
        Mon, 18 Feb 2013 04:44:51 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id C2CE818D479; Mon, 18 Feb 2013 11:44:50 +0200 (IST)
Date:   Mon, 18 Feb 2013 11:44:50 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 11/18] KVM/MIPS32: Routines to handle specific
 traps/exceptions while executing the guest.
Message-ID: <20130218094450.GA9817@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-12-git-send-email-sanjayl@kymasys.com>
 <20130206132018.GC7837@redhat.com>
 <D2EC658F-5271-4221-8141-930E00D3FF84@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2EC658F-5271-4221-8141-930E00D3FF84@kymasys.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 35784
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Feb 15, 2013 at 11:10:46AM -0500, Sanjay Lal wrote:
> 
> On Feb 6, 2013, at 8:20 AM, Gleb Natapov wrote:
> 
> > On Wed, Nov 21, 2012 at 06:34:09PM -0800, Sanjay Lal wrote:
> >> +static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
> >> +{
> >> +	gpa_t gpa;
> >> +	uint32_t kseg = KSEGX(gva);
> >> +
> >> +	if ((kseg == CKSEG0) || (kseg == CKSEG1))
> > You seems to be using KVM_GUEST_KSEGX variants on gva in all other
> > places. Why not here?
> 
> This function is invoked to handle 2 scenarios:
> (1) Parse the boot code config tables setup by QEMU's Malta emulation. The pointers in the tables are actual KSEG0 addresses (unmapped, cached) and not Guest KSEG0 addresses.
> 
Where is it called for that purpose? The only place where gva_to_gpa
callback is called is in kvm/kvm_mips_emul.c:kvm_mips_emulate_(store|load)

> (2) Handle I/O accesses by the guest.  On MIPS platforms, I/O device registers are mapped into the KSEG1 address space (unmapped, uncached).  Again like (1) these are actual KSEG1 addresses, which cause an exception and are passed onto QEMU for I/O emulation.
> 
So guest KSEG1 registers is mapped to 0xA0000000-0xBFFFFFFF ranges just
like on a host? Can you give corresponding segment names to those ranges

Guest User address space:   0x00000000 -> 0x40000000 (useg?)
Guest Kernel Unmapped:      0x40000000 -> 0x60000000 (kseg0?)
Guest Kernel Mapped:        0x60000000 -> 0x80000000 (?)


--
			Gleb.
