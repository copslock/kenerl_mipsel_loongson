Received:  by oss.sgi.com id <S305168AbQAKTs3>;
	Tue, 11 Jan 2000 11:48:29 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:6477 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305167AbQAKTsL>;
	Tue, 11 Jan 2000 11:48:11 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA00960; Tue, 11 Jan 2000 11:46:32 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA85844
	for linux-list;
	Tue, 11 Jan 2000 11:35:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA84047;
	Tue, 11 Jan 2000 11:34:51 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id LAA05399;
	Tue, 11 Jan 2000 11:34:39 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14459.34255.60876.700493@liveoak.engr.sgi.com>
Date:   Tue, 11 Jan 2000 11:34:39 -0800 (PST)
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     bhalchin@hotmail.com (Bill Halchin), ralf@oss.sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: X server
In-Reply-To: <E1281JK-0004hu-00@the-village.bc.nu>
References: <20000111030346.42694.qmail@hotmail.com>
	<E1281JK-0004hu-00@the-village.bc.nu>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Alan Cox writes:
 > > Ralf,
 > >   What I am saying is why don't we try this approach.
 > 
 > "we". I have this cool idea - "You" 
 > 
 > Actually  for an Indy X server your best model is still the 8514 driver in XFree

      That sounds right to me as well.  The problem with fbcon or GGI
is that the Indy graphics hardware does not have a CPU-addressable
frame buffer.  You can always fake one in main memory, and DMA any
modified portions to the real frame buffer, but a naive implementation
would use more memory bandwidth than is available and a clever
implementation would incur a lot of VM overhead (and still use a lot
of bandwidth).  Starting from an X server designed for hardware without
an addressable frame buffer is more appropriate.
  
