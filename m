Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 15:59:29 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994542AbeIDN7XkGAyl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Sep 2018 15:59:23 +0200
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBDD72082B;
        Tue,  4 Sep 2018 13:59:10 +0000 (UTC)
Date:   Tue, 4 Sep 2018 09:59:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Henrik Austad <henrik@austad.us>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jan Kandziora <jjj@gmx.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, linux-security-module@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, kvm@vger.kernel.org,
        Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Message-ID: <20180904095908.13298b3d@gandalf.local.home>
In-Reply-To: <20180904113030.GB25177@amd>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
        <20180904113030.GB25177@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=LkcF=LS=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Tue, 4 Sep 2018 13:30:30 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> I'd say this is still quite valueable, and it might be worth fixing,
> rather then removing completely.

I agree. Perhaps we should have a 00-DESCRIPTION file in each
directory, and each file could start with a:

 DESCRIPTION: <one line description here>

and then these files could be generated by those that have these tags.

-- Steve
