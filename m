Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 14:48:01 +0100 (BST)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:60861
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225193AbTEUNr7>; Wed, 21 May 2003 14:47:59 +0100
Received: from dhcp22.swansea.linux.org.uk (dhcp22.swansea.linux.org.uk [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.8/8.12.5) with ESMTP id h4LCnnRQ000966;
	Wed, 21 May 2003 13:49:50 +0100
Received: (from alan@localhost)
	by dhcp22.swansea.linux.org.uk (8.12.8/8.12.8/Submit) id h4LCnjTk000964;
	Wed, 21 May 2003 13:49:46 +0100
X-Authentication-Warning: dhcp22.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: lwl-lwr
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
	Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20030521013449.A16378@linux-mips.org>
References: <1053455551.996c4860yaelgilad@myrealbox.com>
	 <025401c31f03$0e993370$10eca8c0@grendel>
	 <20030521013449.A16378@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053521383.32700.21.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 May 2003 13:49:45 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mer, 2003-05-21 at 01:34, Ralf Baechle wrote:
> > of the base MIPS instruction set.  If one wants to live without them, 
> > one can either rig a compiler to emit multi-instruction sequences instead 
> > of lwr/lwl to do the appropriate shifts and masks (which is slower on all 

This would seem the sane approach. 

> Technically you're right ...  In reality lwl/lwr are covered by US patent
> 4,814,976 which would also cover a software implementation.  So unless MIPS
> grants a license for the purpose of emulation in the Linux kernel ...

They would need to grant a license for general GPL use, the GPL itself
does not intend to allow other restrictions that would make the code non
free. There are a billion examples of prior art for software fixing up
of exceptions and software emulation of alignment fixups however.

Maybe MIPS can clarify their position officially.
