Received:  by oss.sgi.com id <S554090AbRBALQF>;
	Thu, 1 Feb 2001 03:16:05 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:15121 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554100AbRBALPz>;
	Thu, 1 Feb 2001 03:15:55 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id ACF1A802; Thu,  1 Feb 2001 12:15:40 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C6813EE9C; Thu,  1 Feb 2001 12:02:52 +0100 (CET)
Date:   Thu, 1 Feb 2001 12:02:52 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Dr. David Gilbert" <gilbertd@treblig.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: netbooting indy
Message-ID: <20010201120252.C3784@paradigm.rfc822.org>
References: <Pine.GSO.4.30L.0101311648280.22989-100000@home-on-the-dome.mit.edu> <Pine.LNX.4.30.0102010926190.20992-100000@springhead.px.uk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102010926190.20992-100000@springhead.px.uk.com>; from gilbertd@treblig.org on Thu, Feb 01, 2001 at 09:26:55AM +0000
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 01, 2001 at 09:26:55AM +0000, Dr. David Gilbert wrote:
> On Wed, 31 Jan 2001, Kenneth C Barr wrote:
> 
> > I finally got bootp/tftp to answer my indy's pleas for an image, but get
> > the following behavior (with my own IP addr and server, obviously):
> >
> > >> boot bootp():/vmlinux

This uses "sash" and says sash to "bootp"

> I haven't seen the error you got - however one thing I do differently is
> to do
> 
> bootp():/vmlinux
> 
> without the initial 'boot ' - worth a go?

This bootps directly from the prom

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
