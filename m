Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 16:48:28 +0100 (BST)
Received: from mailout03.sul.t-online.com ([IPv6:::ffff:194.25.134.81]:43681
	"EHLO mailout03.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8226121AbVDAPsL>; Fri, 1 Apr 2005 16:48:11 +0100
Received: from fwd26.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1DHONW-0006Bg-01; Fri, 01 Apr 2005 17:48:10 +0200
Received: from denx.de (ZB7vNEZQ8eZAiBtlsjafTBsXcAHZ9FKzvJV7zZZgNlPINfBYRoWB6M@[84.150.103.19]) by fwd26.sul.t-online.de
	with esmtp id 1DHONN-0k6iRM0; Fri, 1 Apr 2005 17:48:01 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id A660A42BA4; Fri,  1 Apr 2005 17:48:00 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 5984BC108D; Fri,  1 Apr 2005 17:48:00 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 56F0313D94A; Fri,  1 Apr 2005 17:48:00 +0200 (MEST)
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: [Fwd: Re: Some questions about kernel tailoring] 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 01 Apr 2005 09:15:59 +0200."
             <20050401071559.69834.qmail@web25109.mail.ukl.yahoo.com> 
Date:	Fri, 01 Apr 2005 17:47:55 +0200
Message-Id: <20050401154800.5984BC108D@atlas.denx.de>
X-ID:	ZB7vNEZQ8eZAiBtlsjafTBsXcAHZ9FKzvJV7zZZgNlPINfBYRoWB6M@t-dialin.net
X-TOI-MSGID: c482d187-0be4-4b2a-82ec-7ab20a127027
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20050401071559.69834.qmail@web25109.mail.ukl.yahoo.com> you wrote:
> > Don't re-invent the wheel. Consider using (porting)
> > U-Boot.
> 
> BTW, do you know how big is U-Boot ?

Sure :-)

This depends on which features you have on your board  and  configure
into  U-Boot. Typical image sizes are 150...200 kB with most features
enabled (network support including TFTP, DHCP, NFS; hush  shell  with
the  capability  to  run shell scripts; support for IDE, CompactFlash
cards, USB (memory sticks), NAND flash; support  for  DOS,  ext2  and
JFFS2  filesystems;  graphical display on LCD/VGA, splash screen etc.
etc.). The biggest configuration I am  aware  of  at  the  moment  is
280kB; small configurations can be fit in 128 kB; if you really throw
out everything you can get rid of you may even make it fit into 64kB.
As  mentioned  before:  this  depends  on  architecture  and hardware
features that have to be supported.


And referring to the original question:  of  course  U-Boot  supports
booting  of  compressed images (kernel, ramdisk, other) uzing gzip or
gzip2 compression.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Respect is a rational process
	-- McCoy, "The Galileo Seven", stardate 2822.3
