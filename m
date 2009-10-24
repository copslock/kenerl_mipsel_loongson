Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 07:29:03 +0200 (CEST)
Received: from mail-px0-f188.google.com ([209.85.216.188]:64199 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491881AbZJXF24 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 07:28:56 +0200
Received: by pxi26 with SMTP id 26so2510807pxi.22
        for <linux-mips@linux-mips.org>; Fri, 23 Oct 2009 22:28:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=gEb29mp6cuBUGFohdqKVRbK9NMRLcyYBaBT7cpSAaUA=;
        b=jZEoKTKxQAeR1MJgG1GcoLK0AB3pmCEAGD6m5xc4/W/82j5xwk/IF8zWp2GdRh8rkQ
         t8jFNgDm27E6NIc6utusDDhwcRQlv2bZeLGsmyrHlFY03hgXTFyDg2wy8xlG5KC/WH9A
         sUm+OjUcsff00rTiFNNCZm1Hdo5NJJhKpFnN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xpgkK3kK6xMdDVRNPbWq+9N1Vkaq93FAY3g52MtbrhzdyYWlfrKhge08+KzSqZttdk
         8ghbOyMQb9isfE8Itw6aMTkEN3cJtm/8P5i9NaYoMSL0NB0D7rLttROqZczdn4p9wP6F
         TsxbzWoZgDpskWzDD51/5s3oJJ7pgMXUCW52M=
MIME-Version: 1.0
Received: by 10.140.225.17 with SMTP id x17mr1837177rvg.34.1256362128630; Fri, 
	23 Oct 2009 22:28:48 -0700 (PDT)
Date:	Sat, 24 Oct 2009 13:28:48 +0800
Message-ID: <c6ed1ac50910232228h4ca7d0b4safed0bc63a02868@mail.gmail.com>
Subject: how to mmap 0x1f000000 to user space?
From:	figo zhang <figo1802@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=000e0cd28de262e5c30476a79a26
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--000e0cd28de262e5c30476a79a26
Content-Type: text/plain; charset=ISO-8859-1

hi,
i am newbies for mips. i want to mmap the kernel space address
0x1f00,0000 to user mode space for MIPS32 CPU? how to write the mmap file
mothod?
here is my code, is it right? Would you like to give me some advise?
Thanks!

static int test_reg_mmap(struct file * file, struct vm_area_struct * vma)
{
  unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
  unsigned long size =  vma->vm_end-vma->vm_start;
  unsigned int *pfn;
  unsigned int __iomem *buf;
  #if 0
   offset += 0xbf000000;
   #else
       buf = (unsigned int  * )ioremap_nocache(0x1f000000, size);
        pfn = vmalloc_to_pfn((void *)buf);
  offset += pfn;
 #endif
      if ((offset>__pa(high_memory)) || (file->f_flags & O_SYNC)) {
       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
  }
       /* Don't try to swap out physical pages.. */
     vma->vm_flags |= VM_RESERVED;

  /* Don't dump addresses that are not real memory to a core file.*/
  if (offset >= __pa(high_memory) || (file->f_flags & O_SYNC))
    vma->vm_flags |= VM_IO;

  if (remap_pfn_range(vma, vma->vm_start, offset, vma->vm_end-vma->vm_start,
               vma->vm_page_prot))
  return 0;
}



 Best,
Figo.zhang

--000e0cd28de262e5c30476a79a26
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>hi,</div>
<div>i am newbies for mips. i want to mmap the kernel space address<br>0x1f=
00,0000 to user mode space for MIPS32 CPU? how to write the mmap file motho=
d?</div>
<div>here is my code, is it right? Would you like to give me some advise?<b=
r>Thanks!</div>
<div>=A0</div>
<div>static int test_reg_mmap(struct file * file, struct vm_area_struct * v=
ma)<br>{<br>=A0 unsigned long offset =3D vma-&gt;vm_pgoff &lt;&lt; PAGE_SHI=
FT;<br>=A0 unsigned long size =3D=A0 vma-&gt;vm_end-vma-&gt;vm_start;<br>=
=A0 unsigned int *pfn;<br>
=A0 unsigned int __iomem *buf;<br>=A0=A0#if 0<br>=A0 =A0offset +=3D 0xbf000=
000;<br>=A0=A0 #else<br>=A0=A0=A0=A0=A0=A0 buf =3D (unsigned int=A0 * )iore=
map_nocache(0x1f000000, size);<br>=A0=A0=A0=A0=A0=A0 =A0pfn =3D vmalloc_to_=
pfn((void *)buf);<br>=A0=A0offset +=3D pfn;<br>=A0#endif<br>
=A0=A0=A0=A0=A0 if ((offset&gt;__pa(high_memory)) || (file-&gt;f_flags &amp=
; O_SYNC)) {<br>=A0=A0=A0=A0=A0 =A0vma-&gt;vm_page_prot =3D pgprot_noncache=
d(vma-&gt;vm_page_prot);<br>=A0 }</div>
<div>=A0=A0=A0=A0=A0 =A0/* Don&#39;t try to swap out physical pages.. */<br=
>=A0=A0=A0 =A0vma-&gt;vm_flags |=3D VM_RESERVED;<br>=A0 <br>=A0 /* Don&#39;=
t dump addresses that are not real memory to a core file.*/<br>=A0 if (offs=
et &gt;=3D __pa(high_memory) || (file-&gt;f_flags &amp; O_SYNC))<br>
=A0=A0=A0 vma-&gt;vm_flags |=3D VM_IO;<br>=A0<br>=A0 if (remap_pfn_range(vm=
a, vma-&gt;vm_start, offset, vma-&gt;vm_end-vma-&gt;vm_start,<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vma-&gt;vm_page_prot))<br>=A0 return 0;<b=
r>}</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>
<div>Best,</div>
<div>Figo.zhang</div></div>

--000e0cd28de262e5c30476a79a26--
