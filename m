Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2014 14:03:38 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59298 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860174AbaHKMDe50XOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2014 14:03:34 +0200
Received: by mail-wi0-f173.google.com with SMTP id f8so4100826wiw.6
        for <linux-mips@linux-mips.org>; Mon, 11 Aug 2014 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UAM4538z4K9OoNzRA41Us2ajrvHqviVpSmUbjiTZb98=;
        b=e4TF6iuBYdpYs1TGFNMbwr5zBYPuFS8qNTVu5dtWH7lWknD51xEB8sydjlTXIMKV1i
         NKBgewiww6lHheAoK7R29PPL/tn87f+SlAr68b3h7JJn13xty1Jaj7DZlALNNlmW6U4S
         NsPHpgqIompQMoGFMFMZZ4E/SkQG1cvzE7VFGuEuJCZKqpf1gLwuFoNPuPe1HDvJcsRs
         7KL0de6xbj2Mxjpqhm+5SObULjLNqjr8QqtP/9oLUALG24f435zbBiHtZBKtselnlyiy
         gSwe9GSVjHTeNOtfIDlb1XkxPX63Ycf4kv5SNQvPnQcSOC6+xn2dEmkN1okEhKziQ8WX
         5mDw==
X-Received: by 10.180.104.42 with SMTP id gb10mr24854088wib.65.1407758609689;
 Mon, 11 Aug 2014 05:03:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.36.67 with HTTP; Mon, 11 Aug 2014 05:02:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1408110448470.15519@chino.kir.corp.google.com>
References: <CAOLZvyFuDqi4+pEae=n7+ZJoAx-vca-pRS8ZAQqvTk-tSyPiwg@mail.gmail.com>
 <alpine.DEB.2.02.1408110448470.15519@chino.kir.corp.google.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 11 Aug 2014 14:02:49 +0200
Message-ID: <CAOLZvyGUBy_aezR32kUiwGSpT0CJhK9_b6_ApCi8GJwJAQNpQw@mail.gmail.com>
Subject: Re: MIPS: hang in kmalloc with seccomp writer locks
To:     David Rientjes <rientjes@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Aug 11, 2014 at 1:49 PM, David Rientjes <rientjes@google.com> wrote:
> On Mon, 11 Aug 2014, Manuel Lauss wrote:
>
>> Hi Kees,
>>
>> My MIPS32 toys hang early during bootup at the first kmalloc() with
>> seccomp enabled.
>> I've bisected it to commit dbd952127d11bb44a4ea30b08cc60531b6a23d71
>> ("seccomp: introduce writer locking").  And indeed, reverting this
>> commit fixes the hang.
>>
>> I'm not sure if seccomp is even working on MIPS, but I've never had
>> problems with
>> it before so I thought I let you know.
>>
>
> Does enabling CONFIG_DEBUG_SPINLOCK fix the issue?

Yes it does indeed.


Manuel
