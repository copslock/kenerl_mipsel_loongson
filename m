Received:  by oss.sgi.com id <S305168AbQALAlj>;
	Tue, 11 Jan 2000 16:41:39 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32555 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQALAlL>; Tue, 11 Jan 2000 16:41:11 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA01515; Tue, 11 Jan 2000 16:44:44 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA92382
	for linux-list;
	Tue, 11 Jan 2000 16:36:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA89082;
	Tue, 11 Jan 2000 16:35:59 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA01969; Tue, 11 Jan 2000 16:35:42 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-10.uni-koblenz.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA17361;
	Wed, 12 Jan 2000 01:35:36 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQALA26>;
	Wed, 12 Jan 2000 01:28:58 +0100
Date:   Wed, 12 Jan 2000 01:28:58 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Bill Halchin <bhalchin@hotmail.com>, ralf@oss.sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: X server
Message-ID: <20000112012858.D4320@uni-koblenz.de>
References: <20000111030346.42694.qmail@hotmail.com> <E1281JK-0004hu-00@the-village.bc.nu> <14459.34255.60876.700493@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <14459.34255.60876.700493@liveoak.engr.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Jan 11, 2000 at 11:34:39AM -0800, William J. Earl wrote:

>  > > Ralf,
>  > >   What I am saying is why don't we try this approach.
>  > 
>  > "we". I have this cool idea - "You" 
>  > 
>  > Actually  for an Indy X server your best model is still the 8514 driver in XFree
> 
>       That sounds right to me as well.  The problem with fbcon or GGI
> is that the Indy graphics hardware does not have a CPU-addressable
> frame buffer.  You can always fake one in main memory, and DMA any
> modified portions to the real frame buffer, but a naive implementation
> would use more memory bandwidth than is available and a clever
> implementation would incur a lot of VM overhead (and still use a lot
> of bandwidth).  Starting from an X server designed for hardware without
> an addressable frame buffer is more appropriate.

As I remember GGI has been improved such that it also can handle things
like a 8514 or Newport card.  That still doesn't invalidate other
reasons why GGI isn't such a good idea.  That said, Alan's suggestion
is the right one.

  Ralf
