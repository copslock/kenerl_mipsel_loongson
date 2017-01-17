Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 17:23:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35310 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993893AbdAQQXgGCVhY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 17:23:36 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0HGNTwL029330;
        Tue, 17 Jan 2017 17:23:29 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0HGNTe4029329;
        Tue, 17 Jan 2017 17:23:29 +0100
Date:   Tue, 17 Jan 2017 17:23:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-mm@kvack.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/30] mm: Export init_mm for MIPS KVM use of pgd_alloc()
Message-ID: <20170117162329.GC24215@linux-mips.org>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
 <a8df39719fb0570cb38e3fbb5c128fe2618e92d6.1483665879.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8df39719fb0570cb38e3fbb5c128fe2618e92d6.1483665879.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56359
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

On Fri, Jan 06, 2017 at 01:32:33AM +0000, James Hogan wrote:

> Export the init_mm symbol to GPL modules so that MIPS KVM can use
> pgd_alloc() to create GVA page directory tables for trap & emulate mode,
> which runs guest code in user mode. On MIPS pgd_alloc() is implemented
> inline and refers to init_mm in order to copy kernel address space
> mappings into the new page directory.

Ackedy-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
