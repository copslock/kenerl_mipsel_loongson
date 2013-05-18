Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 02:06:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45800 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835006Ab3ERAGkhrH7q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 May 2013 02:06:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4I06cjL005272;
        Sat, 18 May 2013 02:06:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4I06a9t005271;
        Sat, 18 May 2013 02:06:36 +0200
Date:   Sat, 18 May 2013 02:06:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com
Subject: Re: [PATCH 3/3] KVM/MIPS32: Fix up KVM breakage caused by
 d532f3d26716a39dfd4b88d687bd344fbe77e390 which allows ASID mask and
 increment to be determined @ runtime.
Message-ID: <20130518000636.GC24568@linux-mips.org>
References: <n>
 <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
 <1368825912-23562-4-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368825912-23562-4-git-send-email-sanjayl@kymasys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36444
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

On Fri, May 17, 2013 at 02:25:12PM -0700, Sanjay Lal wrote:
> Date:   Fri, 17 May 2013 14:25:12 -0700
> From: Sanjay Lal <sanjayl@kymasys.com>
> To: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, gleb@redhat.com,
>  mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
> Subject: [PATCH 3/3] KVM/MIPS32: Fix up KVM breakage caused by
>  d532f3d26716a39dfd4b88d687bd344fbe77e390 which allows ASID mask and
>  increment to be determined @ runtime.

Good grief, yet another bug report against that patch ...  I've reverted
d532f3d26 just before your posting.  So I'm going to drop this patch.

Thanks,

  Ralf
