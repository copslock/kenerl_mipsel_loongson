Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57FpWV23758
	for linux-mips-outgoing; Thu, 7 Jun 2001 08:51:32 -0700
Received: from mail.iside.net (ns2.iside.net [212.73.214.202])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57FpUh23754
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 08:51:30 -0700
X-Virus-Protected-by-iSide: McAfee virus scanning engine
Received: from [193.251.60.11] (HELO yoshi)
  by mail.iside.net (CommuniGate Pro SMTP 3.4.7)
  with SMTP id 3563471; Thu, 07 Jun 2001 17:46:02 +0200
Message-ID: <00f201c0ef6a$aaebb600$662d44c3@yoshi>
From: "julien" <julien@iside.net>
To: "Keith M Wesolowski" <wesolows@foobazco.org>
Cc: <linux-mips@oss.sgi.com>
References: <20010607083114.A25672@foobazco.org>
Subject: Re: new comer question
Date: Thu, 7 Jun 2001 17:58:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

thanx for your fast answer ;-))

> On Thu, Jun 07, 2001 at 04:47:42PM +0200, julien wrote:
>
> > I'm following this list's discussions since many months, and I
decided
> > to get linux running on my Indy box (R4400, Newport gfx)... To do
so, I
> > followed standard installation instructions and used the hardhat5.1
> > archive located at ftp://oss.sgi.com/pub/linux/mips/redhat ...  I
set up
> > the tftp / bootp / nfs root  on a FreeBSD box as we don't have any
Linux
> > here, but this shouldn't be a problem, should it ?
>
> Of course not.  You can use any system as the server.  When you say
> "standard installation instructions" what does that mean exactly?
> More importantly, which kernel did you use and where did it come from?

by "standard installation instructions" I mean I followed instructions
given in the file ftp://oss.sgi.com/pub/linux/mips/redhat/instructions.
The kernel I'm using is the one included in the archive at
ftp://oss.sgi.com/pub/linux/mips/redhat/hardhat-sgi-5.1.tar.gz ... I
know it's a very old one (2.0x ?), but I didn't find any recent compiled
kernel for IP22. Do I need to checkout the current kernel and cross
compile it ?

>
> > $0 : <some hexdump>                        <-- do you need these
dumps
>
> It depends.  If this kernel is a newish 2.4 kernel or current CVS 2.2,
> then yes, the dumps are needed to solve the problem.  If this is an
> old or ancient kernel you might want to send the dumps anyway but most
> people will ignore you.

Can I try a 2.4 kernel without having to compile it myself ? If yes, do
you have any link where I could find it ? If no, I guess I will have to
set up cross compilation stuff...


Thanx very much for your time

>
> --
> Keith M Wesolowski <wesolows@foobazco.org>
http://foobazco.org/~wesolows
> ------(( Project Foobazco Coordinator and Network
Administrator ))------
> "Nothing motivates a man more than to see his boss put
> in an honest day's work." -- The fortune file

--
-------------------------------
--> julien@iside.net
-------------------------------
