Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JEJFU16413
	for linux-mips-outgoing; Tue, 19 Feb 2002 06:19:15 -0800
Received: from smtp010.mail.yahoo.com (smtp010.mail.yahoo.com [216.136.173.30])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JEJ9916410
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 06:19:09 -0800
Received: from e145033.ppp.asahi-net.or.jp (HELO nazneen) (211.13.145.33)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 19 Feb 2002 13:19:08 -0000
Message-ID: <004101c1b948$32f9cc60$21910dd3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: <linux-mips@oss.sgi.com>
References: <002301c1b8d2$22a0efe0$443784d3@gol.com> <20020218173419.A15980@momenco.com>
Subject: Re: Page Size 16KB.
Date: Tue, 19 Feb 2002 22:20:26 +0900
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


> Does your userspace shell set the CREAD flag properly?
i think so. and btw, my kernel version is 2.4.9. i thought this CREAD
problem isnt there in this version. but shall check again. thanks for this
info.

other than this where else could be the problem that i'm overlooking??


> Matt
>
> On Tue, Feb 19, 2002 at 08:15:18AM +0900, Girish Gulawani wrote:
> > hi, all.
> > while in the process of changing page size of kernel to 16KB i am facing
a
> > strange problem. the kernel boots up & user command, currently
statically
> > linked shell, loads. it displays first prompt.  pressing enter keys, the
> > serial device receives the interrupts but no activity on shell's part.
where
> > could the shell possibly be stuck?
> > this is LSI MIPS EZ4021 implementation. please please help!!!
> > many thanks & regards,
> > girish.
> >
> >
> > _________________________________________________________
> > Do You Yahoo!?
> > Get your free @yahoo.com address at http://mail.yahoo.com
>
> --
> Matthew Dharm                              Work: mdharm@momenco.com
> Senior Software Designer, Momentum Computer


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
