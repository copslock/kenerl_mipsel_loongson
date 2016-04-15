Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 11:59:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56994 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026641AbcDOJ7oHyoqq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Apr 2016 11:59:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3F9xhF9027691;
        Fri, 15 Apr 2016 11:59:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3F9xfF5027690;
        Fri, 15 Apr 2016 11:59:41 +0200
Date:   Fri, 15 Apr 2016 11:59:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Use copy_s.fmt rather than copy_u.fmt
Message-ID: <20160415095941.GI1524@linux-mips.org>
References: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
 <1460711246-4394-2-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460711246-4394-2-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52993
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

On Fri, Apr 15, 2016 at 10:07:23AM +0100, James Hogan wrote:

> From: Paul Burton <paul.burton@imgtec.com>
> 
> In revision 1.12 of the MSA specification, the copy_u.w instruction has
> been removed for MIPS32 & the copy_u.d instruction has been removed for
> MIPS64. Newer toolchains (eg. Codescape SDK essentials 2015.10) will
> complain about this like so:
> 
> arch/mips/kernel/r4k_fpu.S:290: Error: opcode not supported on this
> processor: mips32r2 (mips32r2) `copy_u.w $1,$w26[3]'
> 
> Since we always copy to the width of a GPR, simply use copy_s instead of
> copy_u to fix this.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.1.x-

Looking good but seems to apply only to 4.3+

  Ralf
