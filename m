Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 15:25:48 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:52099 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573984AbXAHPZq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 15:25:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08FQaG6029381;
	Mon, 8 Jan 2007 15:26:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08FQRIa029379;
	Mon, 8 Jan 2007 15:26:27 GMT
Date:	Mon, 8 Jan 2007 15:26:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Davy Chan <chandave-linux-mips@wiasia.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] pnx8550: Fix broken write_config_byte() function in arch/mips/pci/ops-pnx8550.c
Message-ID: <20070108152627.GD28691@linux-mips.org>
References: <20070105135646.D14007@wiasia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105135646.D14007@wiasia.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 05, 2007 at 01:56:46PM +0800, Davy Chan wrote:

> There's a serious typo in the function:
>   arch/mips/pci/ops-pnx8550.c:write_config_byte()
> 
> The parameter passed to the function config_access() is PCI_CMD_CONFIG_READ
> instead of PCI_CMD_CONFIG_WRITE. This renders any attempts to write
> a single byte to the PCI configuration registers useless.
> 
> This problem does not exist for write_config_word() nor write_config_dword().
> 
> This problem has been there since kernel v2.6.17 and is still there
> as of kernel v2.6.19.1.

The bug exists even in 2.6.16 which is the oldest -stable branch I'm still
maintaining on linux-mips.org.

Patch applied.  Standard rant, please add a Signed-off-by: line.  See
Documentation/SubmittingPatches for what this is about.

  Ralf
