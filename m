Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 22:02:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62862 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038992AbXBTWCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 22:02:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1KM2Be9017791;
	Tue, 20 Feb 2007 22:02:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1KM2AGC017790;
	Tue, 20 Feb 2007 22:02:10 GMT
Date:	Tue, 20 Feb 2007 22:02:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add basic SMARTMIPS ASE support
Message-ID: <20070220220210.GA10404@linux-mips.org>
References: <45C369CB.2040400@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45C369CB.2040400@innova-card.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 02, 2007 at 05:41:47PM +0100, Franck Bui-Huu wrote:

> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> This patch adds trivial support for SMARTMIPS extension. This
> extension is currently implemented by 4KS[CD] CPUs.

The SmartMIPS ASE according to the spec is explicitly for MIPS32, so I'm
stripping the 64-bit kernel bits of it.  I also did a bit of Kconfig
polishing to make SmartMIPS selectable on those platforms which might
actually have such a CPU only, that is currently all the FPGA-based
platforms, Altas, SEAD and Malta.

  Ralf
