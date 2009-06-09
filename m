Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 17:07:17 +0100 (WEST)
Received: from localhost.localdomain ([127.0.0.1]:33260 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022470AbZFIQHP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Jun 2009 17:07:15 +0100
Date:	Tue, 9 Jun 2009 17:07:15 +0100 (WEST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: MIPS: Sibyte: Remove irritating printk from set_affinity
In-Reply-To: <S20023844AbZFIMUh/20090609122037Z+10394@ftp.linux-mips.org>
Message-ID: <alpine.LFD.1.10.0906091702530.8994@ftp.linux-mips.org>
References: <S20023844AbZFIMUh/20090609122037Z+10394@ftp.linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 9 Jun 2009, linux-mips@linux-mips.org wrote:

> set_affinity() will be called with cpui masks, which have more than one
> cpu set.  Instead of generating noise we now select the first set
> cpu and use that for setting affinity.  The printk was being triggered
> frequently by recent distributions running on recent kernels.

 For the record: I don't think it relates to a distribution being "recent" 
at all -- the noise happens with my board with recent kernels and does not 
with older ones even though the userland is always the same.  Something 
must have changed within the kernel itself and it may be worth 
investigating what, why and whether it is legitimate.  I fear the change 
may be papering over some bug elsewhere.

  Maciej
