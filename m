Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 16:32:42 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:45764 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20039173AbWKAQcf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2006 16:32:35 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Cannot run N32 binaries.
Date:	Wed, 1 Nov 2006 08:32:27 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D44D2C5@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cannot run N32 binaries.
Thread-Index: Acb9bKd0RJqzXaylRYertPgeqD+j7QAY/WpQ
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ilya A. Volynets-Evenbakh wrote:
> Could be looking for non-existant ld.so.1 (do you have N32 
> version of it
> in /lib32?)

That is correct. If I make a /lib32 -> lib symbolic link, everything
runs.

I actually built the libs under /lib, but I did not realize that ld
simply writes a hard-coded path for the dynamic linker into executables.

That is to say, I built an all-n32 system, using /lib and /usr/lib.

This is elegant, but probably a bad idea, so I will go back to the
/lib32 scheme.
