Return-Path: <SRS0=1rl1=SD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551FCC43381
	for <linux-mips@archiver.kernel.org>; Mon,  1 Apr 2019 00:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D15920879
	for <linux-mips@archiver.kernel.org>; Mon,  1 Apr 2019 00:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfDAABG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:01:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44842 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbfDAABG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 31 Mar 2019 20:01:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hAkNs-0005oR-Ht; Mon, 01 Apr 2019 00:01:04 +0000
Date:   Mon, 1 Apr 2019 01:01:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-mips@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [RFC] mips ptrace32.c and compat_ptr()
Message-ID: <20190401000104.GF2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

	There's something odd going on:

1)
static inline void __user *compat_ptr(compat_uptr_t uptr)
{
        /* cast to a __user pointer via "unsigned long" makes sparse happy */
        return (void __user *)(unsigned long)(long)uptr;
}

Huh?  The first impression is that it wants to sign-extend
the argument, but... compat_uptr_t is and always had been
unsigned.  Initially it went
+typedef u32            compat_uptr_t;
+
+static inline void *compat_ptr(compat_uptr_t uptr)
+{
+       return (void *)(long)uptr;
+}
so there never had been any sign-extension in that thing.
So what is that cast to long in the current version about?

2)
long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
                        compat_ulong_t caddr, compat_ulong_t cdata)
{
        int addr = caddr;
        int data = cdata;
...
                ret = put_user(tmp, (u32 __user *) (unsigned long) data);
                break;
and quite a few similar in the same function.  Here we _do_ get sign
extension.  Which is bloody odd, seeing that all other compat syscalls
end up using compat_ptr(), either explicitly or in the syscall glue.

Shouldn't it be doing
                ret = put_user(tmp, (u32 __user *)compat_ptr(cdata));
                break;
instead?
