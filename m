Received:  by oss.sgi.com id <S553762AbQKIIYe>;
	Thu, 9 Nov 2000 00:24:34 -0800
Received: from natmail2.webmailer.de ([192.67.198.65]:58568 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553751AbQKIIYP>;
	Thu, 9 Nov 2000 00:24:15 -0800
Received: from scotty.mgnet.de (p3E9ECC1C.dip.t-dialin.net [62.158.204.28])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id JAA06606
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 09:24:12 +0100 (MET)
Received: (qmail 7336 invoked from network); 9 Nov 2000 08:24:09 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 9 Nov 2000 08:24:09 -0000
Date:   Thu, 9 Nov 2000 09:24:09 +0100 (CET)
From:   Klaus Naumann <spock@mgnet.de>
To:     Nicu Popovici <octavp@isratech.ro>
cc:     Ralf Baechle <ralf@uni-koblenz.de>,
        Linux/MIPS list <linux-mips@oss.sgi.com>
Subject: Re: MIPS kernel!
In-Reply-To: <3A0ABB53.92D39438@isratech.ro>
Message-ID: <Pine.LNX.4.21.0011090922450.7879-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 9 Nov 2000, Nicu Popovici wrote:

> I try to compile the linux 2.2.13 and   I got that one from ftp.lineo.com.
> I also tried to cross compile the linux_2_2 from CVS repository from
> oss.sgi.com and I managed but that one does not have support for my
> ATLAS borad and I can not run it on my machine.

Did you also try 2.4 from oss.sgi.com ? If not you should try it,
because IIRC 2.2 doesn't have ATLAS support but 2.4 has.
I think I remember seeing a CVS commit which included ATLAS support
into 2.4 ... correct me if I'm wrong.

		HTH, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
