Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 15:48:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55144 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992990AbcGENsTcGH8l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jul 2016 15:48:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u65DmIZo017428;
        Tue, 5 Jul 2016 15:48:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u65DmGIR017427;
        Tue, 5 Jul 2016 15:48:16 +0200
Date:   Tue, 5 Jul 2016 15:48:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: Re: [PATCH 00/14] MIPS: KVM: Dynamically generate exception code
Message-ID: <20160705134815.GK7075@linux-mips.org>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54221
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

On Thu, Jun 23, 2016 at 05:34:33PM +0100, James Hogan wrote:

> These patches change the MIPS KVM exception entry code to be dynamically
> assembled by the MIPS "uasm" in-kernel assembler, directly into unmapped
> memory at run time by a new entry.c. Previously this code was statically
> assembled from locore.S at build time and later copied into unmapped
> memory at run time.
> 
> Patches 1-5 add support for the necessary instructions to uasm.
> 
> Patches 6-8 do the minimal-change conversion of locore.S to entry.c
> using uasm (I've used -M10% so the diff is shown as a file move).
> 
> Patches 9-14 make some related improvements that are possible now that
> it is dynamically generated, such as avoiding messy runtime conditionals
> in assembly code, making use of KScratch registers when available, and
> simplifying the initial GP register save sequence & jump to common code.
> 
> Ralf: Since the uasm patches (1-5) are needed for the later patches, I
> suggest these all go together via the KVM tree (on which the whole
> patchset is based), so Acks are welcome if they're okay with you.

Yes, please, so for the MIPS bits, that is patche 01..05:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
