Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 17:14:05 +0100 (CET)
Received: from elettra.colt-to.towertech.it ([213.215.222.70]:59667 "EHLO
        elettra.colt-to.towertech.it" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493523AbZLCQOC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 17:14:02 +0100
Received: from linux.lan.towertech.it (93-39-58-60.ip74.fastwebnet.it [93.39.58.60])
        by elettra.colt-to.towertech.it (Postfix) with ESMTPSA id C2F06116649;
        Thu,  3 Dec 2009 17:14:01 +0100 (CET)
Date:   Thu, 3 Dec 2009 17:14:00 +0100
From:   Alessandro Zummo <a.zummo@towertech.it>
To:     rtc-linux@googlegroups.com
Cc:     ralf@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rtc-linux] Re: [PATCH v1 1/3] RTC: rtc-cmos.c: fix warning for
 MIPS
Message-ID: <20091203171400.163e6f66@linux.lan.towertech.it>
In-Reply-To: <20091203155604.GC28957@linux-mips.org>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
        <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
        <20091203155604.GC28957@linux-mips.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.95.2 at elettra
X-Virus-Status: Clean
Return-Path: <a.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Thu, 3 Dec 2009 15:56:04 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> Ping.
> 
> This patch is now nearly a month old and I haven't yet heared anything.
> This was actually meant to be 2.6.32 material.

 I supposed MIPS things were handled by the MIPS tree. If there's
 urgency a submitter should specify the intended delivery path
 (trivial, mips, rtc, directly to Andrew) and kernel release.
 
 Acked-by: Alessandro Zummo <a.zummo@towertech.it>


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
