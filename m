Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 18:27:52 +0200 (CEST)
Received: from mail.lysator.liu.se ([130.236.254.3]:44018 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492602AbZJXQ1p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 18:27:45 +0200
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5E61640042;
	Sat, 24 Oct 2009 18:26:48 +0200 (CEST)
Received: from [192.168.10.105] (c-83bee555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.190.131])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4200340040;
	Sat, 24 Oct 2009 18:26:48 +0200 (CEST)
Cc:	linux-mips@linux-mips.org
Message-Id: <0E276185-1DBE-4163-90BD-1F957B9A9785@lysator.liu.se>
From:	Markus Gothe <nietzsche@lysator.liu.se>
To:	figo zhang <figo1802@gmail.com>
In-Reply-To: <c6ed1ac50910232228h4ca7d0b4safed0bc63a02868@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-8-1069069411"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: how to mmap 0x1f000000 to user space?
Date:	Sat, 24 Oct 2009 18:27:39 +0200
References: <c6ed1ac50910232228h4ca7d0b4safed0bc63a02868@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.2.0 (v56)
X-Mailer: Apple Mail (2.936)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-8-1069069411
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

What does the vendor UM say on the memory base?

//Markus

On 24 Oct 2009, at 07:28, figo zhang wrote:

> hi,
> i am newbies for mips. i want to mmap the kernel space address
> 0x1f00,0000 to user mode space for MIPS32 CPU? how to write the mmap  
> file mothod?
> here is my code, is it right? Would you like to give me some advise?
> Thanks!
>
> static int test_reg_mmap(struct file * file, struct vm_area_struct *  
> vma)
> {
>   unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
>   unsigned long size =  vma->vm_end-vma->vm_start;
>   unsigned int *pfn;
>   unsigned int __iomem *buf;
>   #if 0
>    offset += 0xbf000000;
>    #else
>        buf = (unsigned int  * )ioremap_nocache(0x1f000000, size);
>         pfn = vmalloc_to_pfn((void *)buf);
>   offset += pfn;
>  #endif
>       if ((offset>__pa(high_memory)) || (file->f_flags & O_SYNC)) {
>        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>   }
>        /* Don't try to swap out physical pages.. */
>      vma->vm_flags |= VM_RESERVED;
>
>   /* Don't dump addresses that are not real memory to a core file.*/
>   if (offset >= __pa(high_memory) || (file->f_flags & O_SYNC))
>     vma->vm_flags |= VM_IO;
>
>   if (remap_pfn_range(vma, vma->vm_start, offset, vma->vm_end-vma- 
> >vm_start,
>                vma->vm_page_prot))
>   return 0;
> }
>
>
>
> Best,
> Figo.zhang


--Apple-Mail-8-1069069411
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkrjKvsACgkQ6I0XmJx2NrygYgCdGkuPRH/e9WrVff5Pu6DvdaDb
0boAnjaNoxmz14Vsf4WDuraa5U57CSCI
=AWoJ
-----END PGP SIGNATURE-----

--Apple-Mail-8-1069069411--
