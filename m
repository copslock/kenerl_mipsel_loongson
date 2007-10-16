Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 14:36:36 +0100 (BST)
Received: from web8408.mail.in.yahoo.com ([202.43.219.156]:26478 "HELO
	web8408.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039992AbXJPNg1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 14:36:27 +0100
Received: (qmail 15116 invoked by uid 60001); 16 Oct 2007 13:36:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=W5LZ0qUTvjlay2asfiWZTidrn4J266Mjir6ws3WH60QXjLbPy4wV3ZI4gJ6wlGMCd8uf0OQiXXGJy+quyAlmTeGr6Jzn41Kt5e0pdI/1Z37wImdgRr9U2nlbG13+u4kOLqzduMGgeaSj6BlGEkOhkPbBhoozcgIJAcCgMj5x6zo=;
X-YMail-OSG: JLyqRa8VM1ny1uQaCt_bYaOwiFIctXMZVti6uG4JnpXZ8NYIXW2by8XVC.gI9yvxmg--
Received: from [199.239.167.162] by web8408.mail.in.yahoo.com via HTTP; Tue, 16 Oct 2007 14:36:19 BST
Date:	Tue, 16 Oct 2007 14:36:19 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: how to use TLB to prevent Linux accessing a particular memory region 
To:	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <431051.14949.qm@web8408.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

I have a board, which has two processors ( one is MIPS
on which Linux-2.6.18 kernel runs and another is DSP
based processor) and 32MB DDR.

Out of 32MB of DDR 8MB is reserved for use by DSP
processor. But the MIPS processor downloads firmware
into this reserved memory for the DSP.

Now, is it possible to use the TLB to prevent Linux
from accessing the reserved memory after the firmware
has been downloaded?

Also we'd need to remove those TLB entries if the
firmware would ever need to be reloaded to the DSP'
memory region.

What are the APIs to be used to achieve the above?


Thanks in advance.

Regards,
Veerasena.


      5, 50, 500, 5000 - Store N number of mails in your inbox. Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
