Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:51:16 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:47010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011471AbcAYWvO25QoU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2016 23:51:14 +0100
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DAFC65A6A72;
        Mon, 25 Jan 2016 14:51:08 -0800 (PST)
Date:   Mon, 25 Jan 2016 14:51:08 -0800 (PST)
Message-Id: <20160125.145108.1332641183366177944.davem@davemloft.net>
To:     luto@kernel.org
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        cmetcalf@ezchip.com, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
        <cover.1453759363.git.luto@kernel.org>
        <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Jan 2016 14:51:09 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 25 Jan 2016 14:24:16 -0800

> On sparc64 compat-enabled kernels, any task can make 32-bit and
> 64-bit syscalls.  is_compat_task returns true in 32-bit tasks, which
> does not necessarily imply that the current syscall is 32-bit.
> 
> Provide an in_compat_syscall implementation that checks whether the
> current syscall is compat.
> 
> As far as I know, sparc is the only architecture on which
> is_compat_task checks the compat status of the task and on which the
> compat status of a syscall can differ from the compat status of the
> task.  On x86, is_compat_task checks the syscall type, not the task
> type.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
