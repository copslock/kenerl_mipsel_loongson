Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 14:16:03 +0100 (BST)
Received: from mailout04.sul.t-online.com ([IPv6:::ffff:194.25.134.18]:46533
	"EHLO mailout04.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8224827AbTFJNQB>; Tue, 10 Jun 2003 14:16:01 +0100
Received: from fwd08.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 19PiyX-0002LC-04; Tue, 10 Jun 2003 15:15:45 +0200
Received: from denx.de (ZZIfO8ZUgeNpqlPAuRjz8oBbZb4o3ZQueY3d-VE9R7T8JRWrCJkjEX@[217.235.217.122]) by fmrl08.sul.t-online.com
	with esmtp id 19PiyG-05DeYy0; Tue, 10 Jun 2003 15:15:28 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 6F7D3429AA; Tue, 10 Jun 2003 15:15:27 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 47A8BC5FD7; Tue, 10 Jun 2003 15:15:19 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 417D8C5492; Tue, 10 Jun 2003 15:15:19 +0200 (MEST)
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Baruch Chaikin <bchaikin@il.marvell.com>,
	linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie question) 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Tue, 10 Jun 2003 14:56:23 +0200."
             <20030610125623.GC30175@rembrandt.csv.ica.uni-stuttgart.de> 
Date: Tue, 10 Jun 2003 15:15:14 +0200
Message-Id: <20030610131519.47A8BC5FD7@atlas.denx.de>
X-Seen: false
X-ID: ZZIfO8ZUgeNpqlPAuRjz8oBbZb4o3ZQueY3d-VE9R7T8JRWrCJkjEX@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20030610125623.GC30175@rembrandt.csv.ica.uni-stuttgart.de> you wrote:
>
> > # ls -l lib | grep -v '^[ld]'
> > total 2433
> 
> I conclude ELDK consists of little more than the basic networking utilities,

The ELDK (Embedded Linux Development Kit) consists of MUCH more (more
than 400 MB if you install everything).

I was just talking about the  ramdisk  image.  You  are  right,  this
contains busybox plus basic networking utilities. For this framework,
the compressed image size is about 1.3 MB.

> and the libc-related parts eat up most of the space. A more feature-rich
> system probably can't afford to waste that much.

The oriiginal poster mentioned that he has 2.5 MB available, so if he
uses something like the framework I mentioned he  still  has  1.2  MB
compressed size available. This is a _lot_.


If memroy really gets tight, there are other  places  where  you  can
save space, for example the O.P. wrote:

>   0.5 MB is allocated for the firmware code
>   1.0 MB for the compressed kernel image
>   2.5 MB for the (compressed?) file system

The reservation for both the firmware and for  the  kernel  image  is
more  than generous; 256 kB + 768 kB should be sufficient, too. Which
gives another 0.5 MB for application stuff.


Please understand me right: I do not want  to  deny  that  uClibc  or
dietlibc  are  fine  methods  to  optimize  the memory footprint of a
system. But for a starter it is probably much easier to use  standard
libraries as long as there is memory available.

For the current thread the keyword was "strip". 


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"What the scientists have in their briefcases is terrifying."
- Nikita Khrushchev
