Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 14:26:45 +0100 (CET)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:36267
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbdAPN0iGdIsv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 14:26:38 +0100
Received: by mail-oi0-x244.google.com with SMTP id u143so12449456oif.3
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2017 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ulbNEeCNc9Wx7BfhuN6aNL/NlbalvJc7SZYOMe3kxmo=;
        b=q2ttdO6Nhfs6yrVjNblCat17SRVeirsYThLzUGEU0ozGYx/AYulRakj3Qe9ksE40oH
         SkYRzShDia36Gv9bN6lG6L/4u6gxS2gyNLk4fRkTP3zWdGzESpuOAbDTuTg3L5O4/crE
         QbwHtZQCSdbPb7o6spX/HymDepig4qWznyUuqbaHr0txUAPw8FEVRzs5PVkFGFMRDO9G
         +g6KLaz5NAj3kPQbQaVtH4yyNa7lbbvtNtN8Cd8320yTUZmqOMOxzqMIdEJdhpqJrU4t
         Wm7v6bOwXE9Ex5YUwJkJ23S9oKNu7zdHjhgtFQfZPWLeITP4foVT7CIbEsVVtORek4HW
         4XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ulbNEeCNc9Wx7BfhuN6aNL/NlbalvJc7SZYOMe3kxmo=;
        b=WlNtkQF6JpMW/dv+E6eXVacirM2flRwL7ogDTiJvAbY6ua3DcBHzayx0FsI17PWkhD
         zC99yxIe3AOxz6324Jk3DW2xy+AS83UlZiJ44Ylb10SFqrOUfUDoVi8uLd3I0lSQlFtl
         7cIagDJYlGZEg012xPpiJ/cMdjn2uY9+QZRMZGWR4IWXmL35TCWLRn9yJmxAOBI7W4jr
         OYTs4V5UaIQFc82D370Dwi5b5n1EMfO9be6gSoJKTgwgikM65P5AQfVziO9/ee2guxpH
         5Ir/Q6vqBlAfP/RpS/jOWOpRjlZq5jBik/Xl5sht42yqWRjf9MbDqoYSQGrmVd+rAWql
         RF1g==
X-Gm-Message-State: AIkVDXKSF1NJflg+fPGi2lQSlwCq8b7s4dPOjAObWq1OpJ43xxg2gaUsOsB6ccUpQMkN8x1WfugBzvuX4/4WJw==
X-Received: by 10.202.51.8 with SMTP id z8mr15774289oiz.79.1484573192269; Mon,
 16 Jan 2017 05:26:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.162 with HTTP; Mon, 16 Jan 2017 05:26:31 -0800 (PST)
In-Reply-To: <s5hd1fnxk6v.wl-tiwai@suse.de>
References: <20170116110517.3833976-1-arnd@arndb.de> <s5hd1fnxk6v.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Jan 2017 14:26:31 +0100
X-Google-Sender-Auth: 4aS6CskDuf8v0nRhoi1e4dDSNys
Message-ID: <CAK8P3a21FY+4S1zONxnE28eVDmmHTcyR5ymiFJ2Y7X-CxZBAMA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: mips: avoid potential uninitialized variable use
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Jan 16, 2017 at 1:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 16 Jan 2017 12:04:56 +0100,
> Arnd Bergmann wrote:
>> It's easy enough to avoid by adding a 'default' clause to the switch
>> statements here. I assume that in practice no other case can happen,
>> but adding a default puts us on the safe side and shuts up the warnings.
>
> Well, these cases are logical errors that must not happen, so
> returning an error would be a "safer", IMO.

Agreed. I sent out a v2 now.

    Arnd
