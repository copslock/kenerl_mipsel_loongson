Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 21:14:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57172 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492660Ab0CKUOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Mar 2010 21:14:55 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2BKEpjL003833;
        Thu, 11 Mar 2010 21:14:52 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2BKEobw003830;
        Thu, 11 Mar 2010 21:14:50 +0100
Date:   Thu, 11 Mar 2010 21:14:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Loongson: Add module info to the loongson2_clock driver
Message-ID: <20100311201447.GA25163@linux-mips.org>
References: <1268153601-4396-1-git-send-email-wuzhangin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268153601-4396-1-git-send-email-wuzhangin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 10, 2010 at 12:53:21AM +0800, Wu Zhangjin wrote:

> This patch fixes the warning of the tool which checks the module info of
> the loongson2_clock driver when inserting it into the kernel:
> 
> "Feb 25 23:42:27 localhost kernel: [    4.965000] loongson2_clock: module
> license 'unspecified' taints kernel."
> 
> Reported-by: Liu Shiwei <liushiwei@gmail.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, applied.

  Ralf
