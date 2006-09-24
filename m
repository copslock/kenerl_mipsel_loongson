Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2006 16:21:40 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:51147 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037883AbWIXPVi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 24 Sep 2006 16:21:38 +0100
Received: by ug-out-1314.google.com with SMTP id 40so478892uga
        for <linux-mips@linux-mips.org>; Sun, 24 Sep 2006 08:21:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h4QlH+Dg6bSZt1olMMl2GgBQ5IW6hweH4hvHK7D0pv5+IwhiNQbNmcRMU2gOs6Z562bcKEeHp7tZ+5lJRrsaDlLPLWHpgKBOga7wGr066S+WapEI6MIYFYQgp6zVjEL9R0b1D9ZjAm36nEtcr4KGSMKbIaoVix3Abx4SnCtSH50=
Received: by 10.67.105.19 with SMTP id h19mr2560413ugm;
        Sun, 24 Sep 2006 08:21:37 -0700 (PDT)
Received: by 10.66.242.8 with HTTP; Sun, 24 Sep 2006 08:21:37 -0700 (PDT)
Message-ID: <816d36d30609240821x31035d3cw8170ace7de43abe5@mail.gmail.com>
Date:	Sun, 24 Sep 2006 11:21:37 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] remove tx3912fb
Cc:	linux-mips@linux-mips.org
In-Reply-To: <816d36d30609240819q59edce51p91a7aa66dbc8dc43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060922020202.31b2b537.yoichi_yuasa@tripeaks.co.jp>
	 <816d36d30609221012j452e6b03raa1ef1c72bb494d@mail.gmail.com>
	 <20060924214306.40133dee.yoichi_yuasa@tripeaks.co.jp>
	 <816d36d30609240819q59edce51p91a7aa66dbc8dc43@mail.gmail.com>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 9/24/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Hello,
>
> On Fri, 22 Sep 2006 13:12:44 -0400
> "Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:
>
> > On 9/21/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > Hi,
> > >
> > > NINO support has already dropped.
> > > Nothing is using tx3912fb.
> > >
> > > Yoichi
> > >
> > > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > >
> > > ...
> >
> > Hello Yoichi!
> >
> > If you don't mind I would ask to keep this driver up, I will soon add
> > tx3912 support back up because I have a couple PDAs that use it, and
> > there are still a few boards that run on it.
>
> Do you add the support of which PDA?

Philips Nino and Velo series and the old Sharp Mobilon series; both
run on PR31700/TX3912 SoCs. Steven Hill had a port for the Nino board
on early 2.4, but it was dropped as of 2.4.17 if I recall correctly,
it never made it to 2.6.

     Ricardo
