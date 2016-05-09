Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 17:30:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33808 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028409AbcEIPaq5MlS- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2016 17:30:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u49FUja9031711;
        Mon, 9 May 2016 17:30:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u49FUjqC031710;
        Mon, 9 May 2016 17:30:45 +0200
Date:   Mon, 9 May 2016 17:30:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/7] MIPS: KVM/locore.S: Don't preserve host ASID around
 vcpu_run
Message-ID: <20160509153044.GD28818@linux-mips.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
 <1462541784-22128-2-git-send-email-james.hogan@imgtec.com>
 <57309D29.6010903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57309D29.6010903@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53315
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

On Mon, May 09, 2016 at 04:22:33PM +0200, Paolo Bonzini wrote:

> On 06/05/2016 15:36, James Hogan wrote:
> > - It is actually redundant, since the host ASID will be restored
> >   correctly by kvm_arch_vcpu_put(), which is called almost immediately
> >   after kvm_arch_vcpu_ioctl_run() returns.
> 
> What happens if the guest does a rogue access to the area where the host
> kernel resides?  Would that cause a wrong entry in the TLB?

The kernel and lowmem reside in KSEG0/XKPYS which are "unmapped segments".
Unmapped means, the TLB isn't accessed at all nor does the ASID matter
in the address translation process in one of these unmapped segments.

  Ralf
