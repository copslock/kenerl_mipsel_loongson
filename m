Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA27363; Mon, 1 Jul 1996 11:27:44 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA17331 for linux-list; Mon, 1 Jul 1996 18:26:25 GMT
Received: from demi.engr.sgi.com (demi.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA17316; Mon, 1 Jul 1996 11:26:24 -0700
Received: (from dpinto@localhost) by demi.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA03874; Mon, 1 Jul 1996 11:26:23 -0700
From: "Demetrio Pinto" <dpinto@demi.engr.sgi.com>
Message-Id: <9607011126.ZM3872@demi.engr.sgi.com>
Date: Mon, 1 Jul 1996 11:26:23 -0700
In-Reply-To: ariel@yon (Ariel Faigon)
        "NIS rarpd entries (fwd)" (Jun 29,  6:26pm)
References: <199606300126.SAA01788@yon.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: ariel@cthulhu.engr.sgi.com
Subject: Re: NIS rarpd entries (fwd)
Cc: dpinto@yon.engr.sgi.com (Demetrio Pinto), linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel,
David,

On Jun 29,  6:26pm, Ariel Faigon wrote:
> Subject: NIS rarpd entries (fwd)
> Demetrio,
>
> Will it be possible to add an ethers entry for stacey.engr
> to our ypmaps ?


stacey is ALREADY in the YP hosts maps

	demi 39# ypmatch stacey.engr hosts
	150.166.75.5    stacey.engr.sgi.com
	demi 40#

(BTW, 150.166.75 is one of the NetWork Group nets.)


>  Thanks!
>
> If yes, David, could you send Demetrio the ethernet address ?
>
>
> ----- Forwarded message from David S. Miller -----
>
> >From owner-linux@cthulhu  Sat Jun 29 00:07:01 1996
> Date: Sat, 29 Jun 1996 00:07:52 -0700
> Message-Id: <199606290707.AAA17304@neteng.engr.sgi.com>
> From: "David S. Miller" <dm@neteng>
> To: linux@neteng
> Subject: NIS rarpd entries
> Reply-to: dm@sgi.com
> Sender: owner-linux@cthulhu
> Precedence: bulk
>
>
> When I'm booting my test box I have to run a bogus hacked up copy of
> rarpd because the NIS maps in my domain don't have an ethers entry for
> stacey.engr

This is from your system

	tanya 2% ypmatch stacey hosts
	150.166.75.5    stacey.engr.sgi.com stacey
	tanya 3%

Demetrio

>
> What is a better way of dealing with this?
>
> Later,
> David S. Miller
> dm@sgi.com
>
> ----- End of forwarded message from David S. Miller -----
>
> --
> Peace, Ariel
>-- End of excerpt from Ariel Faigon
