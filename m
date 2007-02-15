Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 12:34:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:51921 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038434AbXBOMer (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 12:34:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1FCYUJn027186;
	Thu, 15 Feb 2007 12:34:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1FCYU8O027185;
	Thu, 15 Feb 2007 12:34:30 GMT
Date:	Thu, 15 Feb 2007 12:34:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	barrioskmc@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Who know latest Linux/MIPS ABI ?
Message-ID: <20070215123430.GA26003@linux-mips.org>
References: <000701c750a3$24ecf9b0$8aab580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000701c750a3$24ecf9b0$8aab580a@swcenter.sec.samsung.co.kr>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 15, 2007 at 10:46:39AM +0900, ������ wrote:

> I want to know ELF format well in MIPS architecture. 
> But in case of elf spec document on net, it had explained about i386. so I
> can't find specific sections about MIPS ELF. For example, Sections
> (.MIPS.stubs, .jcr, .pdr ) and so on.
> 
> There is a MIPS ABI document in linux-mips.org. But it is very obsolete. As
> I know, any vendor don't use obsolete system V ABI. Currently, Is any ABI
> using o32 or n32 and so on. 
> 
> I hope I get a latest MIPS ABI and ELF Spec on Linux/MIPS. 
> Who know where I get it?

The documentation situation is a bit mess.  The SysV gABI and MIPS psABI
document the ABI ELF flavour which actually is only a subset of what
Linux/MIPS actually uses.  For the extensions you can probably find
individual papers and postings scattered over the net.

  Ralf
