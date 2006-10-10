Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 18:20:54 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:43894 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20039888AbWJJRUw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 18:20:52 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CFE problem: starting secondary CPU.
Date:	Tue, 10 Oct 2006 10:20:50 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D3E73D2@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CFE problem: starting secondary CPU.
thread-index: Acbpo1bBhY91FwuRSxSoPT5JCpbUywCN3gGQACzu07A=
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Cc:	<mason@broadcom.com>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Mark E Mason: 
> Kaz Kylheku:
> > 
> > Anyone seen a problem like this? cfe_cpu_start() works fine on a
> > 32 bit kernel, but not on 64.
> 
> Which version of CFE are you using?  We'd seen something like 
> this with
> the 1480 eval boards, some specific versions of CFE, and 64-bit SMP
> Linux.

I see in the release notes that something was fixed in 1.2.4 that could
prevent 64 bit SMP from booting: a bug that was preventing the upper
halves of registers from being saved. Is that what you are talking
about?

We are on 1.3.0.

Thanks.
