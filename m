Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 10:44:05 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:40560 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491004Ab0JQIoD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 10:44:03 +0200
Received: by qyk4 with SMTP id 4so3115742qyk.15
        for <linux-mips@linux-mips.org>; Sun, 17 Oct 2010 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=dI/Ei73DxThl2ERxp2v7lf9vx3W19TRXvjCc5t/44vw=;
        b=Ep5tZe3R/1JmISNuqq4CewPOcOKYbifIP+K5RtEk2YpQkLQySlhwfiJIMYmbFsJSti
         zwq4AJ2reUfN5lwOOEAB+AlD+Jlp1C6sKQd4mwCVpCWsBGBvll62F02mu9K7iy+19Ffm
         qoDv6teI3BedfJPXpiKAwnopgfHcxqHY1KNqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uu4Zp3GVqERccww73aysTB+SwDtHKbiyZAO3YgvOERsMX1cQWaWzN/zwbhgVABsVkz
         I05WOXVitd9jaCfJ9MISriVThL/meCJoBdS/HClRmbN4mnFmrzgCkBF+sfpwj7T8nanA
         ANzs5yUn2ZOcPwB3iSIY8B6sEkHn6tMc3F1DI=
MIME-Version: 1.0
Received: by 10.229.97.141 with SMTP id l13mr2591368qcn.135.1287305037059;
 Sun, 17 Oct 2010 01:43:57 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Sun, 17 Oct 2010 01:43:57 -0700 (PDT)
In-Reply-To: <20101016155552.GE23119@capricorn-x61>
References: <AANLkTik4BddKpVm0x4EpCKCdUff0L=XiYRjfhJaPmX23@mail.gmail.com>
        <20101016155552.GE23119@capricorn-x61>
Date:   Sun, 17 Oct 2010 16:43:57 +0800
Message-ID: <AANLkTimkiwssyA=1Ub3qgekcsqECKPy+uuvFxkATqOmn@mail.gmail.com>
Subject: Re: Where is the definition of i_j macro ?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Adam Jiang <jiang.adam@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        chelly wilbur <wilbur512@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2010/10/16 Adam Jiang <jiang.adam@gmail.com>:
> Please dig into
>
> arch/mips/include/asm/uasm.h
>
> You'd better try "make cscope" and use emacs with the cscope
> database. It allows you to surfing the source code very fast.
>
> Best regards,
> /Adam
well, I didn't find uasm.h in 2.6.24.7. However , I found i_j macro to
be defined just in tlbex.c, which hands over to

I_u1(_j);  They just make up pieces of  asm opt code into a  string
and copy them to ebase:

memcpy((void *)ebase, final_handler, 0x100);


Why they did like this seemed strange to me, maybe in the
consideration of portability.
