Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 10:42:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59618 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492008AbZKDJmo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 10:42:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA49i8SO009149;
	Wed, 4 Nov 2009 10:44:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA49i7RT009147;
	Wed, 4 Nov 2009 10:44:07 +0100
Date:	Wed, 4 Nov 2009 10:44:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add DMA declare coherent memory support
Message-ID: <20091104094407.GA32639@linux-mips.org>
References: <20091104164104.9fc315af.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091104164104.9fc315af.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 04:41:04PM +0900, Yoichi Yuasa wrote:

> ohci-sm501 driver require dma_declare_coherent_memory().
> It is used to driver's local memory allocation with dma_alloc_coherent().
> 
> This patch works without problem on TANBAC TB0287(VR4131 + SM501).

I already had a modified version of this patch queued up for 2.6.33.  I'll
move that patch into the main tree and change the comment to make it
clear that this is a required fix.

Thanks,

  Ralf
