Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 21:44:13 +0000 (GMT)
Received: from mail.scs.ch ([IPv6:::ffff:212.254.229.5]:21933 "EHLO
	mail.scs.ch") by linux-mips.org with ESMTP id <S8225285AbVATVoH>;
	Thu, 20 Jan 2005 21:44:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j0KLi2vo006975
	for <linux-mips@linux-mips.org>; Thu, 20 Jan 2005 22:44:02 +0100
Received: from mail.scs.ch ([127.0.0.1])
 by localhost (mail.scs.ch [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 06767-04 for <linux-mips@linux-mips.org>;
 Thu, 20 Jan 2005 22:43:58 +0100 (CET)
Received: from kronenbourg.scs.ch (190.scs.ch [212.254.229.190])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j0KLhstq006969
	for <linux-mips@linux-mips.org>; Thu, 20 Jan 2005 22:43:54 +0100
Subject: Re: Au1000 Big Endian USB OHCI
From:	Thomas Sailer <sailer@scs.ch>
To:	linux-mips@linux-mips.org
In-Reply-To: <1106238575.8838.9.camel@kronenbourg.scs.ch>
References: <1106238575.8838.9.camel@kronenbourg.scs.ch>
Content-Type: text/plain
Organization: SCS
Date:	Thu, 20 Jan 2005 22:43:53 +0100
Message-Id: <1106257433.7458.0.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at scs.ch
Return-Path: <sailer@scs.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sailer@scs.ch
Precedence: bulk
X-list: linux-mips

On Thu, 2005-01-20 at 17:29 +0100, Thomas Sailer wrote:

> does the Au1000 OHCI controller work for anybody with the current 2.6
> cvs tree in big endian mode? When I try to insmod ohci-hcd, the machine
> just hangs. Also, I used the attached patch to be able to select usb
> ohci even without PCI.

Ok, now I've tried little endian, and it didn't help. ohci-hcd in EL
mode also hangs the system. So it's quite likely not related to the
endianness mode.

Tom
