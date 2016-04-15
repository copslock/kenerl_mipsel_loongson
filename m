Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:11:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57460 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026632AbcDOKLzu0ZIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Apr 2016 12:11:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3FABsJr027964;
        Fri, 15 Apr 2016 12:11:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3FABqU8027963;
        Fri, 15 Apr 2016 12:11:52 +0200
Date:   Fri, 15 Apr 2016 12:11:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: MSA fixes
Message-ID: <20160415101152.GJ1524@linux-mips.org>
References: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52994
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

On Fri, Apr 15, 2016 at 10:07:22AM +0100, James Hogan wrote:

> Here are some miscellaneous fixes for MSA (MIPS SIMD Architecture)
> support:
> 1) Fix MSA build with recent toolchains
> 2) Fix 32-bit pointer additions on 64-bit with non-MSA capable
>    toolchain.
> 3) Fix MSA + 64-bit + lockdep build due to large immediate offsets
> 4) Fix some MSA assembler warnings due to missing .set fp=64
> 
> James Hogan (3):
>   MIPS: Fix MSA ld_*/st_* asm macros to use PTR_ADDU
>   MIPS: Fix MSA assembly with big thread offsets
>   MIPS: Fix MSA assembly warnings
> 
> Paul Burton (1):
>   MIPS: Use copy_s.fmt rather than copy_u.fmt

Thanks, whole series applied.

  Ralf
