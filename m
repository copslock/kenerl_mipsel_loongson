Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2006 22:16:37 +0100 (BST)
Received: from mail01.hansenet.de ([213.191.73.61]:29926 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037637AbWHOVQd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Aug 2006 22:16:33 +0100
Received: from [213.39.220.194] (213.39.220.194) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44DC9FF7000F7C40; Tue, 15 Aug 2006 23:15:56 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 654C51770E6;
	Tue, 15 Aug 2006 23:15:55 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date:	Tue, 15 Aug 2006 23:15:54 +0200
User-Agent: KMail/1.9.3
Cc:	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <44DCDCED.7000404@ru.mvista.com>
In-Reply-To: <44DCDCED.7000404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608152315.55104.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Friday 11 August 2006 21:39, Sergei Shtylyov wrote:
>     I highly doubt this is how it should be done. Look at the Alchemy code
> as an example how the "partly-compatible" UART support should be written.
> Alchemy also has 32-bit MMIO and some registers mapped differently.
>
> WBR, Sergei

Seems I cannot find the code you are referring to - could you point me at
the particular file(s) to look at?

Thanks,
Thomas
-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
