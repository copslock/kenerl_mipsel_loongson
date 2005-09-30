Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 16:44:27 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.206]:11369 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465585AbVI3PoI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 16:44:08 +0100
Received: by zproxy.gmail.com with SMTP id j2so488773nzf
        for <linux-mips@linux-mips.org>; Fri, 30 Sep 2005 08:44:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QTCJk+y/DqJiK/w7zqqkYd2slR5Po+DzYY9j2KKlS+3o18wpEVZiB9dconOZTkUP2NvUOzXvBwUcHNNqw30npj998VC+BB+j72bPVImZ+5JYLeP3IrTx5kvivuwAGY4Wbrh4oXiNjqlC1/ZdSwoYl0BnuYgOO9N4dVWE6cT5Aus=
Received: by 10.36.108.12 with SMTP id g12mr1006961nzc;
        Fri, 30 Sep 2005 08:44:01 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Fri, 30 Sep 2005 08:44:01 -0700 (PDT)
Message-ID: <cda58cb80509300844v5181d6fey@mail.gmail.com>
Date:	Fri, 30 Sep 2005 17:44:01 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] minor fix in asm-mips/module.h
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050930130928.GA3083@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb8050926000665f843dc@mail.gmail.com>
	 <20050926115539.GB3175@linux-mips.org>
	 <cda58cb805092605057f7cad7d@mail.gmail.com>
	 <20050929234542.GB3983@linux-mips.org>
	 <cda58cb80509300536q42e9ddd4q@mail.gmail.com>
	 <20050930130928.GA3083@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/9/30, Ralf Baechle <ralf@linux-mips.org>:
> On Fri, Sep 30, 2005 at 02:36:01PM +0200, Franck wrote:
>
> > 2005/9/30, Ralf Baechle <ralf@linux-mips.org>:
> > > There are no CONFIG_CPU_4KSC and CONFIG_CPU_4KSD configuration options.
> > > Did you really create this patch against the linux module of the CVS
> > > repository or was it a different tree?
> > >
> >
> > The patch was created against linux-mips CVS repository. I added 4KSC
> > and 4KSD support in this tree. I thougth seeing reference of 4KSC
> > somewhere. Anyway, if you don't want to include them in your tree
> > that's ok.
>
> It's just that references to CONFIG_* symbols that are being defined
> nowhere don't make sense.  If however you want to contribute improved
> support for these processors, by all means I'm certainly going to appreciate
> a patch!
>

I'm surprised you're interested in added support for 4KSC and 4KSD
cpu...Anyway I could send a trivial patch to you if so.

Thanks
--
               Franck
