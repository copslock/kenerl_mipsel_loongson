Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:39:55 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:38531
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994648AbeIFVjtz03bw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 23:39:49 +0200
Received: by mail-it0-x243.google.com with SMTP id p129-v6so17218972ite.3
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2018 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KjKh80UufIY2dCSimg20mtMQG5JxcdRjILM735qSlgw=;
        b=PHAerKGVibYNrKcFrYx29XCBy44tZUnGMdTqOKSzbxlBCZLjwYskBmbs6jmKvnnBlR
         08294d0fV/h8PtzOU+SpRnw2w0j7XQYu5xTBL8lq67YYCz1z1cJ/afD7Gy2evboYK+dA
         6txSgX8m5DlHvKCblGilMREcCxDzA+x0Nifbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KjKh80UufIY2dCSimg20mtMQG5JxcdRjILM735qSlgw=;
        b=PtF+iqqKuyuSufqMUTrPATAQOizWd9CdUdHT878a9Lq3HALGOSobDhY3mM+Wl6jUVa
         VWCYcgQMBDc8w9Po46Q4ABvQDqqhUKxkJt8E7SLa0TYsiVZxIV8JodTmuXox/g3C5kCL
         xgDaVEkY5oX4EOsoCrvx9UYd2waR2uR6FrH4g8po/Cmt+QnLzpSE62l6gZJy8u/O4oJY
         z2I8qLIiORNpBWiF2Vrs0wWUuSOofsEJhOjBCau79wkmYJXe3J7v5heoR43Z1YcB4qAz
         SiDac6PAIksnGSM2mkk5GKXX5e36gv/+sAXNlr1SO7sgF3YCKVkRAtNkddFX6nPqY/RZ
         +p2A==
X-Gm-Message-State: APzg51CXDSYkPqVmULQuUFUXcwvYMLDpEWNiDOsMhz9zf4sIhRaKx/H8
        2PXDCabPotHN76q8fZF81ZJkXQ/BBdmIDtajSmzuaA==
X-Google-Smtp-Source: ANB0VdaZYS6CGCUSkits1K36FzJ8O2eKhaBbPBRcK3xgoKPqUi4IlqCBaQM3QhkFFKX9EQvpTGJrhlPpAFWl3aj1uRA=
X-Received: by 2002:a24:3507:: with SMTP id k7-v6mr4355830ita.13.1536269983556;
 Thu, 06 Sep 2018 14:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bf05:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 14:39:42 -0700 (PDT)
X-Originating-IP: [2a02:168:569e:0:3106:d637:d723:e855]
In-Reply-To: <20180906120120.3dd1fc91@gandalf.local.home>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
 <20180904113030.GB25177@amd> <20180904095908.13298b3d@gandalf.local.home>
 <20180906095804.5ab2716f@lwn.net> <20180906120120.3dd1fc91@gandalf.local.home>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 6 Sep 2018 23:39:42 +0200
X-Google-Sender-Auth: HnWLIkneOlckhuh6DKOnc742aWI
Message-ID: <CAKMK7uHoeB89-VVS8qVaoNiP_0waHHJ=dFCUgXkRDTnRkXz69g@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        X86 ML <x86@kernel.org>, kvm@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        Henrik Austad <henrik@austad.us>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jan Kandziora <jjj@gmx.de>, Paul Mackerras <paulus@samba.org>,
        Henrik Austad <haustad@cisco.com>, Pavel Machek <pavel@ucw.cz>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-s390@vger.kernel.org,
        Ian Kent <raven@themaw.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Karsten Keil <isdn@linux-pingi.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-parisc@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-ide@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-spi@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <daniel.vetter@ffwll.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@ffwll.ch
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

On Thu, Sep 6, 2018 at 6:01 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 6 Sep 2018 09:58:04 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Thanks,
>>
>> jon  (who is increasingly inclined to apply this patch)
>
> As Colin Kaepernick now says... "Just do it!"
>
> ;-)

+1

But I'm biased, I'm part of the party that is responsible for the new
shiny documentation system ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
