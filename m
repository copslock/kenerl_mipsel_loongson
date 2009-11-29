Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Nov 2009 08:29:43 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58163 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492332AbZK2H3k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Nov 2009 08:29:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAT7Tpsr024159;
        Sun, 29 Nov 2009 07:29:51 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAT7Tm3B024157;
        Sun, 29 Nov 2009 07:29:48 GMT
Date:   Sun, 29 Nov 2009 07:29:48 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Message-ID: <20091129072948.GA15146@linux-mips.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
 <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
 <20091129053527.GU6936@core.coreip.homeip.net>
 <1259473802.2577.6.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259473802.2577.6.camel@falcon.domain.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 29, 2009 at 01:50:02PM +0800, Wu Zhangjin wrote:

> On Sat, 2009-11-28 at 21:35 -0800, Dmitry Torokhov wrote:
> > On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
> > >  
> > > +config YEELOONG_HOTKEY
> > > +	tristate "Hotkey Driver"
> > > +	depends on YEELOONG_VO
> > > +	select INPUT
> > 
> > I think this should be depend, not select. 
> 
> Hmm, okay, will replace it by depend later ;)
> 
> > 
> > > +	select INPUT_EVDEV
> > > +	select SUSPEND
> > 
> > Does it break without SUSPEND?
> 
> not break, but I just want to select something for users, so, they will
> have no need to care about which extra option is needed.

We use  select extensively on MIPS but select is dangerous and you stepped
into its trap.  When SUSPEND is enabled by a user in
kernel/power/Kconfig it can only be choosen if PM is enabled.  By
"select SUSPEND" this dependency so now it is possible to have a kernel
where SUSPEND is enabled without PM which won't work.

  Ralf
