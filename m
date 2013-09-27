Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2013 14:43:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58184 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822754Ab3I0MnHlKV2t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Sep 2013 14:43:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8RCh5YY005447;
        Fri, 27 Sep 2013 14:43:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8RCh4fO005446;
        Fri, 27 Sep 2013 14:43:04 +0200
Date:   Fri, 27 Sep 2013 14:43:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: kernel: traps: Remove useless BUG_ON()
Message-ID: <20130927124304.GF31496@linux-mips.org>
References: <1380188131-28792-1-git-send-email-markos.chandras@imgtec.com>
 <20130926160822.GD31496@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130926160822.GD31496@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38006
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

On Thu, Sep 26, 2013 at 06:08:22PM +0200, Ralf Baechle wrote:

> In any case that could have broken PowerTV which does the following:
> 
>         if (cpu_has_veic || cpu_has_vint) {
>                 int nvec = cpu_has_veic ? 64 : 8;
>                 for (i = 0; i < nvec; i++)
>                         set_vi_handler(i, asic_irqdispatch);
>         }
> 
> Nobody from PowerTV complained.  Time to sharpen the axe!

Ok…  Of course it didn't break PowerTV - but I was getting pretty
triggerhappy about that platform anyway.

So while I've queued the patch to remove PowerTV support, I'm more than
happy to remove it again if somebody shows up and promises to test and
take care of the platform.  And such threats seem to work most efficient
with the proper patch bomb attached.

That of course doesn't affect your patch which I'm going to apply.

  Ralf
