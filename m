Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 23:32:08 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:11659 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20038522AbWIFWcG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2006 23:32:06 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id k86MWPDW023600
	for <linux-mips@linux-mips.org>; Wed, 6 Sep 2006 15:32:26 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k86MWPpS013821;
	Thu, 7 Sep 2006 00:32:25 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k86MWOUo013820;
	Thu, 7 Sep 2006 00:32:24 +0200
Date:	Thu, 7 Sep 2006 00:32:24 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Resetting a Broadcom in software
Message-ID: <20060906223224.GA12175@linux-mips.org>
References: <20060906214136.54752.qmail@web31504.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906214136.54752.qmail@web31504.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Virus-Scanned: ClamAV 0.88.2/1594/Wed Jul 12 08:04:34 2006 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 06, 2006 at 02:41:36PM -0700, Jonathan Day wrote:
> Date:	Wed, 6 Sep 2006 14:41:36 -0700 (PDT)
> From:	Jonathan Day <imipak@yahoo.com>
> Subject: Resetting a Broadcom in software
> To:	linux-mips@linux-mips.org
> Content-Type: multipart/mixed; boundary="0-1897457798-1157578896=:54718"
> 
> Hi,
> 
> A co-worker wrote the following test of the Broadcom's
> maths abilities and discovered that it reboots some
> (but not all) MIPS processors it has been tested on.
> It'll reboot the Sentosa, for example, but NOT the
> Swarm.
> 
> (Apologies for the ugly coding, btw.)
> 
> You just make the first file, the ATL_ file gets
> included into it. The compiler flags I'm using are:
> 
> -march=sb1 -mabi=64 -fomit-frame-pointer -O3 -mips64
> -mfused-madd
> 
> The program doesn't link to anything and no linker
> flags are needed.
> 
> This begs three questions:
> 
> 1) What is happening to cause the CPU to reset? (It's
> not a kernel bug, it's an actual CPU reset)
> 
> 2) What is NOT happening on the Swarm, allowing it to
> work fine?
> 
> 3) Is the problem in the category of "preventable in
> hardware", "preventable in the kernel", or
> "preventable by slowly roasting those coders who write
> like this"?

This is not a problem I know of but given your description it sounds very
much like a hardware issue.  Can you find about the exact versions of the
1250 on the various board?  With the FPU being on chip I would expect
some correlation between the chip revision and this issue.

  Ralf
