Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:28:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39188 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992100AbdCOP1xPZ3SV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 16:27:53 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2FDfX6x008018;
        Wed, 15 Mar 2017 14:41:33 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2FDfWea008017;
        Wed, 15 Mar 2017 14:41:32 +0100
Date:   Wed, 15 Mar 2017 14:41:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/8] MIPS: Add Octeon III register accessors & definitions
Message-ID: <20170315134132.GE5512@linux-mips.org>
References: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
 <306f747a0743b91bbfbc321572d28d0e42f9bbb8.1489486985.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306f747a0743b91bbfbc321572d28d0e42f9bbb8.1489486985.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57294
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

On Tue, Mar 14, 2017 at 10:25:44AM +0000, James Hogan wrote:

> Add accessors for some VZ related Cavium Octeon III specific COP0
> registers, along with field definitions. These will mostly be used by
> KVM to set up interrupt routing and partition the TLB between root and
> guest.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Btw, asm/mipsregs.h is growing towards 3000 lines making it a candiate
for splitting.

  Ralf
