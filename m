Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35Gm5I00540
	for linux-mips-outgoing; Thu, 5 Apr 2001 09:48:05 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35Gm4M00537
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 09:48:04 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id F0C6F109DD; Thu,  5 Apr 2001 09:48:03 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id EA8DB1F429; Thu,  5 Apr 2001 09:48:01 -0700 (PDT)
Date: Thu, 5 Apr 2001 09:48:01 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: machael <dony.he@huawei.com.cn>
Cc: linux-mips@oss.sgi.com
Subject: Re: Does Linux support RC32332 CPU now?
Message-ID: <20010405094801.A4397@foobazco.org>
References: <007e01c0bd70$9052b4a0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <007e01c0bd70$9052b4a0$8021690a@huawei.com>; from dony.he@huawei.com.cn on Thu, Apr 05, 2001 at 09:34:31AM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 05, 2001 at 09:34:31AM +0800, machael wrote:

>      1   Does Linux support RC32332 CPU now?

No but it wouldn't be hard - it has r4600-style caches with an
r4k-style tlb (alas, only 32 entries instead of 48, but that's
insignificant).  See
http://www.idt.com/products/pages/Processors-79RC32332.html for
documentation including the pci controller and other bits.

>      2   I want to build my cross-compile environment  for MIPS target on my
> X86 host. Are there any documents about how to implement it?

Yes.  Read the archives of this list, or the faq, or
http://foobazco.org/~wesolows/mips-cross.html, or the cross gcc faq
easily accessible from google's first page of a search for "how to
build a cross compiler" at http://www.objsw.com/CrossGCC/.  Or go to
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev, or the
/pub/linux/mips directory in general on that server, or any of about
500 other places.  

Answering this question is getting REALLY old.  Being a newbie does
not excuse you from putting in at least minimal effort before asking.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
