Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2006 17:00:46 +0100 (BST)
Received: from mail03.hansenet.de ([213.191.73.10]:60670 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20039029AbWH0QAn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Aug 2006 17:00:43 +0100
Received: from [213.39.141.67] (213.39.141.67) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EA7C92001684B6; Sun, 27 Aug 2006 18:00:27 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 92FCF1770B9;
	Sun, 27 Aug 2006 18:00:27 +0200 (CEST)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Suppress compiler warnings
Date:	Sun, 27 Aug 2006 18:00:27 +0200
User-Agent: KMail/1.9.3
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <200608271353.16681.thomas@koeller.dyndns.org> <Pine.LNX.4.62.0608271411250.26709@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0608271411250.26709@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608271800.27441.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

On Sunday 27 August 2006 14:12, Geert Uytterhoeven wrote:
> On Sun, 27 Aug 2006 thomas@koeller.dyndns.org wrote:
> > The excite platform exports hardware resources for device drivers to use.
> > Any driver wanting to use these resources will look up them by their
> > names. Since these resources are declared to have static linkage, but are
> > not used in the source file defining them, the compiler used to emit an
> > 'unused' warning, which this patch suppresses.
>
> How can a driver look them up, if they are not linked in in some structure?
>
> Gr{oetje,eeting}s,
>
> 						Geert

It uses the standard platform device/driver mechanism: the platform registers
a platform device (to which the resources are attached) with the platform bus.
The driver registers a platform driver with the platform bus. The bus matches
drivers and devices and calls the probe routine of any matching driver, at
which point the driver can look up the resources using platform_get_resource_byname().

Thomas
-- 
Thomas Koeller
thomas at koeller dot dyndns dot org
