Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 16:55:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5268 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039458AbWH2Pzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 16:55:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k7TFu8TG002278;
	Tue, 29 Aug 2006 16:56:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7TFu7IR002277;
	Tue, 29 Aug 2006 16:56:07 +0100
Date:	Tue, 29 Aug 2006 16:56:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexander Bigga <ab@mycable.de>
Cc:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: Re: [PATCH] fixup for pci config_access on alchemy au1x000
Message-ID: <20060829155607.GE29289@linux-mips.org>
References: <200608291648.35250.ab@mycable.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608291648.35250.ab@mycable.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 29, 2006 at 04:48:34PM +0200, Alexander Bigga wrote:

> What do you think about my fixup-patch? 
> Nobody's using the get_vm_area()-call without any flag ("0"). Was it only 
> forgotten in the  arch/mips/pci/ops-au1000.c?
> 
> Or am I completely wrong?
> 
> Thanks a lot for your comments!

The patch looks ok, so just the usual technicalities:

 - Please include a Signed-off-by: line.
 - Don't use a bloody crapmailer that garbles patches into some sort of
   ASCII spinach.

  Ralf
