Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HBEPnC015722
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 04:14:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HBEPHP015721
	for linux-mips-outgoing; Mon, 17 Jun 2002 04:14:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HBEJnC015718
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 04:14:20 -0700
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g5HBH4Y02821;
	Mon, 17 Jun 2002 12:17:04 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id MAA17773;
	Mon, 17 Jun 2002 12:17:03 +0100 (BST)
Date: Mon, 17 Jun 2002 12:17:03 +0100 (BST)
Message-Id: <200206171117.MAA17773@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: aditya <aditya.ps@ap.sony.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: regarding jal instruction in mips
In-Reply-To: <4.3.2.7.0.20020617140608.00b9f640@43.88.102.8>
References: <4.3.2.7.0.20020617140608.00b9f640@43.88.102.8>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


aditya (aditya.ps@ap.sony.com) writes:

> I have a doubt w.r.t. Linux on mips.
> 
> in mips there is a instruction jal which jumps across 256 MB
> boundry.  but this is a restriction as shared text (libraries) and
> private text (program's text) should be located within 256 MB
> boundry. Is it true ??

In the usual Linux address map it isn't true: library code might
easily fail to be in the same 256Mbyte 'chunk' of virtual memory.

Linux/MIPS applications implement calls between modules (and for
relocatable libraries, calls inside modules too) with an indirection
through a table of pointers - the "global access table" or GOT.

We normally think of this as a way of providing suitably
position-independent code...  There's a fair description of this in my
book "See MIPS Run" under the heading "Sharing Library Code in the
MIPS ABI" - Chapter 10 or so.

-- 
Dominic Sweetman, 
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
