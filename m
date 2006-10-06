Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 01:02:18 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:9315 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20039501AbWJGACO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2006 01:02:14 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: CFE problem: starting secondary CPU.
Date:	Fri, 6 Oct 2006 16:58:37 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D3E7324@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CFE problem: starting secondary CPU.
thread-index: Acbpo1bBhY91FwuRSxSoPT5JCpbUyw==
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Anyone seen a problem like this? cfe_cpu_start() works fine on a
32 bit kernel, but not on 64.

I added a function to cfe/smp.c:

  static asmlinkage void dummy()
  {
    prom_printf("dummy called\n");
  }

This serves as the simplest possible "hello world". 

If I substitute this for the function passed to cfe_cpu_start(),
on a 32 bit kernel, the slave CPU calls the function and the
message is printed on the serial console.

On a 64 bit kernel, the function is never reached. The API call returns,
but the
secondary CPU never calls in.

The sign-extension of the address looks good. The function pointer looks
like
FFFFFFFF8XXXXXXX. This is cast to long before being assigned into the
right field
of the CFE request structure, where it is converted to 64 bit unsigned.

Inside CFE, the CPU is just looping around waiting for the address to
call with
a direct jump.

So it's a puzzling problem.
