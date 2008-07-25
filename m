Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 22:45:26 +0100 (BST)
Received: from web25808.mail.ukl.yahoo.com ([217.12.10.193]:42418 "HELO
	web25808.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28580970AbYGYVpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 22:45:24 +0100
Received: (qmail 76795 invoked by uid 60001); 25 Jul 2008 21:45:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=lcw/n3Ddf7NZmBOqvCdpstx1Lm9RNL8n18nDGP3i/2ojfGChylvdUSq3GnA4+URw8ZdhSLI2gRNhlUQtL907fhecGmu+0NKhHXWoId/LSn8gPFQnP5iubkiKgb846b2RECGfouZefrvgBb0hvxXPAqhOEdG0/IA4XlI+4V9k/D8=;
Received: from [87.114.137.160] by web25808.mail.ukl.yahoo.com via HTTP; Fri, 25 Jul 2008 21:45:18 GMT
X-Mailer: YahooMailWebService/0.7.218
Date:	Fri, 25 Jul 2008 21:45:18 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Reply-To: glynastill@yahoo.co.uk
Subject: Debian etch on cobalt
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <633357.76258.qm@web25808.mail.ukl.yahoo.com>
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips

Hi Chaps,

I'm trying to get going with debian etch on a cobalt qube2. Unfortunately it dies randomly whilst I try to compile postgres.

I tried subscribing to the debian mipsel ilist with no luck.

I used the following image:
 http://ftp.nl.debian.org/debian/dists/etch/main/installer-mipsel/current/images/cobalt/nfsroot.tar.gz

Other than that I've done little else other than apt-get update and apt-get upgrade to use the latest kernel.

When I start compiling postgres 8.3.3 it crashes randomly, if I keep rebooting I can get it compiled, however theres something seriously sh*gged here.

Are there known problems? Is there anything I can do to help, anything I can do to get a kernel core dump? How would I go about getting LKCD going?


      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
