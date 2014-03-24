Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 16:36:36 +0100 (CET)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46556 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816877AbaCXPgdhsI1q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 16:36:33 +0100
Received: by mail-wi0-f171.google.com with SMTP id hr14so1050546wib.10
        for <multiple recipients>; Mon, 24 Mar 2014 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8zBesKwFnhUiJc9L5Qe4WUPcAD87SgH6WTiIJ+TIW3o=;
        b=l4crWYPh5vY9g+D673JcNq5+kyGe0ZfI7M2i6Gk4bP32cKy9AJHCzUJDz3WUMpvZdQ
         Lyd6vtWLGRF+DpiXqwfSGF7zITng4p+urSBoMEYjuex7+Yv+06ImfHNGDd584d4C4ajt
         UxV53/2v7qRU2UHpUjbjyhUj47tBYNmHPsFDhrKrf3zhGxvMmrpqRLrVakIVt2G8hEUe
         zIrN4bL+06Pq2S7h1mltJ2xQTbpiP4yz3bpdX4qg6kDCIINFOL+ZUKNMKEoWlrWFKapl
         JmkQvSYOpS96hqCIKK4NrvEIrDBfxuFTANgXUVhJCcTnsMKyOQ8CYk67FMMf2qhJs6vR
         h2mA==
X-Received: by 10.180.211.208 with SMTP id ne16mr16695559wic.21.1395675388185;
 Mon, 24 Mar 2014 08:36:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.148.136 with HTTP; Mon, 24 Mar 2014 08:35:48 -0700 (PDT)
In-Reply-To: <20140319235038.GJ17197@linux-mips.org>
References: <1393173460-840-1-git-send-email-manuel.lauss@gmail.com> <20140319235038.GJ17197@linux-mips.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 24 Mar 2014 16:35:48 +0100
Message-ID: <CAOLZvyE=jY=dX3bgTRMPd90-pBDKvyWUY7uWrHm=PZ1Bf3bPDg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: remove SYS_SUPPORTS_APM_EMULATION
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39574
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

On Thu, Mar 20, 2014 at 12:50 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sun, Feb 23, 2014 at 05:37:40PM +0100, Manuel Lauss wrote:
>
>> Subject: [PATCH] MIPS: remove SYS_SUPPORTS_APM_EMULATION
>>
>> nothing in the MIPS tree needs it, so get rid of it.
>
> See https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060605154310.GF27426%40enneenne.com
>
> I think the reasons for thi code is still standing - suspend through
> apm(8) though that's an antiquated interface.

Oh okay, I'll leave it in then.  I dug up the apmd source, and
surprisingly suspending
via APM still works, provided you set a wakeup source first (Alchemy).

Manuel
