Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 22:30:05 +0100 (BST)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:38042
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225072AbTDHVaE>; Tue, 8 Apr 2003 22:30:04 +0100
Received: from dhcp22.swansea.linux.org.uk (dhcp22.swansea.linux.org.uk [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.8/8.12.5) with ESMTP id h38KVlRN009016;
	Tue, 8 Apr 2003 21:31:47 +0100
Received: (from alan@localhost)
	by dhcp22.swansea.linux.org.uk (8.12.8/8.12.8/Submit) id h38KVe7V009014;
	Tue, 8 Apr 2003 21:31:40 +0100
X-Authentication-Warning: dhcp22.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: pci graphics card for malta running linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Earl Mitchell <earlmips@yahoo.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20030408175517.66121.qmail@web20708.mail.yahoo.com>
References: <20030408175517.66121.qmail@web20708.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049833899.8939.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Apr 2003 21:31:40 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2003-04-08 at 18:55, Earl Mitchell wrote:
> Does anybody have any good reccs for PCI graphcis cards I can use with
> Malta board running linux? Some linux device drivers assume x86. If
> you know some PCI cards that work with linux/mips on malta let me know
> (especially nVidia or ATI cards). Also any PCI sound cards that work
> too. 

Nvidia and ATI cards require you run the BIOS firmware to boot them. 
XFree86 can do that for the ATI at least. If you just need to ram 
something into a box so you can see what is going up I'd suggest
getting an old voodoo1/voodoo2 off ebay. They report as multimedia
devices and the current kernel fb driver can bootstrap them from
cold on little or big endian systems with no bios support (tested
on parisc, x86 etc)

Not bad for <$10 a card although nobody has made Glide work big endian
so you can do 3D yet 8)

Alan
