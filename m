Received:  by oss.sgi.com id <S553743AbQK2Oxv>;
	Wed, 29 Nov 2000 06:53:51 -0800
Received: from NS.CenSoft.COM ([208.219.23.2]:26642 "EHLO
        ns.centurysoftware.com") by oss.sgi.com with ESMTP
	id <S553663AbQK2Oxf>; Wed, 29 Nov 2000 06:53:35 -0800
Received: from censoft.com (IDENT:jordanc@cen94.censoft.com [208.219.23.94])
	by ns.centurysoftware.com (8.9.3/8.9.3) with ESMTP id JAA12249;
	Wed, 29 Nov 2000 09:07:57 -0700 (MST)
Message-ID: <3A251846.663BD300@censoft.com>
Date:   Wed, 29 Nov 2000 07:52:54 -0700
From:   Jordan Crouse <jordanc@Censoft.com>
Organization: Century Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Klaus Naumann <spock@mgnet.de>
CC:     linux-mips@oss.sgi.com
Subject: Re: DNS
References: <Pine.LNX.4.21.0011290826210.25241-100000@spock.mgnet.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Actually, thanks to the hard work of Mike Klar and the boys at SuSE, I
have been able to track down a decently working copy of the libc 2.0.7,
which I have compiled for a VR4122.  In fact, until I hit this DNS
problem, it has been working without a hitch, including pthreads and
some other fairly complicated concepts.

Jordan

Klaus Naumann wrote:
> 
> On Tue, 28 Nov 2000, Jordan Crouse wrote:
> 
> > Has anyone encountered peculiar happenings with the 2.0.7 glibc and
> 
> Please don't use glibc 2.0.7 . A lot of ppl (including me) have found out,
> that it doesn't work.
> 
>                 HTH, Klaus
> 
> --
> Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
> Nickname    : Spock             | Org.: Mad Guys Network
> Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
> PGP Key     : www.mgnet.de/keys/key_spock.txt
