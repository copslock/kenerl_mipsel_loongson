Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 16:41:50 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:24587 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465646AbWBBQla (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 16:41:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12GkqdI020781;
	Thu, 2 Feb 2006 16:46:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12GkqPg020780;
	Thu, 2 Feb 2006 16:46:52 GMT
Date:	Thu, 2 Feb 2006 16:46:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
Message-ID: <20060202164652.GA20462@linux-mips.org>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 03, 2006 at 01:34:01AM +0900, Atsushi Nemoto wrote:

> If mfc0 $12 follows store and the mfc0 is last instruction of a
> page and fetching the next instruction causes TLB miss, the result
> of the mfc0 might wrongly contain EXL bit.
> 
> ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
> 
> Workaround: mask EXL bit of the result or place a nop before mfc0.

Applied,

  Ralf
