Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 18:05:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36016 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012132AbbHCQFwpcIr4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 18:05:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t73G5o7t008934;
        Mon, 3 Aug 2015 18:05:50 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t73G5ndL008933;
        Mon, 3 Aug 2015 18:05:49 +0200
Date:   Mon, 3 Aug 2015 18:05:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v3] MIPS: tidy up FPU context switching
Message-ID: <20150803160548.GF2843@linux-mips.org>
References: <1438616970-24652-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438616970-24652-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48550
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

On Mon, Aug 03, 2015 at 08:49:30AM -0700, Paul Burton wrote:

> Rather than saving the scalar FP or vector context in the assembly
> resume function, reuse the existing C code we have in fpu.h to do
> exactly that. This reduces duplication, results in a much easier to read
> resume function & should allow the compiler to optimise out more MSA
> code due to is_msa_enabled()/cpu_has_msa being known-zero at compile
> time for kernels without MSA support.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Thanks, applied.

  Ralf
