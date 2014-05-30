Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 12:18:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60405 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825887AbaE3KSs6q7Hx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 12:18:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4UAIj2Y020187;
        Fri, 30 May 2014 12:18:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4UAIjKa020186;
        Fri, 30 May 2014 12:18:45 +0200
Date:   Fri, 30 May 2014 12:18:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 14/23] MIPS: KVM: Override guest kernel timer
 frequency directly
Message-ID: <20140530101845.GI17197@linux-mips.org>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
 <1401355005-20370-15-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401355005-20370-15-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40383
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

On Thu, May 29, 2014 at 10:16:36AM +0100, James Hogan wrote:

> The KVM_HOST_FREQ Kconfig symbol was used by KVM guest kernels to
> override the timer frequency calculation to a value based on the host
> frequency. Now that the KVM timer emulation is implemented independent
> of the host timer frequency and defaults to 100MHz, adjust the working
> of CONFIG_KVM_HOST_FREQ to match.
> 
> The Kconfig symbol now specifies the guest timer frequency directly, and
> has been renamed accordingly to KVM_GUEST_TIMER_FREQ. It now defaults to
> 100MHz too and the help text is updated to make it clear that a zero
> value will allow the normal timer frequency calculation to take place
> (based on the emulated RTC).

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
