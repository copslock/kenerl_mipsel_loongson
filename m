Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2T7xIA03963
	for linux-mips-outgoing; Thu, 28 Mar 2002 23:59:18 -0800
Received: from smtp.web.de (smtp02.web.de [217.72.192.151])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2T7xFq03960
	for <linux-mips@oss.sgi.com>; Thu, 28 Mar 2002 23:59:15 -0800
Received: from [80.141.104.82] (helo=there)
	by smtp.web.de with smtp (WEB.DE(Exim) 4.43 #48)
	id 16qrGh-0004Vu-00; Fri, 29 Mar 2002 08:57:51 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
From: Harald Koerfgen <hkoerfg@web.de>
Organization: none to speak of
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [patch] linux: declance multicast filter fixes
Date: Fri, 29 Mar 2002 08:57:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dave Airlie <airlied@csn.ul.ie>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1020328134253.11187B-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1020328134253.11187B-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16qrGh-0004Vu-00@smtp.web.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thursday 28 March 2002 14:01, Maciej W. Rozycki wrote:
>  But the I/O ASIC chip is smart enough to merge data from the 8-bit ROM
> device without problems and present four consecutive bytes as 32-bit
> quantities to the host CPU.

A simple 4 to 1 mapping is easy, even for the average hardware developer :-)

> Why couldn't it do the same for the LANCE?
> Host memory addresses are generated on behalf of the LANCE by the I/O ASIC
> anyway.

Probably because this would have made the IOASIC 0.0034 cents more expensive?

> Of course not all designers have a clue, sigh...  A brief study of
> available documentation suggests no merging mode was implemented for the
> LANCE and bit 0 of addresses generated is simply hardwired to 0. :-(

That's my interpretation as well.

Greetings,
Harald
