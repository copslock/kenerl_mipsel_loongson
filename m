Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 17:26:23 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:39134
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994609AbeDTP0PppFIW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 17:26:15 +0200
Received: by mail-qt0-x244.google.com with SMTP id l8-v6so10087613qtp.6;
        Fri, 20 Apr 2018 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CyP1EJqXjqmFw/Kh4PH8s6bdg75GcZhLALy945yCAo4=;
        b=NYy8dM2zVexniYlx/GlUzBMHCoMavGd04aOr5FXgzwlU0nylcjvo/+viWJ+SD24zZs
         SwgGHEOloEdrLDUFCX8QR9NE5DbRMQm+PQkE2cYfDA9EHp0kTXA1MGHUU+0nYuGR3BBP
         6nhQoXV4aZs/sS5VdkmaRIesHROTwZqY4W8cvlIbHNGjdFut6rmS9gHXjM8wI2xop8XJ
         Rf4NWCY5TNq+rcpe9ZtCRBGi9o1lrII5Y7/SDM7yyGNkm0aNhi1SmLuCFU3RwqY551HQ
         ObXC2DT1BdcWHBqc1usUex8AqieaKZ3fXBxLI9sJjbYXKiB49XtA6qu7tf9Xp9XrtvTJ
         5E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CyP1EJqXjqmFw/Kh4PH8s6bdg75GcZhLALy945yCAo4=;
        b=hzZHV70d2HRZxBDfirFzpibcG/dprImH5jrK+LQvqHbcsVe/R1BStGbZM0+weEalZU
         bwr/OT/3gFftvtLrnxDfhzOjbQW1dTaL1r2X654b7o/bph5B03xCU67TJeekE1nS0nBp
         nizwN9WwKEOeo94gptu5dvgrdnF1a3loM3le8hejHHt+30UNY1cowG9OWpfzBxoTMkvs
         p9ETwXYR8D4Iira96gUfLu0BRxFwuvJTFwhVjUsvMtwuv8NzuRgsG7YnGCbH7cYAiJdR
         eBdJgQ5dmgNNxJMchv+v7Q7CGW22aA+JuRcAh+8PnVmQQdk5CJ9Xl18G98neHVCeG+gG
         SF5g==
X-Gm-Message-State: ALQs6tDxcUaABw6R5bD5IDie936zUHcQStEcoD80EjeXB4hKuLbxD4Hn
        CWR8YBOSsZKVhWnDpo3wKxXBBnAO7zheeY8QP7S3Dvpj
X-Google-Smtp-Source: AB8JxZrRS4DLIo+Y9v4t59ugQ8j9fAkVk+8ILL2m9H75am3diu4sY9hClhB1YWEoNZvL2m2C3xYz2MgzI9nSiqKoNlY=
X-Received: by 2002:ac8:1c12:: with SMTP id a18-v6mr11789078qtk.280.1524237969665;
 Fri, 20 Apr 2018 08:26:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Fri, 20 Apr 2018 08:26:09 -0700 (PDT)
In-Reply-To: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
References: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Apr 2018 17:26:09 +0200
X-Google-Sender-Auth: N8YcutgJ7sNr94zJbIXwkDoM4Q8
Message-ID: <CAK8P3a0BFJK-byNXC8jzxNHyPAC4s1oop06KhrXkr25Dund1Uw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: sni: Remove the read_persistent_clock()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63646
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

On Thu, Apr 19, 2018 at 9:21 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The dummy read_persistent_clock() uses a timespec, which is not year 2038
> safe on 32bit systems. Thus remove this obsolete interface.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Looks good to me. I have a larger but incomplete patch for arch/mips
handling of  read_persistent_clock(), but yours is a good start.

Acked-by: Arnd Bergmann <arnd@arndb.de>
