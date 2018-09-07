Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 09:21:57 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbeIGHVxiXiUj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2018 09:21:53 +0200
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77957D60;
        Fri,  7 Sep 2018 07:21:45 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:21:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
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
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Message-ID: <20180907072143.GC1334@kroah.com>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
 <20180904113030.GB25177@amd>
 <20180904095908.13298b3d@gandalf.local.home>
 <20180906095804.5ab2716f@lwn.net>
 <20180906120120.3dd1fc91@gandalf.local.home>
 <CAKMK7uHoeB89-VVS8qVaoNiP_0waHHJ=dFCUgXkRDTnRkXz69g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHoeB89-VVS8qVaoNiP_0waHHJ=dFCUgXkRDTnRkXz69g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Thu, Sep 06, 2018 at 11:39:42PM +0200, Daniel Vetter wrote:
> On Thu, Sep 6, 2018 at 6:01 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 6 Sep 2018 09:58:04 -0600
> > Jonathan Corbet <corbet@lwn.net> wrote:
> >
> >> Thanks,
> >>
> >> jon  (who is increasingly inclined to apply this patch)
> >
> > As Colin Kaepernick now says... "Just do it!"
> >
> > ;-)
> 
> +1
> 
> But I'm biased, I'm part of the party that is responsible for the new
> shiny documentation system ...

I am not responsible for any of the new shiny documentation system, and
I think this is a good idea:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
