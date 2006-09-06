Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 18:47:50 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:39527 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038428AbWIFRrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2006 18:47:20 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Wire up set_robust_list(2) and get_robust_list(2)
Date:	Wed, 6 Sep 2006 10:47:16 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D38FEF5@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Wire up set_robust_list(2) and get_robust_list(2)
Thread-Index: AcbRufh0ljGa+eRQSYOoVReewsCxZwAFtHYw
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, <linux-mips@linux-mips.org>
Cc:	<ralf@linux-mips.org>, <drow@false.org>,
	<libc-ports@sources.redhat.com>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Arigato gozaimas, Nemoto-san!

I have applied your patch (actually back-ported it to the 2.6.17.7
kernel I'm using).

I built the kernel, and then recompiled glibc against the patched
headers, and booted into the SB1-based board.

The NPTL robust mutex test cases pass now, including the process-shared
one.
