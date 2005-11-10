Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 17:51:35 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:61572 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S3458470AbVKJRvS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Nov 2005 17:51:18 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 51717C06E
	for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 18:52:40 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 1654A1BC089
	for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 18:52:45 +0100 (CET)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 9B3B41A18A5
	for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 18:52:45 +0100 (CET)
Subject: Re: smc91x support
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1131636585.4890.14.camel@localhost.localdomain>
References: <1131634331.18165.30.camel@localhost.localdomain>
	 <1131636585.4890.14.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Thu, 10 Nov 2005 18:52:47 +0100
Message-Id: <1131645167.1478.13.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> Meanwhile I've attached the patch here.

Thank you.
I'll check it with mine and let you know, what I did.

Just one think:
-       depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6 ||
M32R || SUPERH)
+       depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6 ||
M32R || SUPERH || SOC_AU1X00)

Wouldn't it be better to use SOC_AU1200 instead of SOC_AU1X00, because
only AU1200 does not have integrated Ethernet controller?

BR,
Matej
