Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 02:59:46 +0000 (GMT)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.192]:3201 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225409AbVA1C7b>;
	Fri, 28 Jan 2005 02:59:31 +0000
Received: by rproxy.gmail.com with SMTP id c51so376444rne
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 18:59:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=OkGRGhH+ZFplJfK3kaFs3LWziHMJo0yfXII9a1pIA5Kupm618XGVO2kfb8GGhX64r4TIbEW2LbAgOFy9iBmZccPJmh4E4Cfps+H/N3mMp4TcTo5e+GEdq75Ef/gzCe9fHJEObm4t0+wk8tdXcl7e42OwvgYHmiUEZf7pk8RPUjo=
Received: by 10.38.101.53 with SMTP id y53mr125237rnb;
        Thu, 27 Jan 2005 18:59:26 -0800 (PST)
Received: by 10.38.66.9 with HTTP; Thu, 27 Jan 2005 18:59:26 -0800 (PST)
Message-ID: <73e62045050127185929c3bdf7@mail.gmail.com>
Date:	Fri, 28 Jan 2005 10:59:26 +0800
From:	zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Why does MIPS/Linux always reserve 32 bytes in the top of each process's kernel stack space
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <zhanrk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhanrk@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, everyone:

Why does MIPS/Linux always reserve 32 bytes in the top of each
process's kernel stack space.

See arch/mips/kernel/process.c:

int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
	unsigned long unused, struct task_struct *p, struct pt_regs *regs)
{
	struct thread_info *ti = p->thread_info;
	struct pt_regs *childregs;
	long childksp;

	childksp = (unsigned long)ti + THREAD_SIZE - 32;
        ......
}

-- 
Rongkai Zhan
