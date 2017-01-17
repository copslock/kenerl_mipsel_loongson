Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 17:05:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34340 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992227AbdAQQFRUf1o5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 17:05:17 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0HG5G7d028860;
        Tue, 17 Jan 2017 17:05:16 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0HG5Fjd028859;
        Tue, 17 Jan 2017 17:05:15 +0100
Date:   Tue, 17 Jan 2017 17:05:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/10] MIPS: Add return errors to protected cache ops
Message-ID: <20170117160515.GB24215@linux-mips.org>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
 <0e04ff4dd4267b0d9c08d44a4f535e7223a070ea.1483993967.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e04ff4dd4267b0d9c08d44a4f535e7223a070ea.1483993967.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56358
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

On Mon, Jan 09, 2017 at 08:51:53PM +0000, James Hogan wrote:

> The protected cache ops contain no out of line fixup code to return an
> error code in the event of a fault, with the cache op being skipped in
> that case. For KVM however we'd like to detect this case as page
> faulting will be disabled so it could happen during normal operation if
> the GVA page tables were flushed, and need to be handled by the caller.
> 
> Add the out-of-line fixup code to load the error value -EFAULT into the
> return variable, and adapt the protected cache line functions to pass
> the error back to the caller.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
