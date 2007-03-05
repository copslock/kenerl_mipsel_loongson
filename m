Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 16:29:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48271 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037609AbXCEQ3f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 16:29:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l25GRjdU007312;
	Mon, 5 Mar 2007 16:27:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l25GRj1S007311;
	Mon, 5 Mar 2007 16:27:45 GMT
Date:	Mon, 5 Mar 2007 16:27:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rajat Jain <rajat.noida.india@gmail.com>
Cc:	Alexander Sirotkin <demiourgos@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: 0 function size
Message-ID: <20070305162745.GB786@linux-mips.org>
References: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com> <b115cb5f0703050821v50667580oa8dfa26412c05b08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115cb5f0703050821v50667580oa8dfa26412c05b08@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 09:51:25PM +0530, Rajat Jain wrote:

> Are you using a native compiler or a cross compiler?
> 
> If you are using a cross compiler, then you need to use the "cross
> compiler" version of objdump / readelf  utilities as well. For
> instance if you are using mips-linux-gcc to compile, then you need
> mips-linux-readelf / mips-linux-objdump etc.

In general your're right but for this particular purpose for example an
i386-linux-objdump will do the job for 32-bit big and little endian
MIPS ELF.  It will - depending on the exact binutils configuration - fail
with an error message for 64-bit ELF.

  Ralf
