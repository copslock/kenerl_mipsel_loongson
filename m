Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 13:51:21 +0100 (BST)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:34971
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225208AbTDIMvU>; Wed, 9 Apr 2003 13:51:20 +0100
Received: from dhcp22.swansea.linux.org.uk (dhcp22.swansea.linux.org.uk [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.8/8.12.5) with ESMTP id h39Br4RN010216;
	Wed, 9 Apr 2003 12:53:04 +0100
Received: (from alan@localhost)
	by dhcp22.swansea.linux.org.uk (8.12.8/8.12.8/Submit) id h39Br2YP010214;
	Wed, 9 Apr 2003 12:53:02 +0100
X-Authentication-Warning: dhcp22.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: pci graphics card for malta running linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jun Sun <jsun@mvista.com>
Cc: Earl Mitchell <earlmips@yahoo.com>, linux-mips@linux-mips.org
In-Reply-To: <20030408144556.E6865@mvista.com>
References: <20030408175517.66121.qmail@web20708.mail.yahoo.com>
	 <1049833899.8939.9.camel@dhcp22.swansea.linux.org.uk>
	 <20030408144556.E6865@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049889181.9901.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 12:53:02 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2003-04-08 at 22:45, Jun Sun wrote:
> > getting an old voodoo1/voodoo2 off ebay. They report as multimedia
> > devices and the current kernel fb driver can bootstrap them from
> > cold on little or big endian systems with no bios support (tested
> > on parisc, x86 etc)
> >
> 
> When I played with voodoo cards, I needed a different voodoo driver
> for fb to work.  See http://www.medex.hu/~danthe/tdfx/.

tdfx is voodoo3, sstfb is voodoo1/2
