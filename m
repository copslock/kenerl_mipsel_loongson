Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 16:59:19 +0000 (GMT)
Received: from mail.scs.ch ([IPv6:::ffff:212.254.229.5]:50307 "EHLO
	mail.scs.ch") by linux-mips.org with ESMTP id <S8225398AbVBWQ7D>;
	Wed, 23 Feb 2005 16:59:03 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j1NGvfRn010233;
	Wed, 23 Feb 2005 17:57:41 +0100
Received: from mail.scs.ch ([127.0.0.1])
 by localhost (mail.scs.ch [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 10151-03; Wed, 23 Feb 2005 17:57:39 +0100 (CET)
Received: from kronenbourg.scs.ch (190.scs.ch [212.254.229.190])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j1NGvaqf010227;
	Wed, 23 Feb 2005 17:57:36 +0100
Subject: Re: Big Endian au1550
From:	Thomas Sailer <sailer@scs.ch>
To:	Dan Malek <dan@embeddededge.com>
Cc:	JP Foster <jp.foster@exterity.co.uk>, linux-mips@linux-mips.org
In-Reply-To: <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
References: <1109157737.16445.6.camel@localhost.localdomain>
	 <000301c5199d$3154ad40$0300a8c0@Exterity.local>
	 <1109160313.16445.20.camel@localhost.localdomain>
	 <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
Content-Type: text/plain
Organization: SCS
Date:	Wed, 23 Feb 2005 17:57:36 +0100
Message-Id: <1109177856.18018.13.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at scs.ch
Return-Path: <sailer@scs.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sailer@scs.ch
Precedence: bulk
X-list: linux-mips

On Wed, 2005-02-23 at 10:03 -0500, Dan Malek wrote:

> The only issues with big endian Au1xxx is the USB and potentially
> PCI.  There have been recent patches posted for USB that could
> fix this.  The PCI problem is with the read/write/in/out macros.

Last time I tried (about a month ago using the then current linux-mips
2.6 CVS tree), USB host didn't work neither in big nor little endian
mode on my AMD Pb1000. Ethernet and Serial worked either way.

Tom
