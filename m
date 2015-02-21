Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 09:24:27 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43387 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006620AbbBUIYZ50FTj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 09:24:25 +0100
Received: by iebtr6 with SMTP id tr6so13109944ieb.10
        for <linux-mips@linux-mips.org>; Sat, 21 Feb 2015 00:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nY6npJhfNKnNQe0SMlZHfRUV9wpXOyxGg370MyQ1H8I=;
        b=OV5+mjZsTziZEkmJ1fGpz6YYd4pFVv//mEYP1KPAMPS7e4xMjSFkGm6GzzCIIw1PnS
         Ya7SSVWu0eLjLMl8uFkO6HvUQKzWZLpCKmblApMv5p9jW3Amhc1ioZndFsf/Hgzx6jbA
         06oSSdXtYxQVEX6SPudq2RUOKXu3ZCzlJ0nWGAneyzg0F0ydKUZrHlwtXlUOjr+EULI0
         smITBLhmyGjB4yoqh4ppIVMyiZgp7ctaez3yACg8oMvv6ruRhCAKv2VJc5/BhPz7or5u
         TH7TLRc4dZNTE3NASAEt/6vg5NB7YjeSjagOw58+nVdn6gbVE9TecGkWY0CqXtefGDlX
         T/Wg==
X-Received: by 10.42.68.5 with SMTP id v5mr1904278ici.89.1424507060545; Sat,
 21 Feb 2015 00:24:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.31.76 with HTTP; Sat, 21 Feb 2015 00:23:39 -0800 (PST)
In-Reply-To: <alpine.LFD.2.11.1502210258580.5732@localhost>
References: <alpine.LFD.2.11.1502200445290.26212@localhost>
 <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com>
 <CAEdQ38F5jWX8Ujs4Jj6scxPAqtZw55gn4exL_rj9HCmf5YJgCA@mail.gmail.com> <alpine.LFD.2.11.1502210258580.5732@localhost>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Sat, 21 Feb 2015 09:23:39 +0100
Message-ID: <CAOLZvyFKc4fu6F5qOuzaAJg9wvkKhYrFcV35Vn1Hzo_sYVYfvQ@mail.gmail.com>
Subject: Re: what is the purpose of the following LE->BE patch to arch/mips/include/asm/io.h?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Matt Turner <mattst88@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45874
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

On Sat, Feb 21, 2015 at 9:11 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   has anyone else ever needed to do this? or is this some weird,
> one-off hack that perhaps applies *only* to some bizarre feature of
> this board?

My guess isthat the peripherals attached to the internal bus
only undestand little endian, and the bus doesn't do byte swaps when
the core isn't configured for LE. I.e. the BE feature is only
implemented in the mips core and the rest was designed for LE only.

Manuel
