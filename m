Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 21:27:43 +0100 (BST)
Received: from mail01.hansenet.de ([213.191.73.61]:47289 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037719AbWHVU1k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Aug 2006 21:27:40 +0100
Received: from [213.39.167.52] (213.39.167.52) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EA7D5F00036A5F; Tue, 22 Aug 2006 22:27:21 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 63A771770E8;
	Tue, 22 Aug 2006 22:27:20 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] RM9000 serial driver
Date:	Tue, 22 Aug 2006 22:27:20 +0200
User-Agent: KMail/1.9.3
Cc:	sshtylyov@ru.mvista.com, rmk+serial@arm.linux.org.uk,
	linux-serial@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org,
	Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
Organization: Basler AG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608222227.20181.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Tuesday 22 August 2006 02:59, Yoichi Yuasa wrote:
>
> If you have an another standard 8250 port. this driver cannot support it
> You should do as well as AU1X00.
>
> Yoichi

The AU1X00 code obviously assumes that every port that is not an AU1X00 is
a standard port requiring no register mapping. However, this is of course
not necessarily true in the most general case. There could be platforms
with multiple ports, all non-standard, but in different ways. Handling this
would require per-port mapping functions, which could be achieved by adding
function pointers to struct uart_8250_port. However, this would add the
overhead of a real, non-inlined function call to every register access.

Also, it seems to me that the whole register-mapping stuff conflicts with
autodetection, because autoconfig() uses serial_inp() and serial_outp()
before the port types, and hence the mapping requirements, are known.
This is not a problem for me, however, since the correct port type is
set up by the platform using early_serial_setup().

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
