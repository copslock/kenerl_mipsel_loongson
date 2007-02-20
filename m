Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 17:04:36 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:42937 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038964AbXBTREc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2007 17:04:32 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Clean up serial console support on Sibyte 1250 duart
Date:	Tue, 20 Feb 2007 09:03:56 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D627017@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Clean up serial console support on Sibyte 1250 duart
Thread-Index: AcdUgSFzhHEL8TrSSdia4KgRjykhOgAj6/Jw
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Andrew Sharp" <tigerand@gmail.com>, <linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Andrew Sharp wrote:
> Clean up the serial console support on the Sibyte 1250's
> built in duart.

Hi Andrew,

Would it be too much trouble to split the patch into two: the whitespace
changes, and the actual bugfix?
