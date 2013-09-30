Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 21:03:37 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61558 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3I3TDfLKFVW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 21:03:35 +0200
Received: by mail-pd0-f178.google.com with SMTP id w10so6074733pde.37
        for <multiple recipients>; Mon, 30 Sep 2013 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6rNZKnhnbyhXwg3Bx1f10d/tJYLL3TJSYyyzYaDBRzg=;
        b=sx9/SM+d2jYmk0jvK0aH3cvNgwhKUs0EmK8u3ZUOsmIsgml0JXlkEb4aU1nHWUuuGK
         st5TSM+W0C1/5/OLrCeeqeUNsoP89VCAz5Svi3Xgg+25uOKiG7Xq14vWj7dijJ+v3gmx
         kLQUHDMemC4gk8mB4nq05mn7VfNTrjksF0powE9wPdv7CZS95MulpDBYX1hJnRWkuPkw
         N5qaazzz3lqfyFbHm5/XzdsiDZ4GMQzbeOwpeNbRqAGaUnbaHHxY+aiI88M6QruqBIhc
         bN/7tL8YETfKqegMOLt3/BePiRkzph3yvrE0t2H+godUB+WUhaTodcCfogT/gYeQ5xP9
         P2DQ==
MIME-Version: 1.0
X-Received: by 10.66.146.199 with SMTP id te7mr29876885pab.106.1380567808149;
 Mon, 30 Sep 2013 12:03:28 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Mon, 30 Sep 2013 12:03:28 -0700 (PDT)
In-Reply-To: <5249B8A4.9070905@gmail.com>
References: <20130930145630.GA14672@linux-mips.org>
        <52499E8B.6000702@gmail.com>
        <C9BC92C2-A7F5-4F9A-B001-D1A7F4ADEA5A@caviumnetworks.com>
        <5249B8A4.9070905@gmail.com>
Date:   Mon, 30 Sep 2013 21:03:28 +0200
X-Google-Sender-Auth: vTNrIrX0tFM5HCJKKGLjTJ5wU8o
Message-ID: <CAMuHMdXkb6BH=1QvfHwMN54db9mP64KnCgoAj3aXida7-6OtPA@mail.gmail.com>
Subject: Re: Issue with BUG() in asm-gemeric/bug.h if CONFIG_BUG=n
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Mon, Sep 30, 2013 at 7:45 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> What about using __builtin_unreachable when we can but turn off warnings
>> and use do{}while(0) when __builtin_unreachable does not exist?  This seems
>> the both worlds.  Newer compilers produce better code with unreachable
>> anyways.
>>
>
> Simply not true.
>
> do{}while(0) is a NOP it is no more useful than an ';' statement.  It
> doesn't serve as a magic uninitialized variable hiding mechanism.

You missed the "turn off warnings" part of the "and".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
