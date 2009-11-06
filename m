Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 14:15:23 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58007 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492785AbZKFNMj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 14:12:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA6DE7Ag011045;
	Fri, 6 Nov 2009 14:14:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA6DE5Jp011041;
	Fri, 6 Nov 2009 14:14:05 +0100
Date:	Fri, 6 Nov 2009 14:14:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH -queue 1/2] [loongson] add basic loongson-2f support
Message-ID: <20091106131405.GC31392@linux-mips.org>
References: <cover.1257504242.git.wuzhangjin@gmail.com> <e1f93f565f4cdf3385f890f1b3a633aca03c2194.1257504242.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f93f565f4cdf3385f890f1b3a633aca03c2194.1257504242.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 06, 2009 at 06:45:05PM +0800, Wu Zhangjin wrote:

> Loongson2F has built-in DDR2 and PCIX controller. The PCIX controller
> have a similar programming interface with FPGA northbridge used in
> Loongson2E.
> 
> The main differences between loongson-2e and loongson-2f include:
> 
> 1. loongson-2f has an extra address windows configuration module, which
> can be used to map CPU address space to DDR or PCI address space, or map
> the PCI-DMA address space to DDR or LIO address space.
> 
> 2. loongson-2f support 8 levels of software configurable cpu frequency,
> which can be configured via a register(LOONGSON_CHIPCFG0).  the coming
> cpufreq and standby support are based on this feature.
> 
> herein, the module and the corresponding operations are abstracted to
> loongson.h.
> 
> besides, the other loongson2f-specific source code are added here,
> including gcc 4.4 support, pci memory space, pci io space, dma address.

Queued for 2.6.33.  Thanks!

  Ralf
