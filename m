Received:  by oss.sgi.com id <S554033AbRAWRFv>;
	Tue, 23 Jan 2001 09:05:51 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:23886 "EHLO
        gate-sgigate.sgi.com") by oss.sgi.com with ESMTP id <S554029AbRAWRFo>;
	Tue, 23 Jan 2001 09:05:44 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870753AbRAWRDG>; Tue, 23 Jan 2001 09:03:06 -0800
Date:	Tue, 23 Jan 2001 09:02:51 -0800
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Christoph Martin <martin@uni-mainz.de>
Cc:	Dave Gilbert <gilbertd@treblig.org>, linux-mips@oss.sgi.com
Subject: Re: Trying to boot an Indy
Message-ID: <20010123090250.B945@bacchus.dhis.org>
References: <Pine.LNX.4.10.10101210150410.964-100000@tardis.home.dave> <wwgofwyckov.fsf@arthur.zdv.Uni-Mainz.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wwgofwyckov.fsf@arthur.zdv.Uni-Mainz.DE>; from martin@uni-mainz.de on Tue, Jan 23, 2001 at 05:11:44PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 23, 2001 at 05:11:44PM +0100, Christoph Martin wrote:

> > 1) I tried bootp - bootp()vmlinux - it says 'no server for vmlinux'.  The
> > bootp server is a Linux/Alpha box running 2.4.0-ac9 - I've already done
> > the trick with no_pmtu.  tcpdump shows bootp sending a packet with
> > apparently the correct mac address.
> > 
> 
> I have the same problem serving bootp from my i386 2.4.0 box. bootp
> with kernel 2.2.x on the same box works. And it is only the bootp from
> the command console that is failing. the bootp part later on in the
> kernel is working from the 2.4.0 box.
> 
> Weird.

Not weired at all.  The firmware bootp()... does bootp and then uses tftp
to download the kernel; the kernel then only uses bootp to figure out it's
network configuration.  So the two are not only doing different things,
they're also two are not only two independant and completly different
implementations.

  Ralf
