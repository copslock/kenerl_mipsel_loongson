Received:  by oss.sgi.com id <S554028AbRAWQfB>;
	Tue, 23 Jan 2001 08:35:01 -0800
Received: from bastion.power-x.co.uk ([62.232.19.201]:48141 "EHLO
        bastion.power-x.co.uk") by oss.sgi.com with ESMTP
	id <S554025AbRAWQew>; Tue, 23 Jan 2001 08:34:52 -0800
Received: from springhead.px.uk.com (IDENT:dg@springhead.px.uk.com [172.16.18.41])
	by bastion.power-x.co.uk (8.9.3/8.9.3) with ESMTP id QAA15931;
	Tue, 23 Jan 2001 16:34:34 GMT
Date:   Tue, 23 Jan 2001 16:34:39 +0000 (GMT)
From:   "Dr. David Gilbert" <gilbertd@treblig.org>
X-Sender:  <dg@springhead.px.uk.com>
To:     Christoph Martin <martin@uni-mainz.de>
cc:     Dave Gilbert <gilbertd@treblig.org>, <linux-mips@oss.sgi.com>
Subject: Re: Trying to boot an Indy
In-Reply-To: <wwgofwyckov.fsf@arthur.zdv.Uni-Mainz.DE>
Message-ID: <Pine.LNX.4.30.0101231633570.2812-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On 23 Jan 2001, Christoph Martin wrote:

> Dave Gilbert <gilbertd@treblig.org> writes:

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

This sprang into life when I added the 'sa' entry in the bootp file - that
is the server address.

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/
