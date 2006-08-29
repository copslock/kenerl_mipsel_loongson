Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 00:06:44 +0100 (BST)
Received: from mail01.hansenet.de ([213.191.73.61]:23209 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20027569AbWH2XGm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Aug 2006 00:06:42 +0100
Received: from [213.39.141.233] (213.39.141.233) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EA7D5F0020432A; Wed, 30 Aug 2006 01:06:16 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 8E8702C416;
	Wed, 30 Aug 2006 01:06:15 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date:	Wed, 30 Aug 2006 01:05:26 +0200
User-Agent: KMail/1.9.3
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608222227.20181.thomas.koeller@baslerweb.com> <44F459DD.8060902@ru.mvista.com>
In-Reply-To: <44F459DD.8060902@ru.mvista.com>
Organization: Basler AG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608300105.26921.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Tuesday 29 August 2006 17:14, Sergei Shtylyov wrote:
> > Also, it seems to me that the whole register-mapping stuff conflicts with
> > autodetection, because autoconfig() uses serial_inp() and serial_outp()
> > before the port types, and hence the mapping requirements, are known.
>
>     Port types have nothing to do with this. Or at least they hadn't until
> your recent patch. :-)
>     iotype was used to identify the addressing scheme, and it's alsready
> known beforehand.

How so? If I do not yet know which hardware I am dealing with, how can I know
the iotype?

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
