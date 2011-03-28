Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 17:13:36 +0200 (CEST)
Received: from hall.aurel32.net ([88.191.126.93]:42610 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S2100586Ab1C1PNd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Mar 2011 17:13:33 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.72)
        (envelope-from <aurelien@aurel32.net>)
        id 1Q4E8J-0006jA-He; Mon, 28 Mar 2011 17:13:31 +0200
Date:   Mon, 28 Mar 2011 17:13:31 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Chen Jie <chenj@lemote.com>
Cc:     linux-mips@linux-mips.org, wuzhangjin@gmail.com
Subject: Re: [Bug]syscall fanotify_mark is broken when called indirectly in
 o32 user land + n64 kernel.
Message-ID: <20110328151331.GZ8929@hall.aurel32.net>
References: <AANLkTi=JAe5Z2TZZ+-TqtehWvP=HTh46koXz+y=fTEKf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <AANLkTi=JAe5Z2TZZ+-TqtehWvP=HTh46koXz+y=fTEKf@mail.gmail.com>
X-Mailer: Mutt 1.5.20 (2009-06-14)
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Mon, Mar 28, 2011 at 12:19:39PM +0000, Chen Jie wrote:
> Hi all,

Hi,

> In an o32 user land + n64 kernel, calling 'fanotify_mark' indirectly
> will always fail due to alignment[1]:
> syscall(_NR_fanotify_mark, fanotify_fd, flags, mask, dfd, pathname)
> 
> The prototype of fanotify_mark is "fanotify_mark (int fanotify_fd,
> unsigned int flags,  __u64 mask, int dfd, const char  __user *
> pathname)", which has a 64bit argument.
> 
> In the case of o32 user land + n64 kernel and indirect syscall:
> 1. User calls libc routine syscall(...), MIPS ABI enforce a padding
> word before argument 'mask' to make it 64bit-aligned. The padding word
> resides at a3 register.
> 2. Kernel fetches 4 32bit arguments from a0-a3, and then 4 32bit
> arguments from stack.
> 3. Kernel shifts arguments by one, then redirects to sys_32_fanotify_mark.
> 4. sys_32_fanotify_mark synthesizes the 64bit argument 'mask' by
> merge_64(a2, a3), note a2 is the padding word, so the synthesized
> argument is invalid.
> 
> The syscall routine in libc doesn't know the prototype, so it can't do
> anything. It seems the bug of syscall handling code, any idea?
> 

I can confirm the issue, however it is not specific to a n64 kernel.
Even with an o32 kernel the issue is present. I also have been able to
reproduce the issue on other architectures, like PowerPC.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
