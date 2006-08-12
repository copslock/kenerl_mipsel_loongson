Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 01:13:09 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:53141 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20045180AbWHLANH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 01:13:07 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
Date:	Fri, 11 Aug 2006 17:12:59 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D33B059@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
Thread-Index: Aca9mWjXridcC2XhRuuRkMfg/RXADwACZD7g
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle:
> I've got a success and a failure report for BCM1480 systems, both with
> fairly recent kernels and 2.6.17.
> 
>   Ralf
> 

Thanks a lot Ralf.

The git bisect tool looks very cool; I will probably make use of it in
the future. However, I solved the problem at hand. It's the interrupt
dispatcher. I forward-ported the old assembly-language interrupt
dispatcher and the system now boots.

If I have time, I might look at the C code to see what it does
differently from the assembly code and try to fix it.

Cheers ...
