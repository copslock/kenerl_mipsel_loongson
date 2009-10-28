Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 17:30:23 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:44282 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493241AbZJ1QaR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 17:30:17 +0100
Received: by ywh3 with SMTP id 3so901097ywh.22
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 09:30:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=LHMVE4Mg7ARNA1foykd4F+iaJjPam9Qnpc3nDDtG8LQ=;
        b=vrmN7fzM/k296OWylU53RDbcZOeufXMojwbSAJd3fHijf98zToIZnEJyzeFqc3nKVC
         v2/wxQdubDACnMyB+xvKAPv98LQtTKm/fTyVYeA32Gzva4iFdRz0jDcrczl2hTxaAYl0
         gddKkNyjciME5/GYjD8MMccoJ0JezLuR85d/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Pg9afMfYiPvOvB2+KOBJmtPPXqQPhqlLsDkUwXcFwUPETG6Ke1efLL4b1hVw0oaYGK
         KA3jNA2UeGzIeSNue0x6n0HPSF4FCz1Om5Rhv67lLYivOvjUWufSX1DbHF7z48P14HTd
         nfo240C/4H3HGUqyvkh5YGDBBCyqZr/0SsDFc=
MIME-Version: 1.0
Received: by 10.90.11.39 with SMTP id 39mr1112498agk.100.1256747411197; Wed, 
	28 Oct 2009 09:30:11 -0700 (PDT)
Date:	Thu, 29 Oct 2009 00:30:11 +0800
Message-ID: <e997b7420910280930p40e3c02cw1ab5a7813a4b5147@mail.gmail.com>
Subject: mips64 SMP patch of kexec
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	msyrchin@ru.mvista.com
Cc:	nschichan@freebox.fr,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>,
	kexec@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Maxim Syrchin

I've just  found your  kernel patch for mips64 SMP kexec:

http://lists.infradead.org/pipermail/kexec/2008-June/001909.html

 I was porting  your kexec part  code(excluding crash_dump )  on
xlr408 ,which is of  8 cores SMP mips64 .

I found that in machine_kexec.c ,
flush_icache_range(reboot_code_buffer,  reboot_code_buffer +
KEXEC_CONTROL_CODE_SIZE);

caused an error, so I delete this line directly,although I don't know
if it would bring problem after I del it...


 It is strange that , in relocate_kernel.S, the operator 'REG_L	s5,
(s2)' caused an  invalid access on kernel space.

If I change REG_L to ld , everything went well.   So I change all the
macro such as  REG_L to  ld ,REG_S to sd , PTR_ADD to dadd

LONG_SUB to dsub, and SZREG to 8


At the same time ,  I changed the kexec_smp_wait function to a simple
loop, without checking the kexec_flag:


.globl kexec_smp_wait
kexec_smp_wait:
3: b 3b

at last , the a0,a1,a3,a4 were set to address of fw_arg0,
fw_arg1,fw_arg2,fw_arg3 respectively.


As you see, I just let one of the cpus jumps into new kernel,while the
others be  in an infinite loop.

After jumped into second kernel , the code seemed to be crazy.


Firstly,  the code seemd to stop before calling 'start_kernel--->
calibrate_delay ' .


 However,  if I added a 'printk' in any 'if  branches'  in
'calibrate_delay '  function  , the code would stop before calling

'j  start_kernel'  in head.S. (This time, because printk seemed
unavailable, I  wrote directlly to serial address to trace the
kernel).


I thougt it might be the problem of irq , so I added 'disable_irq(17)'
 in machine_kexec before invoking reboot_code_buffer();



However, the problem was still there.

I don't know why this happedn can you give me some advice on how to
solve this , or if there were some mistake in my code ?


Thank you

regards,

wilbur
