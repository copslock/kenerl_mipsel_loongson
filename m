Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2006 01:02:41 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:2751 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039700AbWJQACj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2006 01:02:39 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 822C3E4050;
	Mon, 16 Oct 2006 17:27:03 -0700 (PDT)
Subject: Base Address: VIA Southbridge
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Cc:	mlachwani@mvista.com, ppopov@embeddedalley.com,
	kaz@zeugmasystems.com, alan@lxorguk.ukuu.org.uk, mchitale@gmail.com
Content-Type: text/plain
Date:	Mon, 16 Oct 2006 17:12:19 -0700
Message-Id: <1161043939.6620.24.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m working on porting the 2.6.14.6 Linux kernel to the Encore M3 board
that has the AU1500 MIPS processor on it and is supported by the 2.4
kernel.  

The board has a serial port on a VIA82C686B Southbridge that is on the
PCI bus.  Currently, the kernel hangs at the console_init function.  A
kernel oops is generated following a page fault in the serial_out
function as the address of the serial port given to the kernel is
incorrect.  

According to the reference manual for this board, 0x5000 0000 is the I/O
Space address register. It is used to access PCI I/O space for devices
that require I/O access.  How do I find the Base address for the
Southbridge?  Once I find this, I can add an offset of 0x3F8 and access
COM 1.  

I realise my questions are basic, but I am a beginner in Linux and
appreciate your feedback.
Thanks,

Ashlesha.
