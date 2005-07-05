Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 17:53:41 +0100 (BST)
Received: from mercurio.srv.dsi.unimi.it ([IPv6:::ffff:159.149.130.201]:64688
	"EHLO mercurio.srv.dsi.unimi.it") by linux-mips.org with ESMTP
	id <S8226262AbVGEQxV>; Tue, 5 Jul 2005 17:53:21 +0100
Received: from thetys.sm.dsi.unimi.it (tethys.sm.dsi.unimi.it [159.149.132.22])
	by mercurio.srv.dsi.unimi.it (8.13.3/8.13.3) with ESMTP id j65GrVG3000640;
	Tue, 5 Jul 2005 18:53:31 +0200
From:	Arianna Arona <arianna@dsi.unimi.it>
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Subject: Re: 2.6.12 does not read MAC address
Date:	Tue, 5 Jul 2005 18:54:21 +0200
User-Agent: KMail/1.5.4
Cc:	linux-mips@linux-mips.org
References: <200507051643.09070.arianna@dsi.unimi.it> <42CA9FF3.8060504@total-knowledge.com>
In-Reply-To: <42CA9FF3.8060504@total-knowledge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051854.21868.arianna@dsi.unimi.it>
X-DSI-MailScanner-Information: Please contact the staff for more information
X-DSI-MailScanner: Found to be clean
X-MailScanner-From: arianna@dsi.unimi.it
Return-Path: <arianna@dsi.unimi.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arianna@dsi.unimi.it
Precedence: bulk
X-list: linux-mips

On Tuesday 05 July 2005 16:57, Ilya A. Volynets-Evenbakh wrote:
>
> No you are wrong. Forcing MAC address works just fine. At least it does
> so here.
> You just have to force it to correct value (i.e. the one origin was
> using when it was sending bootp/tftp packets.

I've forced it using: ifconfig eth0 hw ether 08:00:69:0d:16:00,
where 08:00:69:0d:16:00 is MAC address.
After that ifconfig command has right values, but no bits are transmitted.
The one I've used is the right way?

A.



-- 
Arianna Arona
Servizi Informatici
Dipartimento di Scienze dell'Informazione
Via Comelico 39
20135 Milano
