Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2015 21:54:35 +0100 (CET)
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:60277 "EHLO
        exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011026AbbAXUyeAqmXJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2015 21:54:34 +0100
Received: from mail-lb0-f171.google.com ([209.85.217.171]) (using TLSv1) by exprod5ob110.postini.com ([64.18.4.12]) with SMTP
        ID DSNKVMQGhifMVWIh6Qjbepv1LIMBHsl7BoyG@postini.com; Sat, 24 Jan 2015 12:54:33 PST
Received: by mail-lb0-f171.google.com with SMTP id u14so2624764lbd.2
        for <linux-mips@linux-mips.org>; Sat, 24 Jan 2015 12:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PaP4/mk3XTebE/LXluffvr1WO0UN1Gawmz43V/dwC/A=;
        b=NsxygfnRl5DFoz2dA5IiGzHHsKcDzUXu7fO5u9aBJMt2XN+HxTq+jvaKFT6k2cgJdq
         AfPXPNKmXgzcM8LFgK1KU8S7IPlvjThHoMlC/GGL9pCTl7YkU2+WF/WC6PGbybETLjSE
         p/f45q5c02iRyvl+liYHFnKU1wZn6Txq8cXBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PaP4/mk3XTebE/LXluffvr1WO0UN1Gawmz43V/dwC/A=;
        b=TmevyF+u6SQWEdajIx0hXAlhc4QxBI7u9zhlaV3cCtJQXN4EClqRz5owO9ka40788A
         4EJLx+xl5Yzp+MH//HoZvqvQdJ29y/npEuvhNxliYRMjm0GSF8rVQKasEOwT6PR6QIjz
         0uTBluAscAR4blaBGJKvT6Q0NJfjUgKPlY6Ye/An2wawmm8u6B5es6cuOvX3WinkbM+j
         Pda4FKfUoADr4E3KdytjiRNE/iGJlawKeo9qjDCHZeot0C283a3o0WwWzAgscsgcNDv+
         DtmMNQaA/lmq/i8ftdJkWQCpy575TNlEWVET34aqnF3NvC8uKYW7HRbouavFRXIb7FwG
         zASQ==
X-Gm-Message-State: ALoCoQmugBoQ1NwDd+169RfTTq6fR4+SsTvYCzGH3PYJVkq4bjTL7tO7T8wkD2HIrvuh/jQczaukdKNZYS2V+Q9yZIsIEhKa/Op9z2AIqWT8lcw4sGXeDzA3bCSY/OVRQdGn3vNWq4J9X1opBobHh+eI6aX4KfVxXQ==
X-Received: by 10.112.156.169 with SMTP id wf9mr13785265lbb.85.1422132869097;
        Sat, 24 Jan 2015 12:54:29 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.112.156.169 with SMTP id wf9mr13785252lbb.85.1422132868994;
 Sat, 24 Jan 2015 12:54:28 -0800 (PST)
Received: by 10.25.41.78 with HTTP; Sat, 24 Jan 2015 12:54:28 -0800 (PST)
Reply-To: semen.protsenko@globallogic.com
In-Reply-To: <1422118156.27947.7.camel@x220>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
        <1422118156.27947.7.camel@x220>
Date:   Sat, 24 Jan 2015 22:54:28 +0200
Message-ID: <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
Subject: Re: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
From:   Sam Protsenko <semen.protsenko@globallogic.com>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Russell King <linux@arm.linux.org.uk>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-am33-list@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <semen.protsenko@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: semen.protsenko@globallogic.com
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

> That's news for me. I thought they are silently ignored. Do you have an
> example of such a warning?

Not really. It was just assumption. It seems you are right, they are just
ignored silently. But item 2 is still relevant and it was actually confused
me when I tried to figure out MTD configuration for my platform.
Anyway, garbage should be taken out from time to time.

> Seems like the kind of change that can only be reviewed by a script.

Good point. Because these patches were done by script to start with.
Anyway, I reviewed result patches manually to be completely sure.
You can write verifying script though, if you need to, it wouldn't take
more than 2 minutes (it takes one-liner, actually).

> I seem to remember Greg stating that defconfig files are on their way
> out. Did I remember that correctly?

Maybe they are. But they still in place, and why it's so, we should
maintain them up-to-date. Ideally, this kind of work should be done by
someone who introduces changes into Kconfig files. So I just fixed
that oversight.
