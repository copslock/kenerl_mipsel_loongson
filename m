Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 18:08:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54474 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817258Ab3IZQIYR1gYA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 18:08:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8QG8Mu3027425;
        Thu, 26 Sep 2013 18:08:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8QG8MpV027424;
        Thu, 26 Sep 2013 18:08:22 +0200
Date:   Thu, 26 Sep 2013 18:08:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: kernel: traps: Remove useless BUG_ON()
Message-ID: <20130926160822.GD31496@linux-mips.org>
References: <1380188131-28792-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380188131-28792-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37999
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

On Thu, Sep 26, 2013 at 10:35:31AM +0100, Markos Chandras wrote:

> Checking for n<0 && n>9 makes no sense because it can never
> be true. Moreover, we can have up to 64 vectored interrupts
> so BUG_ON(n>9) was wrong anyway.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree

What gem ;-)

I think the intent was

  BUG_ON(n < 0 || n > 9);

and 9 probably is the highest currently used value?

In any case that could have broken PowerTV which does the following:

        if (cpu_has_veic || cpu_has_vint) {
                int nvec = cpu_has_veic ? 64 : 8;
                for (i = 0; i < nvec; i++)
                        set_vi_handler(i, asic_irqdispatch);
        }

Nobody from PowerTV complained.  Time to sharpen the axe!

  Ralf
