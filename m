Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 15:56:14 +0200 (CEST)
Received: from [212.27.42.10] ([212.27.42.10]:55742 "EHLO smtpfb2-g21.free.fr"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493207AbZH1N4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2009 15:56:08 +0200
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id ACC39CA91EE
	for <linux-mips@linux-mips.org>; Fri, 28 Aug 2009 15:55:40 +0200 (CEST)
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 49BB14B01E7;
	Fri, 28 Aug 2009 15:54:56 +0200 (CEST)
Received: from bobafett.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 708D94B0131;
	Fri, 28 Aug 2009 15:54:54 +0200 (CEST)
Received: from daria.localnet (unknown [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 68ECA18039A;
	Fri, 28 Aug 2009 15:54:54 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	"wilbur.chan" <wilbur512@gmail.com>
Subject: Re: kexec on mips failed
Date:	Fri, 28 Aug 2009 15:54:53 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-14-generic; KDE/4.2.2; x86_64; ; )
Cc:	linux-mips@linux-mips.org
References: <e997b7420908160920y14d8ea95v5fb25eba67e7b6db@mail.gmail.com>
In-Reply-To: <e997b7420908160920y14d8ea95v5fb25eba67e7b6db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908281554.53949.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Sunday 16 August 2009 06:20:56 pm wilbur.chan wrote:
> Hi,Nicolas,

Hi,

> I've got some problem with kexec on mips32...
>
>
> in your code for kexec on mips32, there is a relocate_new_kernel function .
>
>
> In the end of this function , it jump to kexec_start_address by   'j  s1'
>
>


> Because  I  changed the  kexec-tools  code  ,in  the hope  that,  it
> simplely passed the new kernel  segment data into the old kernel.(so
> I didn't pass the command-line segment in, in my code, there is just
> one segment , segment[0] = kernel_data).

I  do not know  what the  kexec userland  code does  regarding command
line,  but  the  relocate_kernel.S  code  does  not  take  any  action
regarding  command line passing  (as far  as I  know it  is bootloader
dependent).


>
> So  I need to change register s1 to the new kernel entry address, and
> jump to new kernel directly.
>
>
>
> In my vmlinux,  the entry is 0x802b0000£¬so I let image->start =
> 0x2b0000£¬and invoke relocate_new_kernel.

Normaly the userland and sys_kexec should do the right thing in
setting image->start to the entry point set in the elf header of the
vmlinux file.

>
> However, whether I changed kexec_start_address to 0x802b0000 or
> 0x2b0000 , the  'j  s1'  seemed taking no effect?
>


> (I wrote 88 to address0xa1230000 before  'j s1' , it succedd .I also
> wrote 78 to address 0xa1230000 in the beginning of head.S of the new
> kernel , but  failed. And I reset the board to  uboot mode, used 'md
> 0x802b0400' to display the new kernel

> in ram, it is identical to the objdump content of the vmlinux.  So I
> guess,  this problem lays  in the  failing of  'j 0x802b0000'  or 'j
> 0x2b0000'.  I don't  know why 'j s1' failed  , any suggestions about
> this ?  Thank you very much.

The relocation code should really jump to 0x802b0000 address, not the
0x002b0000 address, could you please check that the machine_kexec()
function is invoked with image->start set to 0x802b0000 ?

The other  failure causes  I can  think about right  now are  that the
kernel for  your board  expects the bootloader  to set  some registers
(for the command line for instance), and since the kexec code does not
do this, the new kernel fails early.

Regards,


-- 
Nicolas Schichan
