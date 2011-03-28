Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 16:50:02 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.141]:33602 "EHLO lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491814Ab1C1Ot6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Mar 2011 16:49:58 +0200
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id 9D82D31D666
        for <linux-mips@linux-mips.org>; Mon, 28 Mar 2011 20:01:40 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z1RV0Jxm-0W7 for <linux-mips@linux-mips.org>;
        Mon, 28 Mar 2011 20:01:30 +0800 (CST)
Received: from mail-fx0-f49.google.com (mail-fx0-f49.google.com [209.85.161.49])
        by lemote.com (Postfix) with ESMTP id 8840C31D65B
        for <linux-mips@linux-mips.org>; Mon, 28 Mar 2011 20:01:29 +0800 (CST)
Received: by fxm14 with SMTP id 14so2369097fxm.36
        for <linux-mips@linux-mips.org>; Mon, 28 Mar 2011 05:19:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.14.197 with SMTP id h5mr4231377faa.14.1301314779106; Mon,
 28 Mar 2011 05:19:39 -0700 (PDT)
Received: by 10.223.116.194 with HTTP; Mon, 28 Mar 2011 05:19:39 -0700 (PDT)
Date:   Mon, 28 Mar 2011 12:19:39 +0000
Message-ID: <AANLkTi=JAe5Z2TZZ+-TqtehWvP=HTh46koXz+y=fTEKf@mail.gmail.com>
Subject: [Bug]syscall fanotify_mark is broken when called indirectly in o32
 user land + n64 kernel.
From:   Chen Jie <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     aurelien@aurel32.net, wuzhangjin@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
Precedence: bulk
X-list: linux-mips

Hi all,

In an o32 user land + n64 kernel, calling 'fanotify_mark' indirectly
will always fail due to alignment[1]:
syscall(_NR_fanotify_mark, fanotify_fd, flags, mask, dfd, pathname)

The prototype of fanotify_mark is "fanotify_mark (int fanotify_fd,
unsigned int flags,  __u64 mask, int dfd, const char  __user *
pathname)", which has a 64bit argument.

In the case of o32 user land + n64 kernel and indirect syscall:
1. User calls libc routine syscall(...), MIPS ABI enforce a padding
word before argument 'mask' to make it 64bit-aligned. The padding word
resides at a3 register.
2. Kernel fetches 4 32bit arguments from a0-a3, and then 4 32bit
arguments from stack.
3. Kernel shifts arguments by one, then redirects to sys_32_fanotify_mark.
4. sys_32_fanotify_mark synthesizes the 64bit argument 'mask' by
merge_64(a2, a3), note a2 is the padding word, so the synthesized
argument is invalid.

The syscall routine in libc doesn't know the prototype, so it can't do
anything. It seems the bug of syscall handling code, any idea?



Regards,
Chen Jie
-------
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=%23618562
