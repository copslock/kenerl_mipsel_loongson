Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 00:55:34 +0100 (BST)
Received: from h019.c009.snv.cp.net ([IPv6:::ffff:209.228.34.132]:51631 "HELO
	c009.snv.cp.net") by linux-mips.org with SMTP id <S8224900AbUJRXzZ>;
	Tue, 19 Oct 2004 00:55:25 +0100
Received: (cpmta 7318 invoked from network); 18 Oct 2004 16:55:04 -0700
Received: from 209.228.34.115 (HELO mail.canada.com.criticalpath.net)
  by smtp.canada.com (209.228.34.132) with SMTP; 18 Oct 2004 16:55:04 -0700
X-Sent: 18 Oct 2004 23:55:04 GMT
Received: from [69.193.111.169] by mail.canada.com with HTTP;
    Mon, 18 Oct 2004 16:55:03 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: linux-mips@linux-mips.org
From: thomas_blattmann@canada.com
Subject: Re: crt1.o missing
X-Sent-From: thomas_blattmann@canada.com
Date: Mon, 18 Oct 2004 16:55:03 -0700 (PDT)
X-Mailer: Web Mail 5.6.4-0
Message-Id: <20041018165504.6798.h002.c009.wm@mail.canada.com.criticalpath.net>
Return-Path: <thomas_blattmann@canada.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas_blattmann@canada.com
Precedence: bulk
X-list: linux-mips


> 
> On Fri, Oct 15, 2004 at 05:48:31PM -0700,
> thomas_blattmann@canada.com wrote:
> 
> > I'm trying to crosscompile a hello-world program but
> it
> > fails:
> > 
> >
>
/usr/local/lib/gcc-lib/mipsel-linux/2.96-mips3264-000710/../../../../mipsel-linux/bin/ld: cannot open crt1.o:
> > No such file or directory
> > collect2: ld returned 1 exit status
> > 
> > There are several postings in the archives but non
of
> > them helped me on so far. I will probably have to
get
> > the libc for mipsel-linux - but where can I get it
and
> > what to do with it ??
> 
> You need to install libc; the crt1.o file would end up
> being in
> /usr/local/mipsel-linux/lib/crt1.o then.
> 
>   Ralf

Hi,
what libc do I have to install and where can I get it.
I have libc6 installed:

inspiron:~# apt-get install libc6
Reading Package Lists... Done
Building Dependency Tree... Done
libc6 is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 1 not
upgraded.

inspiron:~# apt-get install libc6-dev
Reading Package Lists... Done
Building Dependency Tree... Done
libc6-dev is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 1 not
upgraded.

inspiron:~# uname -a
Linux inspiron 2.4.26 #7 Thu Sep 9 17:11:08 CEST 2004
i686 GNU/Linux

inspiron:/# find -name crt1.o
./usr/lib/crt1.o
inspiron:~#

Would be very happy if anybody could give me an hint
how to get it work...

thx

Thomas
