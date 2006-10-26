Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 00:05:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31665 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038813AbWJZXFv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Oct 2006 00:05:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.7) with ESMTP id k9QN6MEb002308;
	Fri, 27 Oct 2006 00:06:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9QN690G002296;
	Fri, 27 Oct 2006 00:06:09 +0100
Date:	Fri, 27 Oct 2006 00:06:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Azer, William" <Bill.Azer@drs-ss.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sanblaze driver -> LSFC929 FiberChannel
Message-ID: <20061026230553.GA1485@linux-mips.org>
References: <DEB94D90ABFC8240851346CFD4ACFF14AD2ADD@gamd-ex-001.ss.drs.master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEB94D90ABFC8240851346CFD4ACFF14AD2ADD@gamd-ex-001.ss.drs.master>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 26, 2006 at 04:39:42PM -0400, Azer, William wrote:

> i am using the sanblaze card configured in the kernel for the
> fiberchannel.  i enabled the mpt fusion fc and the ioctl driver, i also
> enable scsi disk support, ...

This is the first user report for such a device on MIPS ever afaics.
A few more details on your system, messages etc. could be useful to
solve your issue.

  Ralf
