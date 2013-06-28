Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 16:21:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56500 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3F1OVNinjTG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 16:21:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5SELCY0021216;
        Fri, 28 Jun 2013 16:21:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5SELATG021215;
        Fri, 28 Jun 2013 16:21:10 +0200
Date:   Fri, 28 Jun 2013 16:21:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Kconfig: Add missing MODULES dependency to
 VPE_LOADER
Message-ID: <20130628142110.GO10727@linux-mips.org>
References: <1372422327-21814-1-git-send-email-markos.chandras@imgtec.com>
 <20130628133111.GN10727@linux-mips.org>
 <CAGVrzcbyzgM8fnmO31eKMqDokV2gjS6Ds=Qd84Mz71ipvEDtqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVrzcbyzgM8fnmO31eKMqDokV2gjS6Ds=Qd84Mz71ipvEDtqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jun 28, 2013 at 02:40:17PM +0100, Florian Fainelli wrote:

> 2013/6/28 Ralf Baechle <ralf@linux-mips.org>:
> > On Fri, Jun 28, 2013 at 01:25:27PM +0100, Markos Chandras wrote:
> >
> >> The vpe.c code uses the 'struct module' which is only available if
> >> CONFIG_MODULES is selected.
> >>
> >> Also fixes the following build problem on a lantiq allmodconfig:
> >> In file included from arch/mips/kernel/vpe.c:41:0:
> >> include/linux/moduleloader.h: In function 'apply_relocate':
> >> include/linux/moduleloader.h:48:63: error: dereferencing pointer
> >> to incomplete type
> >> include/linux/moduleloader.h: In function 'apply_relocate_add':
> >> include/linux/moduleloader.h:70:63: error: dereferencing pointer
> >> to incomplete type
> >>
> >> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> >
> > Sigh.  One more bug in the thing.  It first of all shouldn't have been
> > designed recycling so much code from the module loader in inapropriate
> > ways.
> >
> > I'm going to apply the patch - but as usual whenver I have to touch the
> > VPE loader, kspd or rtlx I feel like a blunt chainsaw would be the right
> > way to fix this code.
> >
> > SPUFS is a special filesystem which was designed to use the Playstation 3's
> > synergetic elements.  The code is in arch/powerpc/platforms/cell/spufs
> > and it's a far, cleaner interface to other processing thingies, be they
> > synergetic elements, or other cores, VPEs and TCs running bare metal
> > code or strage things like custom processors.
> 
> Would not remoteproc be a simpler interface these days to load
> bare-metal ELF code into one of these things?

Once upon a time long before remoteproc was invented there was agreement
that SPUFS would be the way to go.  Yes, remoteproc might be worth a
closer look.

  Ralf
