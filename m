Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 20:05:55 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:62326 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010637AbaJFSFyZ7gEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 20:05:54 +0200
Received: by mail-ig0-f179.google.com with SMTP id h18so3257622igc.0
        for <multiple recipients>; Mon, 06 Oct 2014 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qOhfSbEMAeg1JoaXNYyKvrT+pvIup7iEP8fT4LtVwSo=;
        b=JinOl38IzyPYOvVfuYFTyeHptD3skQgh3+c9Hg3dXoKO5Oh3Fnt4K9q7jZX9Z5ZPt0
         Df1Jyc+2sy/r8jabuiIj2V0Fc1ZlwuatIQtKvbdvJwbkyouKeaB6GFOHx+ei00lQFqK8
         jXSfT/S+s7kq1v6uHymTTu0KUW7qB/20GGQWzjpKkGASairtNCZJQiLfJXUZDT6Q07xV
         hCOIXlMPUdJ/dSntIxWiT9ihoVO/2h+4Zwdd0Giw/nR7K5AjKengwJHdFfJKWnJMkzcb
         s88nbvk/uzS7f9AOqHnOadY2gb3ONcWYmgTcUF7zb2k7FFMXBSOQtIFF7uQBIpmXvWhe
         Owow==
X-Received: by 10.42.208.70 with SMTP id gb6mr5286202icb.89.1412618747861;
        Mon, 06 Oct 2014 11:05:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id a4sm10164449igv.1.2014.10.06.11.05.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 Oct 2014 11:05:47 -0700 (PDT)
Message-ID: <5432D9F8.9040004@gmail.com>
Date:   Mon, 06 Oct 2014 11:05:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     linux-mips@linux-mips.org, Zubair.Kakakhel@imgtec.com,
        david.daney@cavium.com, peterz@infradead.org,
        paul.gortmaker@windriver.com, davidlohr@hp.com,
        macro@linux-mips.org, chenhc@lemote.com, zajec5@gmail.com,
        james.hogan@imgtec.com, keescook@chromium.org,
        alex@alex-smith.me.uk, tglx@linutronix.de, blogic@openwrt.org,
        jchandra@broadcom.com, paul.burton@imgtec.com,
        qais.yousef@imgtec.com, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com,
        manuel.lauss@gmail.com, akpm@linux-foundation.org,
        lars.persson@axis.com
Subject: Re: [PATCH 2/3] MIPS: Setup an instruction emulation in VDSO protected
 page instead of user stack
References: <20141004030438.28569.85536.stgit@linux-yegoshin> <20141004031730.28569.38511.stgit@linux-yegoshin>
In-Reply-To: <20141004031730.28569.38511.stgit@linux-yegoshin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/03/2014 08:17 PM, Leonid Yegoshin wrote:
> Historically, during FPU emulation MIPS runs live BD-slot instruction in stack.
> This is needed because it was the only way to correctly handle branch
> exceptions with unknown COP2 instructions in BD-slot. Now there is
> an eXecuteInhibit feature and it is desirable to protect stack from execution
> for security reasons.
> This patch moves FPU emulation from stack area to VDSO-located page which is set
> write-protected for application access. VDSO page itself is now per-thread and
> it's addresses and offsets are stored in thread_info.
> Small stack of emulation blocks is supported because nested traps are possible
> in MIPS32/64 R6 emulation mix with FPU emulation.
>

Can you explain how this per-thread mapping works.

I am especially interested in what happens when a different thread from 
the thread using the special mapping, issues flush_tlb_mm(), and 
invalidates the TLBs on all CPUs.  How does the TLB entry for the 
special mapping survive this?

David Daney
