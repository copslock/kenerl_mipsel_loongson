Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 16:37:10 +0000 (GMT)
Received: from dhcp-1286-9.blizz.at ([IPv6:::ffff:213.143.126.4]:22420 "EHLO
	cervus.intra") by linux-mips.org with ESMTP id <S8225274AbVATQhG>;
	Thu, 20 Jan 2005 16:37:06 +0000
Received: from xterm.intra ([10.49.1.10])
	by cervus.intra with esmtp (Exim 4.34)
	id 1CrfIu-0003Xi-5k; Thu, 20 Jan 2005 17:37:04 +0100
Subject: Re: Au1000 Big Endian USB OHCI
From:	Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To:	Thomas Sailer <sailer@scs.ch>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1106238575.8838.9.camel@kronenbourg.scs.ch>
References: <1106238575.8838.9.camel@kronenbourg.scs.ch>
Content-Type: text/plain
Organization: Research Group for Industrial Software @ Vienna University of
	Technology
Date:	Thu, 20 Jan 2005 17:37:03 +0100
Message-Id: <1106239023.4048.13.camel@xterm.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

On Thu, 2005-01-20 at 17:29 +0100, Thomas Sailer wrote:
> does the Au1000 OHCI controller work for anybody with the current 2.6
> cvs tree in big endian mode? When I try to insmod ohci-hcd, the machine
> just hangs. Also, I used the attached patch to be able to select usb
> ohci even without PCI.

I'm successfully running linux 2.6.10 on an au15xx in big endian mode,
with some slight modifications to the usb code, for which I posted a
patch on the list some time ago (22 Nov 2004)...

regards,
-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Research Group for Industrial Software @ Vienna University of Technology
