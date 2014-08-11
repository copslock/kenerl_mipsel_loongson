Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2014 13:49:52 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63308 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842441AbaHKLtt0NkjY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2014 13:49:49 +0200
Received: by mail-pa0-f51.google.com with SMTP id ey11so11037617pad.10
        for <linux-mips@linux-mips.org>; Mon, 11 Aug 2014 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type;
        bh=IMilvnHu8rkcFlvSvXPbw4+W7hE+loBQEKX33MUWJKE=;
        b=UyYPM4cId01caIqqz+esiJMW7KqFTLkhEgDQyTHhzPNYTXwTYdnOw2hCrZ+9n/UYYL
         In454BXQuDIjcjYgK3NiU2anFPzYHpWin/SEZFIie3kj08UMNEY3WKetpiSSfzKj5ntW
         DCkz1xrVkS49qZs/exibgpZPIJpnccR+vnq3a5QtG8oCWrLyRxuwW0fp/2a9dQNz5TgW
         eWyIapryFoIhuIXJmtJ62hIdJfPtC2jZCo2Muv9/h5Wd/Ncl0wz4o+AU7+ddQpgdY3Fa
         ThPRPBtPdNy5RoGeFxDVG1DeelEHElImphTsdlY/BlLjMEE444XO2D+n6yMh02hDvC5/
         hgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=IMilvnHu8rkcFlvSvXPbw4+W7hE+loBQEKX33MUWJKE=;
        b=T3amgA4SvWrJ53jRDqLmUZvll1IGrk++OOfo1uxQfWRLpfW+NzaWI9D1jyIfCDi1VK
         7cUwJN3FIYiIzmPi1x0TG+Iyi9UQiPOm9OaZ6MPPHDvWsyUWjGiw1u1zE01wuTZNgKbr
         MjWyEA8tYyqifSPZ3LkGbvqeDvMXebcvLOzMZ7Gw/IRL0uY45ObHPwm03v8oFlKtcAGV
         WEzFcuZXZfCZVBi8LlfTGJMiFRLgsecdrDO/ycPw+TBYZzstiN3jJ0S8aDVlSB5+2SVA
         lkeI7bC1LcAGrcVtCSjoqg9p3XUVg9wLgnpje+xkiRGUF3hSyHeXRkJs1xuWAbp+48PD
         tDFQ==
X-Gm-Message-State: ALoCoQl4/AVH7ciXelsMRXckQMnTJqBExOEfbMXcyipyuvuL1m53x8+3gZEM4c2pUzifizeAur1W
X-Received: by 10.66.141.109 with SMTP id rn13mr8266393pab.117.1407757782253;
        Mon, 11 Aug 2014 04:49:42 -0700 (PDT)
Received: from [2620:0:1008:1101:2967:b07:591f:1923] ([2620:0:1008:1101:2967:b07:591f:1923])
        by mx.google.com with ESMTPSA id h10sm1384389pat.11.2014.08.11.04.49.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 04:49:41 -0700 (PDT)
Date:   Mon, 11 Aug 2014 04:49:40 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Manuel Lauss <manuel.lauss@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: MIPS: hang in kmalloc with seccomp writer locks
In-Reply-To: <CAOLZvyFuDqi4+pEae=n7+ZJoAx-vca-pRS8ZAQqvTk-tSyPiwg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1408110448470.15519@chino.kir.corp.google.com>
References: <CAOLZvyFuDqi4+pEae=n7+ZJoAx-vca-pRS8ZAQqvTk-tSyPiwg@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
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

On Mon, 11 Aug 2014, Manuel Lauss wrote:

> Hi Kees,
> 
> My MIPS32 toys hang early during bootup at the first kmalloc() with
> seccomp enabled.
> I've bisected it to commit dbd952127d11bb44a4ea30b08cc60531b6a23d71
> ("seccomp: introduce writer locking").  And indeed, reverting this
> commit fixes the hang.
> 
> I'm not sure if seccomp is even working on MIPS, but I've never had
> problems with
> it before so I thought I let you know.
> 

Does enabling CONFIG_DEBUG_SPINLOCK fix the issue?
