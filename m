Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 16:49:59 +0000 (GMT)
Received: from web10102.mail.yahoo.com ([IPv6:::ffff:216.136.130.52]:22797
	"HELO web10102.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225550AbUASQt7>; Mon, 19 Jan 2004 16:49:59 +0000
Message-ID: <20040119164956.7067.qmail@web10102.mail.yahoo.com>
Received: from [128.107.253.43] by web10102.mail.yahoo.com via HTTP; Mon, 19 Jan 2004 16:49:56 GMT
Date: Mon, 19 Jan 2004 16:49:56 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Re: In r4k, where does PC point to?
To: Dominic Sweetman <dom@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <16396.1546.496342.570908@gladsmuir.mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Dominic,

    Thanks for your comment.. replies inline..

> One more try:
> 
> > > A MIPS CPU does not have a register called "PC".
>  In...
> > 
> > In the r4k user manual, it is mentioned that there
> is
> > a special register PC in the core CPU (other than
> the 
> > HI & LO special registers).
> 
> OK, by "register" I mean strictly something which is
> software-visible - like "$2" or the coprocessor-zero
> register called
> "EPC".
> 
> There is no PC register in my sense, and if you've
> found a manual
> claiming that one exists, that manual is wrong -
> send me URL and
> tell me how to find this text.

Here is the link..
http://www.cag.lcs.mit.edu/raw/documents/R4400_Uman_book_Ed2.pdf


    The documentation about the PC is present in the
chapter-1 under the section "CPU Register Overview".

    Please let me know whether this manual is correct.

Thanks much,
-karthi

> --
> Dominic
> 
> 
>  

=====
The expert at anything was once a beginner
                  ______________________________
                 /                              \
             O  /      Karthikeyan.N             \
           O   |       Chennai, India.            |
    `\|||/'     \    Mobile: +919884104346       /
     (o o)       \                              /
_ ooO (_) Ooo____________________________________
_____|_____|_____|_____|_____|_____|_____|_____|_
__|_____|_____|_____|_____|_____|_____|_____|____
_____|_____|_____|_____|_____|_____|_____|_____|_

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
