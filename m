Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 18:43:49 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:33736 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S3458555AbWHARnj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 18:43:39 +0100
Received: by ug-out-1314.google.com with SMTP id m2so1619359ugc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 10:43:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LgoUIPHcRAmlIy0wXzoWoi5pKe9EUc86BYShbz2eDS6vn99Yvu1nXU5FgIeoRv0WLpcBT0/x+FuOmF6HeyjVZwpqpocRNhzXZ0HcgEv/cxAhE4hxnYYhrwnf1RX8gv9HRFGBrfA5pAni0Dg/ffYVSde6Qr44iHBBIUDRiwDGslU=
Received: by 10.66.220.17 with SMTP id s17mr1310117ugg;
        Tue, 01 Aug 2006 10:43:39 -0700 (PDT)
Received: by 10.67.87.8 with HTTP; Tue, 1 Aug 2006 10:43:39 -0700 (PDT)
Message-ID: <cda58cb80608011043u19621bdev1a2d3e2745adac50@mail.gmail.com>
Date:	Tue, 1 Aug 2006 19:43:39 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 6/7] Fix dump_stack()
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20060802.010522.11596989.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154424439852-git-send-email-vagabon.xyz@gmail.com>
	 <20060802.000837.37531064.anemo@mba.ocn.ne.jp>
	 <44CF7506.70106@innova-card.com>
	 <20060802.010522.11596989.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/8/1, Atsushi Nemoto <anemo@mba.ocn.ne.jp>:
> On Tue, 01 Aug 2006 17:36:38 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > > Eliminating the #ifdef itself looks good, but if you cleared contents
> > > of the "regs" before prepare_frametrace, you will get less false
> > > entries in the output.
> >
> > well I don't see why...show_trace() is going to only use regs[29] which
> > is setup by prepare_frametrace()...
>
> If CONFIG_KALLSYMS was not set, show_trace() print all possible
> entries starting from the sp.  The sp value stored in "regs" by
> prepare_frametrace() will be little smaller one than the address of
> the "regs" itself.  So if some values like function addresses were in
> the "regs", show_trace() will report them.
>

OK, I'll do that.

BTW what about rename show_trace() into show_raw_backtrace() ?

-- 
               Franck
