Received:  by oss.sgi.com id <S553894AbRBTHhN>;
	Mon, 19 Feb 2001 23:37:13 -0800
Received: from boco.fee.vutbr.cz ([147.229.9.11]:61454 "EHLO boco.fee.vutbr.cz")
	by oss.sgi.com with ESMTP id <S553892AbRBTHgv>;
	Mon, 19 Feb 2001 23:36:51 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.2/8.11.2) with ESMTP id f1K7agC07256
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Tue, 20 Feb 2001 08:36:47 +0100 (CET)
Received: (from xjezda00@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f1K76AN69127;
	Tue, 20 Feb 2001 08:06:10 +0100 (CET)
Date:   Tue, 20 Feb 2001 08:06:10 +0100
From:   David Jez <dave.jez@seznam.cz>
To:     Can Altineller <altine@ee.fit.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: newbie question.
Message-ID: <20010220080610.A69044@stud.fee.vutbr.cz>
References: <20010219141130.C17354@cistron.nl> <Pine.GSO.4.05.10102191449510.13560-100000@yacht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.05.10102191449510.13560-100000@yacht>; from altine@ee.fit.edu on Mon, Feb 19, 2001 at 02:52:10PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Feb 19, 2001 at 02:52:10PM -0500, Can Altineller wrote:
> 
> 	Hello;
> 
> 	I got an Indy 4600SC with 64Megs of memory, and I dont feel like
> running Irix on it. What is the status of the sgi port port of linux. Is
> there a distro available? Also, I dont have a floppy in my indy, so can I
> net boot? If someone point me out in the correct way, I will be very
> happy.
Hi,

Try download doc & faqs & tutorials & distro from:

ftp://ftp.oss.sgi.com/pub/linux/mips

or RedHat from:

ftp://ftp.oss.sgi.com/pub/linux/mips/redhat

PS: Don't worry about instalation. In directory redhat you can find Getting
started and README. Read it carefully. If you search archive of this conf. you
can find thread about netbooting Indy ( bootp():/vmlinuz ) from PROM monitor
and setting bootpd in linux boot server.
> 
> 	Thanks.
> 	-C.A.
> 
> 
Best Regards,
Dave

-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@fest.stud.fee.vutbr.cz
---------=[ ~EOF ]=------------------------------------
