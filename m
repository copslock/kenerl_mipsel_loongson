Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2006 05:08:46 +0100 (BST)
Received: from mail.soc-soft.com ([202.56.254.199]:48139 "EHLO
	igateway.soc-soft.com") by ftp.linux-mips.org with ESMTP
	id S8133382AbWDKEIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2006 05:08:36 +0100
Received: from keys.soc-soft.com ([192.168.4.44]) by igateway.soc-soft.com with InterScan VirusWall; Tue, 11 Apr 2006 09:50:15 +0530
Received: from soc-mail.soc-soft.com ([192.168.4.25])
  by keys.soc-soft.com (PGP Universal service);
  Tue, 11 Apr 2006 09:46:30 +0530
X-PGP-Universal: processed;
	by keys.soc-soft.com on Tue, 11 Apr 2006 09:46:30 +0530
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: Init not working in 64-bit kernel
Date:	Tue, 11 Apr 2006 09:50:14 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C015D8605@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Init not working in 64-bit kernel
Thread-Index: AcZMK/OMEVIBy6A9QvKes6ftrrvuVgQ8q/Gw
From:	<Vadivelan@soc-soft.com>
To:	<anemo@mba.ocn.ne.jp>, <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <Vadivelan@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vadivelan@soc-soft.com
Precedence: bulk
X-list: linux-mips


Hi,
	I'm sry.  I couldn't reply immediately.
I've fixed the problem. U'r suggestion was valuable. I've signed
extended the addresses required and I'm able to boot the board.

Thanking u.

Regards,
Vadi.

-----Original Message-----
From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp]
Sent: Monday, March 20, 2006 8:08 PM
To: ralf@linux-mips.org
Cc: Vadivelan M; linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel


>>>>> On Mon, 20 Mar 2006 13:14:52 +0000, Ralf Baechle
>>>>> <ralf@linux-mips.org> said:

ralf> This kernel is already 15 months old and there have been a vast
ralf> number of bug fixes since.  And god knows what Montavista changed
ralf> in their kernel - I don't have the faintest idea.  In short, try a

ralf> modern kernel.  Btw, Linux 2.6.16 was released today and chances
ralf> are it'll solve alot of your issues.

I suppose he is trying 64bit kernel on RBTX4938 board, but the board
dependent code seems not ready for 64bit.  For example, there are some
0xff1fXXXX constants there and all these constants must be sign extended
(0xffffffffff1fXXXX) for 64bit.  Also these virtual address are mapped
to 36bit physical address 0xfff1fXXXX so some assumption in the 32bit
kernel (virt==phys for TX49 internal regs) is not true in 64bit kernel.

---
Atsushi Nemoto






The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If you are not
the intended recipient, please notify the sender and delete the message along with
any annexure. You should not disclose, copy or otherwise use the information contained
in the message or any annexure. Any views expressed in this e-mail are those of the
individual sender except where the sender specifically states them to be the views of
SoCrates Software India Pvt Ltd., Bangalore.
