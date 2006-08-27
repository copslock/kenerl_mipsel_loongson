Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2006 17:35:54 +0100 (BST)
Received: from mail03.hansenet.de ([213.191.73.10]:32921 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20039027AbWH0Qfw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Aug 2006 17:35:52 +0100
Received: from [80.171.16.252] (80.171.16.252) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EA7C920016A091; Sun, 27 Aug 2006 18:35:47 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id C98CA1C9834;
	Sun, 27 Aug 2006 18:35:46 +0200 (CEST)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Add configuration variables for RM9xxx processor
Date:	Sun, 27 Aug 2006 18:35:46 +0200
User-Agent: KMail/1.9.3
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
References: <200608271351.48462.thomas@koeller.dyndns.org> <44F191E5.30208@ru.mvista.com>
In-Reply-To: <44F191E5.30208@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608271835.46497.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

On Sunday 27 August 2006 14:36, Sergei Shtylyov wrote:
> >
> > +config SERIAL_RM9000
> > +	bool
> > +
>
>     Haven't you just renamed this option to SERIAL_8250_RM9K?
>

No, that's a different one. SERIAL_RM9000 is meant to express that
the platform provides support for this kind of hardware, whereas
SERIAL_8250_RM9K configures support for this into 8250.c.

Thomas
-- 
Thomas Koeller
thomas@koeller.dyndns.org
