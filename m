Received:  by oss.sgi.com id <S554067AbRBAJ0n>;
	Thu, 1 Feb 2001 01:26:43 -0800
Received: from bastion.power-x.co.uk ([62.232.19.201]:61450 "EHLO
        bastion.power-x.co.uk") by oss.sgi.com with ESMTP
	id <S554019AbRBAJ0U>; Thu, 1 Feb 2001 01:26:20 -0800
Received: from springhead.px.uk.com (IDENT:dg@springhead.px.uk.com [172.16.18.41])
	by bastion.power-x.co.uk (8.9.3/8.9.3) with ESMTP id JAA10262;
	Thu, 1 Feb 2001 09:26:14 GMT
Date:   Thu, 1 Feb 2001 09:26:55 +0000 (GMT)
From:   "Dr. David Gilbert" <gilbertd@treblig.org>
X-Sender:  <dg@springhead.px.uk.com>
To:     Kenneth C Barr <kbarr@MIT.EDU>
cc:     <linux-mips@oss.sgi.com>
Subject: Re: netbooting indy
In-Reply-To: <Pine.GSO.4.30L.0101311648280.22989-100000@home-on-the-dome.mit.edu>
Message-ID: <Pine.LNX.4.30.0102010926190.20992-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 31 Jan 2001, Kenneth C Barr wrote:

> I finally got bootp/tftp to answer my indy's pleas for an image, but get
> the following behavior (with my own IP addr and server, obviously):
>
> >> boot bootp():/vmlinux


I haven't seen the error you got - however one thing I do differently is
to do

bootp():/vmlinux

without the initial 'boot ' - worth a go?

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/
