Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Aug 2013 19:57:35 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34369 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818999Ab3HaR52zN0-E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Aug 2013 19:57:28 +0200
Received: by mail-pa0-f52.google.com with SMTP id kq13so3557466pab.25
        for <linux-mips@linux-mips.org>; Sat, 31 Aug 2013 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G7G2qb3LaY7B8JdglXAH0q9nFAmpauXTuEbWBhboAHM=;
        b=yMDTAV/9UpzPbgandv0oIfrntCZ+yhdu99bAr/S2CSJbpe/O+BKiQSzUp0pEBAQR+E
         ghGKoXGrbnw3/MrLb5uyorZFnBnY3CjAVDsVFn7N0nxkracV710fckFpAANMyTgQxgg+
         DA9BRJWDkB7+3VpuQJq0asxiM+G8NbOmuFsKNh4et9AulgnvbED6oE92IDS7qnJN4WA+
         Usgi8RP92FB+k4ygw7Nz+iFr7Yd2NY276QucuEsNnDeBr1qlsT13TFA4LXGhJMYT7vrH
         ajoPwtlexpM8IHcrVe8V+eYARQE01n5HKWFQ4/3KduOplZyrybzAMJ8Ti/3wCV0NMZo/
         TVmQ==
MIME-Version: 1.0
X-Received: by 10.66.159.132 with SMTP id xc4mr17588548pab.27.1377971841956;
 Sat, 31 Aug 2013 10:57:21 -0700 (PDT)
Received: by 10.68.28.232 with HTTP; Sat, 31 Aug 2013 10:57:21 -0700 (PDT)
In-Reply-To: <5221C3FC.7090608@phrozen.org>
References: <1375350938-16554-1-git-send-email-jogo@openwrt.org>
        <20130801135505.GA3466@linux-mips.org>
        <CAOiHx=kZuzVu=ung9suwuoYr7F5LP-ghNFzwVSM_Zrc3i+=Q-g@mail.gmail.com>
        <5221C3FC.7090608@phrozen.org>
Date:   Sat, 31 Aug 2013 10:57:21 -0700
Message-ID: <CAJiQ=7DKZkAWB2H5xPhL0aEXB5ggzkO8266-GHYHOVrJR6kXPw@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: BMIPS: fix compilation for BMIPS5000
From:   Kevin Cernekee <cernekee@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Sat, Aug 31, 2013 at 3:22 AM, John Crispin <john@phrozen.org> wrote:
> Hi Kevin,
> Hi Florian,
>
>
>>> +       write_c0_ddatalo(3);
>>
>> I guess this needs to be write_c0_ddatalo(data);
>
> any comments on this ?

Commit 43d309390349010cd384ab5a0feebf16b03b9a94 from the
mips-for-linux-next branch has this fix (and the __ssnop -> _ssnop
renaming).  From comparing the assembly output it looks OK to me.
