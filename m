Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 13:30:05 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:37038 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20025662AbYDQMaC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 13:30:02 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3HCTI1t023347
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2008 05:29:18 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3HCTxSc031855;
	Thu, 17 Apr 2008 13:29:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3HCTwg4031853;
	Thu, 17 Apr 2008 13:29:58 +0100
Date:	Thu, 17 Apr 2008 13:29:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
Message-ID: <20080417122958.GA31790@linux-mips.org>
References: <4805FFE6.5080903@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4805FFE6.5080903@mips.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 03:32:22PM +0200, Kevin D. Kissell wrote:

> >From d164aa1b9dba720ee08a6a773e1a81b62aea7d10 Mon Sep 17 00:00:00 2001
> From: Kevin D. Kissell <kevink@mips.com>
> Date: Thu, 10 Apr 2008 02:07:38 +0200
> Subject: [PATCH] Fixes necessary for non-SMP kernels and non-relocatable binaries

>  		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr + hdr->e_phoff);
>  
>  		for (i = 0; i < hdr->e_phnum; i++) {
> -			if (phdr->p_type != PT_LOAD)
> -				continue;
> -
> -			memcpy((void *)phdr->p_paddr, (char *)hdr + phdr->p_offset, phdr->p_filesz);
> -			memset((void *)phdr->p_paddr + phdr->p_filesz, 0, phdr->p_memsz - phdr->p_filesz);
> -			phdr++;
> +		    if (phdr->p_type == PT_LOAD) {
> +			memcpy((void *)phdr->p_paddr, 
> +				(char *)hdr + phdr->p_offset, phdr->p_filesz);
> +			memset((void *)phdr->p_paddr + phdr->p_filesz, 
> +				0, phdr->p_memsz - phdr->p_filesz);
> +		    }

Patch applied with some reformatting to stick to the one tab per nesting
level rule.  Also git was bitching a little about whitespace:

.dotest/patch:13:       /* 
Space in indent is followed by a tab.
.dotest/patch:14:        * SMTC/SMVP kernels manage VPE enable independently,
Space in indent is followed by a tab.
.dotest/patch:15:        * but uniprocessor kernels need to turn it on, even
Space in indent is followed by a tab.
.dotest/patch:16:        * if that wasn't the pre-dvpe() state.
Space in indent is followed by a tab.
.dotest/patch:17:        */
warning: squelched 2 whitespace errors
warning: 7 lines applied after fixing whitespace errors.

Thanks,

  Ralf
