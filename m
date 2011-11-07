Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2011 04:06:32 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:36320 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904218Ab1KGDGY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2011 04:06:24 +0100
Received: by faaq17 with SMTP id q17so6056993faa.36
        for <multiple recipients>; Sun, 06 Nov 2011 19:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BwXe+mLuYayTCJ+Iz2au3SN5WL4JnyzjmALIhLdMhjk=;
        b=L31EE6BvmpU7GYS6hwtk6Bn2cT8Kcezbvx1caecj3nXko4kyXqn2tIC+F6ioUsGFyY
         qpiss7VEXLIWrr8M0xhrn4do4UDvpxzei+Wa1ozkB8kHl3IzjuoEv81A5m+hX98I9jAB
         GMcxNpLBWmf6Hjf4QUZOtQCk7wQxN+ft/VZB8=
Received: by 10.223.76.66 with SMTP id b2mr44774419fak.15.1320635179665;
        Sun, 06 Nov 2011 19:06:19 -0800 (PST)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id f4sm21054134faj.1.2011.11.06.19.06.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 19:06:19 -0800 (PST)
Date:   Mon, 7 Nov 2011 11:06:03 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, tglx@linutronix.de
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 12/49] MIPS: irq: Remove IRQF_DISABLED
Message-ID: <20111107030603.GA3893@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
 <1319277421-9203-13-git-send-email-yong.zhang0@gmail.com>
 <20111104122106.GA7581@linux-mips.org>
 <20111107021048.GA3027@zhy>
 <20111107134912.0878664493f1110ceefb98a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111107134912.0878664493f1110ceefb98a6@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4930

On Mon, Nov 07, 2011 at 01:49:12PM +1100, Stephen Rothwell wrote:
> Hi Yong,
> 
> On Mon, 7 Nov 2011 10:10:48 +0800 Yong Zhang <yong.zhang0@gmail.com> wrote:
> >
> > On Fri, Nov 04, 2011 at 12:21:06PM +0000, Ralf Baechle wrote:
> > > Thanks, queued for 3.3.  I resolved a conflict in dbdma.c and remove
> > > one IRQF_DISABLED which had been missed in arch/mips/kernel/perf_event.c.
> > 
> > And FYI, my patch is based on next-20111014 when I made it.
> 
> You should never base anything on top of a linux-next tree.  You should
> use the tree you are fixing (Linus' or the Mips tree or ...) as the base.

Thanks for your reminding Stephen :)

So I guess 'basing on linux-next' also brings some trouble to tglx,
which is hard for him to pick them up.

I think I should base my patch on -tip for the leftovers, tglx?
Or let me know your opinion if you have different idea.

Thanks,
Yong
