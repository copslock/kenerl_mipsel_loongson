Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 09:45:14 +0200 (CEST)
Received: from mail-bk0-f42.google.com ([209.85.214.42]:53272 "EHLO
        mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816511Ab3FSHpMkcjFP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 09:45:12 +0200
Received: by mail-bk0-f42.google.com with SMTP id jk13so2223354bkc.15
        for <multiple recipients>; Wed, 19 Jun 2013 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LH2NhKlPkmnHZxBagBZrVwiDVlwi+vGy07lzmNghOic=;
        b=jRGo3lWxhLcM4EWS1nGiI3CFu3vgvaEmnn5mK5uxb7BQuXwowwisH2m/Ta6fVFSYuF
         0GVtUC0GzemScDXxLuo03kIxKfiKyP+fiQ7Hjqq2DMtyTNwFlqoYSQ0c9rsEVWVa9YIx
         rtOOA8Q3Dw9BX2e+b+o1ytaqTH7vmu+Ot+nKdMnD0G9boRn92TpIpWBulBxDtRiU3xH2
         4p030LRfhcCuh+vv1BAaVIcqixRyOvcQDJ3XeiP7mdkTMA8il8NrhixkXe8o+d+iBY1L
         8bU4IlCB/jVrBiDrlwA0Mn6+HU4fXxEX4oWbEpiyplyhLXMKF2z8Tzzo3FmdrKiXixFg
         ryEw==
MIME-Version: 1.0
X-Received: by 10.205.46.131 with SMTP id uo3mr216355bkb.43.1371627907106;
 Wed, 19 Jun 2013 00:45:07 -0700 (PDT)
Received: by 10.204.174.8 with HTTP; Wed, 19 Jun 2013 00:45:07 -0700 (PDT)
In-Reply-To: <20130618141420.GA15141@linux-mips.org>
References: <1371564006-31805-1-git-send-email-markos.chandras@imgtec.com>
        <20130618141420.GA15141@linux-mips.org>
Date:   Wed, 19 Jun 2013 15:45:07 +0800
Message-ID: <CAECwjAhzJUO4GFmnu3jX8e-UEj2wiVrB8xA3Hu_0iSaf1L1v5w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking problems
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

I am not quite sure on this. I just digged this[1] out and thought that Linus
 may not be happy about the operation `tmp_user_dog/1000000`.

Correct me if I am wrong, please.

[1] http://lwn.net/Articles/456241/

On 18 June 2013 22:14, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jun 18, 2013 at 03:00:06PM +0100, Markos Chandras wrote:
>
>> Fixes the following linking problem:
>> drivers/watchdog/sb_wdog.c:211: undefined reference to `__udivdi3'
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
>> Cc: sibyte-users@bitmover.com
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> ---
>> This patch is for the upstream-sfr/mips-for-linux-next tree
>
> That looks ok.
>
> Wim, are going to merge this or shall I carry it?  If you take it,
> feel free to add my Acked-by.
>
> Thanks,
>
>   Ralf
>
