Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 17:17:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39808 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021726AbXDRQRJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 17:17:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3IGH8k9026845;
	Wed, 18 Apr 2007 17:17:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3IGH74Q026844;
	Wed, 18 Apr 2007 17:17:07 +0100
Date:	Wed, 18 Apr 2007 17:17:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix wrong checksum for split TCP packets on 64-bit MIPS
Message-ID: <20070418161707.GB24160@linux-mips.org>
References: <17958.11693.953285.795311@zeus.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17958.11693.953285.795311@zeus.sw.starentnetworks.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 18, 2007 at 10:39:41AM -0400, Dave Johnson wrote:

> the following conditions:
> 
> 1) The TCP code needs to split a full-sized packet due to a reduced
>    MSS (typically due to the addition of TCP options mid-stream like
>    SACK).
>    _AND_
> 2) The checksum of the 2nd fragment is larger than the checksum of the
>    original packet.  After subtraction this results in a checksum for
>    the 1st fragment with bits 16..31 set to 1. (this is ok)
>    _AND_
> 3) The checksum of the 1st fragment's TCP header plus the previously
>    32bit checksum of the 1st fragment DOES NOT cause a 32bit overflow
>    when added together.  This results in a checksum of the TCP header
>    plus TCP data that still has the upper 16 bits as 1's.
>    _THEN_
> 4) The TCP+data checksum is added to the checksum of the pseudo IP
>    header with csum_tcpudp_nofold() incorrectly (the bug).
> 
> The problem is the checksum of the TCP+data is passed to
> csum_tcpudp_nofold() as an 32bit unsigned value, however the assembly
> code acts on it as if it is a 64bit unsigned value.
> 
> This causes an incorrect 32->64bit extension if the sum has bit 31
> set.  The resulting checksum is off by one.

Sigh.  The second bug of this kind.  As clever and apparently elegent as
the sign extension stuff happens to look on MIPS as prone to unobvious
accidents it is at times.  Oh well.

Applied & thanks!

  Ralf
