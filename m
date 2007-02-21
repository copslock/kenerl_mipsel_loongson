Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 02:32:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38556 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039077AbXBUCcO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 02:32:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1L2W7NJ020641;
	Wed, 21 Feb 2007 02:32:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1L2W4aU020637;
	Wed, 21 Feb 2007 02:32:04 GMT
Date:	Wed, 21 Feb 2007 02:32:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manoj Ekbote <manoj.ekbote@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] minor fix in sb1250_duart.c
Message-ID: <20070221023203.GB20057@linux-mips.org>
References: <710F16C36810444CA2F5821E5EAB7F231C84EB@NT-SJCA-0752.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F231C84EB@NT-SJCA-0752.brcm.ad.broadcom.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 20, 2007 at 04:34:56PM -0800, Manoj Ekbote wrote:

> Patch to remove the first "default" label in switch and case.

Thanks, applied.

  Ralf
