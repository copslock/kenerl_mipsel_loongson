Received:  by oss.sgi.com id <S553979AbRAaQ2C>;
	Wed, 31 Jan 2001 08:28:02 -0800
Received: from mx.mips.com ([206.31.31.226]:27077 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553976AbRAaQ1q>;
	Wed, 31 Jan 2001 08:27:46 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA19279;
	Wed, 31 Jan 2001 08:27:41 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA29480;
	Wed, 31 Jan 2001 08:27:40 -0800 (PST)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id RAA07001;
	Wed, 31 Jan 2001 17:27:28 +0100 (MET)
Message-ID: <3A783C59.FC3D3F98@mips.com>
Date:   Wed, 31 Jan 2001 17:24:58 +0100
From:   Carsten Langgaard <carstenl@mips.com>
Organization: MIPS
X-Mailer: Mozilla 4.72 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     linux-mips@oss.sgi.com
Subject: Re: Filesystem corruption
References: <3A781F33.6B28D19C@mips.com> <20010131165246.B32399@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Try use fsck.

/Carsten

Florian Lohoff wrote:

> On Wed, Jan 31, 2001 at 03:20:35PM +0100, Carsten Langgaard wrote:
> >
> > Has anyone seen problems with fsck on the latest 2.4.0 kernel ?
> > My filesystem gets corrupted from time to time when I use the latest
> > 2.4.0 kernel.
> >
>
> Hmm - nope - 2.4.0 Bigendian here
>
> resume:~# uptime
>  3:50pm  up 6 days, 10 min,  1 user,  load average: 0.00, 0.00, 0.00
> resume:~# uname -a
> Linux resume.rfc822.org 2.4.0 #3 Thu Jan 25 16:25:23 CET 2001 mips unknown
>
> Flo
> --
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
