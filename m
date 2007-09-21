Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 17:01:43 +0100 (BST)
Received: from rv-out-0910.google.com ([209.85.198.186]:52694 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025945AbXIUQBf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 17:01:35 +0100
Received: by rv-out-0910.google.com with SMTP id l15so709708rvb
        for <linux-mips@linux-mips.org>; Fri, 21 Sep 2007 09:01:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=lVGPG37d6VSKBJtY3o44Gerpo3T07Sa5Ho+NWfEpH1Y=;
        b=SWBoDlDnfLw+7r5undPgiEjQEOd3j3KDLkPd6e36rrRq++EZW2UeSh7ZRpADHB3ygWFAXIJI4t6fG6QWbrphgdCxvagQpy++NydjNi/1uvCl6x7mFJOERh8fw2FyLOZwBlYVvv+4KwJpZKE0ihhVA2YMfqZiu2aoW9WTrAn67Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ve4LdoSkHTZyd96eCZSyWFEUBX8MykumRhFQxbGTGGT8zy3nFDT7pRgUjR27Hrz1xIrIPrlnsfVI9lFSz7tu9mgg8pmUflQuH7aL8zX2aIEUZJXCPdKf1qtfmoznxfrXeFRAvLrgMM+qtYMIykktSfhZg8pJBBNz7QD7zsmcMnI=
Received: by 10.141.195.18 with SMTP id x18mr817998rvp.1190390475831;
        Fri, 21 Sep 2007 09:01:15 -0700 (PDT)
Received: by 10.141.75.4 with HTTP; Fri, 21 Sep 2007 09:01:15 -0700 (PDT)
Message-ID: <48413e3e0709210901g38e41164pf068f907596ebfeb@mail.gmail.com>
Date:	Fri, 21 Sep 2007 09:01:15 -0700
From:	"Winson Yung" <winson.yung@gmail.com>
To:	linux-mips@linux-mips.org
Subject: branch delay slot
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <winson.yung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: winson.yung@gmail.com
Precedence: bulk
X-list: linux-mips

Hi there, in the following mips 32bit atomic cmp_xchg api, I was
wondering why there is no nop after the two branch instructions. Does
this introduce a bug, or is it a "feature" in the code to use the
delay slot for an instructino to execut something whether or not they
take the branch.

#define __arch_compare_and_exchange_xxx_32_int(mem, newval, oldval, rel, acq) \
     __asm__ __volatile__ (						      \
     ".set	push\n\t"						      \
     MIPS_PUSH_MIPS2							      \
     rel	"\n"							      \
     "1:\t"								      \
     "ll	%0,%4\n\t"						      \
     "move	%1,$0\n\t"						      \
     "bne	%0,%2,2f\n\t"						      \
     "move	%1,%3\n\t"						      \
     "sc	%1,%4\n\t"						      \
     "beqz	%1,1b\n"						      \
     acq	"\n\t"							      \
     ".set	pop\n"							      \
     "2:\n\t"								      \
	      : "=&r" (__prev), "=&r" (__cmp)				      \
	      : "r" (oldval), "r" (newval), "m" (*mem)			      \
	      : "memory")
