Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 02:01:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41925 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038562AbWIQBBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Sep 2006 02:01:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8H11gbN023726;
	Sun, 17 Sep 2006 02:01:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8H11gWW023725;
	Sun, 17 Sep 2006 02:01:42 +0100
Date:	Sun, 17 Sep 2006 02:01:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	Jonathan Day <imipak@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: Kernel debugging contd.
Message-ID: <20060917010142.GA23646@linux-mips.org>
References: <20060915221141.69174.qmail@web31504.mail.mud.yahoo.com> <7E000E7F06B05C49BDBB769ADAF44D070111E24B@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D070111E24B@NT-SJCA-0750.brcm.ad.broadcom.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 15, 2006 at 03:54:06PM -0700, Mark E Mason wrote:

> FWIW - this is the same place my boards are hanging (right after freeing
> kernel memory).  I'd tracked it down to the commit that changed the
> cache/page handling for the sibyte parts from the sb1 specific to the
> generic codes -- but haven't found time to look into it further as yet.

Got a commit ID?

  Ralf
