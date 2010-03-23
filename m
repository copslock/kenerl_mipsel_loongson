Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2010 09:47:06 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:35421 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491841Ab0CWIrC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Mar 2010 09:47:02 +0100
Received: by vws13 with SMTP id 13so221168vws.36
        for <multiple recipients>; Tue, 23 Mar 2010 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=62kfMJCg+laX2QqZFDZK2lCizXBLqqnohcpQpLJoJ/A=;
        b=tAOtxMbTBllvqVawJjvprT2EeW7ZM/bqefxdwkOu3ouVeLJayAehuJoCgRKwLQNWGT
         ATsgaaY9Xg0eshiKpPiJEQz/wQJm2PdXCUaCt6C2GpwcaT9hXwCxhC3QMpK/wOXZcn0s
         dr0l+4ny0AW1GABHUrop7luOQ500exkoxtudY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=PJOhEaKRE+kMAb++2Yc3QphiaYKLC1UQk37gYC2u/zKSibSAO5RLZ5vZ1Nt3UJo6w9
         +EhXkWEbWuM0Jisx2l/m79PDa66c+YNiXpNEGnIDL9pw7bGIutAJN4ba0+EL3s2n5HFi
         TKaQZY2F/uBnSsI+1ZKdRKnkad12LPv5WE7A4=
MIME-Version: 1.0
Received: by 10.220.116.129 with SMTP id m1mr4067548vcq.7.1269334013290; Tue, 
        23 Mar 2010 01:46:53 -0700 (PDT)
Date:   Tue, 23 Mar 2010 17:46:52 +0900
Message-ID: <28c262361003230146o7bca61e6h3af2062b1172fdb2@mail.gmail.com>
Subject: data consistency of high page
From:   Minchan Kim <minchan.kim@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Namjae Jeon <linkinjeon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <minchan.kim@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minchan.kim@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf.

Below is thread long time ago.
At that time, we can't end up the problem by some reason.
Sorry for that.

The problem would occur, again.

On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:
>
>> Many code of kernel fs usually allocate high page and flush.
>> But flush_dcache_page of mips checks PageHighMem to avoid flush
>> so that data consistency is broken, I think.
>
> What processor and cache configuration?
>
>> I found it's by you and Atsushi-san on 585fa724.
>> Why do we need the check?
>> Could you elaborte please?
>
> The if statement exists because __flush_dcache_page would crash if a page
> is not mapped.  This of course isn't correct but that wasn't a problem
> since highmem still is only supported on machines that don't have aliases.
>
>  Ralf
>

Our system is following as.

mips 34ke
primary i-cache 32kB VIPT 4way 32 byte line size.
primary d-cache 32kB 4way  32 bytes linesize

If you have further questions, Namjae, Could you follow question of Ralf?

-- 
Kind regards,
Minchan Kim
