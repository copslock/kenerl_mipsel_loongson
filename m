Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:57:08 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:60031 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010897AbaJJW5G30316 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:57:06 +0200
Received: by mail-ig0-f175.google.com with SMTP id uq10so4570966igb.14
        for <multiple recipients>; Fri, 10 Oct 2014 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3EAGOYQ7gxb24Q/CK+2yf4mYvniWRtsVSA53HtEm6cs=;
        b=tkgzSs3STmw1BGWxrGCz7yoF84BuOX/DiJC6O41+5qSk8PIOXn+oKG8ffZM/SYs2VM
         ZvBfpaDttZ1gksERcnk6vl+z1pFdQxDVHMAGxyBlUXe51IHGp5MBnsLkT4jPNiWyc4UE
         aijUfbRUo5c7FVRSYOztT0GNh5foCbXE/yWHcYo3mAPO8L9YOMuD0npGVH4tAnHhziud
         v4JF7ZqLhjS3tvcCqInTI5oaI2EwDvkZp9pwA23l0D9HcGiKwX1oXAyntp9waDboeD8i
         K4MyjjtvmoB8EoFfqFXModF4aihoKvDyRrjkBB8lhVbPrWcJ+UN71L/8ro90hVnobeK9
         uHVw==
X-Received: by 10.50.66.170 with SMTP id g10mr11106400igt.10.1412981820222;
        Fri, 10 Oct 2014 15:57:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kj6sm2878746igb.6.2014.10.10.15.56.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 15:56:59 -0700 (PDT)
Message-ID: <54386438.9090606@gmail.com>
Date:   Fri, 10 Oct 2014 15:56:56 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        david.daney@cavium.com, peterz@infradead.org,
        paul.gortmaker@windriver.com, davidlohr@hp.com,
        macro@linux-mips.org, chenhc@lemote.com, richard@nod.at,
        zajec5@gmail.com, keescook@chromium.org, alex@alex-smith.me.uk,
        tglx@linutronix.de, blogic@openwrt.org, jchandra@broadcom.com,
        paul.burton@imgtec.com, qais.yousef@imgtec.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        markos.chandras@imgtec.com, dengcheng.zhu@imgtec.com,
        manuel.lauss@gmail.com, akpm@linux-foundation.org,
        lars.persson@axis.com
Subject: Re: [PATCH v2 2/3] MIPS: Setup an instruction emulation in VDSO protected
 page instead of user stack
References: <20141009195030.31230.58695.stgit@linux-yegoshin> <20141009200017.31230.69698.stgit@linux-yegoshin> <20141009224304.GA4818@jhogan-linux.le.imgtec.org> <543715D7.1020505@imgtec.com> <20141009234044.GB4818@jhogan-linux.le.imgtec.org> <5437232F.60800@imgtec.com> <20141010100334.GD4818@jhogan-linux.le.imgtec.org> <5438621C.8020708@imgtec.com>
In-Reply-To: <5438621C.8020708@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43237
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

On 10/10/2014 03:47 PM, Leonid Yegoshin wrote:
> On 10/10/2014 03:03 AM, James Hogan wrote:
>> I just mean an (illegal/undefined) sequence of FPU branch instructions
>> in one anothers delay slots shouldn't be able to crash the kernel.
>> Actually 2 of them would be enough to verify the kernel didn't get too
>> confused. Maybe the second will be detected & ignored, or maybe it
>> doesn't matter if the first emuframe gets overwritten by the second
>> one from the kernels point of view.
>
> Yes, I am looking into that sequences. I try to keep both emulators
> isolated from the rest of kernel and from each other as much as possible
> but intercalls via illegal combinations are still possible.
>
>
>  > From Peter Zijlstra:
>
>  > Right, look at uprobes, it does exactly all this with a single page.
>  > Slot allocation will block waiting for a free slot when all are in use.
>
> I don't see a reason to change my 300 lines design into much more
> lengthy code. That code has more links to the rest of kernel and high
> possibility to execute atomic operation/locks/mutex/etc - I can't do it
> for emulation of MIPS locking instructions.
>

It isn't just the number of lines of code that is important.

Doesn't your solution consume an extra page for each thread requiring 
emulation?  That could be a significant amount of memory in a system 
with many threads.

Are you are using this to emulate atomic operations in addition to FPU 
branch delay slot instructions?  Where is the code that does that?

David Daney

> - Leonid.
>
>
>
