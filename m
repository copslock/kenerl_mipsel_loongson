Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 00:36:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56272 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491892Ab0EaWgT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 00:36:19 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4VMaFba002915;
        Mon, 31 May 2010 23:36:16 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4VMaFu3002913;
        Mon, 31 May 2010 23:36:15 +0100
Date:   Mon, 31 May 2010 23:36:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] mips: fix build with O=...
Message-ID: <20100531223614.GA2789@linux-mips.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
 <AANLkTilwqYZc9-vtHsdBg1JwIOiYEPBtuRG-Rqg6nxNC@mail.gmail.com>
 <20100531180321.GA27518@merkur.ravnborg.org>
 <AANLkTimRi4FOtJA8xKfD78dBK4rWfFawOsZkACZfhe4g@mail.gmail.com>
 <20100531190011.GA32397@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100531190011.GA32397@merkur.ravnborg.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 26949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, May 31, 2010 at 09:00:11PM +0200, Sam Ravnborg wrote:

> > > Note: On top of my tree since git did not see the
> > > git tree posted by Ralf as a git tree?!?
> > 
> > git://git.linux-mips.org/pub/scm/linux-queue.git works
> color me stupid :-(
> I used git pull xxx instead of git clone xxx.

Be careful - that tree is frequently rebased.  This is also why I keep
it a separate tree - a branch that is rebased has the potencial to
confuse less experienced git users.

  Ralf
