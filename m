Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 12:38:50 +0100 (BST)
Received: from web53511.mail.yahoo.com ([206.190.39.65]:19819 "HELO
	web53511.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133725AbWC2Lih (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 12:38:37 +0100
Received: (qmail 9539 invoked by uid 60001); 29 Mar 2006 11:49:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dZZxptFhuqcBp+NOXzicSr2BaUETaxOORTG+H7Xr+CaMUhNaKcMmIWO9Aml4iDna3/EmFxwH19aa8iq2dNRz88I7VE8oyPB430G9glqklJMd3pKEpoc093TfK/LN3NLzauAn0dCwLhsYH8mbBYefnS4W2avoVZYYDmBNbbhDieA=  ;
Message-ID: <20060329114903.9537.qmail@web53511.mail.yahoo.com>
Received: from [203.145.155.11] by web53511.mail.yahoo.com via HTTP; Wed, 29 Mar 2006 03:49:03 PST
Date:	Wed, 29 Mar 2006 03:49:03 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: Re: compilation problem with kernel 2.6.15
To:	James E Wilson <wilson@specifix.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <1143572962.13954.8.camel@aretha.corp.specifix.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-767580075-1143632943=:8136"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-767580075-1143632943=:8136
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I downloaded the exact tools and followed exact procedure suggested in http://www.linux-mips.org/wiki/Toolchains#Prologue. But while trying to cross compile the kernel 2.6.15 got the following error:
   
  (root@Jamuna:/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15)# make O=/home/ssf
  /bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15 ARCH=mips CROSS_COMPILE=mips
  el-unknown-linux-gnu-
    Using /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15 as source for kernel
    GEN    /home/ssf/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15/Makefile
    CHK     include/linux/version.h
    CC      arch/mips/kernel/asm-offsets.s
    GEN     include/asm-mips/asm-offsets.h
    CC      scripts/mod/empty.o
    MKELF   scripts/mod/elfconfig.h
    HOSTCC  scripts/mod/file2alias.o
    HOSTCC  scripts/mod/modpost.o
    HOSTCC  scripts/mod/sumversion.o
    HOSTLD  scripts/mod/modpost
    CC      init/main.o
    CHK     include/linux/compile.h
    SKIPPED include/linux/compile.h
    CC      init/version.o
    CC      init/do_mounts.o
    CC      init/do_mounts_rd.o
    CC      init/do_mounts_initrd.o
    CC      init/do_mounts_md.o
    LD      init/mounts.o
    CC      init/initramfs.o
    CC      init/calibrate.o
    LD      init/built-in.o
    CHK     usr/initramfs_list
    /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/scripts/gen_initramfs_list.sh:
   Cannot open 'y'
  make[2]: *** [usr/initramfs_list] Error 1
  make[1]: *** [usr] Error 2
  make: *** [_all] Error 2
   
  can anyone suggest me what is the problem here?
   
  Thanks in advance,
  Krishna

James E Wilson <wilson@specifix.com> wrote:
  On Tue, 2006-03-28 at 06:37, Krishna wrote:
> err
> or: read-only variable ΓÇÿ__gu_valΓÇÖ used as ΓÇÿasmΓÇÖ output

This means a new error check in gcc has found a latent kernel bug.

It is also sometimes the case that a new linux kernel finds a latent gcc
bug.

Note, in general, key parts of linux such as the kernel, glibc, and gcc,
often have such heavy dependencies on each other that you can not pick
and choose random versions. If you want to use a particular kernel
version, then there are often particular glibc and gcc versions you
should use with it, otherwise you are likely to run into trouble.

This link:
http://www.linux-mips.org/wiki/Toolchains#Prologue
recommends gcc-3.4. And if you follow the "recommended" link to
http://www.linux-mips.org/wiki/GCC
it specifically recommends against use of gcc-4.1 for compiling the
linux kernel, as this hasn't been well tested yet.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com




*Krishna*
		
---------------------------------
New Yahoo! Messenger with Voice. Call regular phones from your PC and save big.
--0-767580075-1143632943=:8136
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>I downloaded the exact tools and followed exact procedure suggested in <A href="http://www.linux-mips.org/wiki/Toolchains#Prologue">http://www.linux-mips.org/wiki/Toolchains#Prologue</A>. But while trying to cross compile the kernel 2.6.15 got the following error:</div>  <div>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">(root@Jamuna:/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15)# make O=/home/ssf<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15 ARCH=mips CROSS_COMPILE=mips<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN
 style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">el-unknown-linux-gnu-<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>Using /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15 as source for kernel<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>GEN<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>/home/ssf/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15/Makefile<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CHK<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;
 </SPAN>include/linux/version.h<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>arch/mips/kernel/asm-offsets.s<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>GEN<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>include/asm-mips/asm-offsets.h<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </SPAN>scripts/mod/empty.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>MKELF<SPAN style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>scripts/mod/elfconfig.h<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>HOSTCC<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>scripts/mod/file2alias.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>HOSTCC<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>scripts/mod/modpost.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt;
 mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>HOSTCC<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>scripts/mod/sumversion.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>HOSTLD<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>scripts/mod/modpost<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/main.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY:
 Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CHK<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>include/linux/compile.h<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>SKIPPED include/linux/compile.h<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/version.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </SPAN>init/do_mounts.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/do_mounts_rd.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/do_mounts_initrd.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/do_mounts_md.o<o:p></o:p></SPAN></div>  <div
 class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>LD<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/mounts.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/initramfs.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CC<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/calibrate.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none;
 mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>LD<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>init/built-in.o<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>CHK<SPAN style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>usr/initramfs_list<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN style="mso-spacerun: yes">&nbsp; </SPAN>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/scripts/gen_initramfs_list.sh:<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY:
 Arial"><SPAN style="mso-spacerun: yes">&nbsp;</SPAN>Cannot open 'y'<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">make[2]: *** [usr/initramfs_list] Error 1<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">make[1]: *** [usr] Error 2<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">make: *** [_all] Error 2<o:p></o:p></SPAN></div>  <div>&nbsp;</div>  <div>can anyone suggest me what is the problem here?</div>  <div>&nbsp;</div>  <div>Thanks in advance,</div>  <div>Krishna<BR><BR><B><I>James E Wilson &lt;wilson@specifix.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT:
 5px; BORDER-LEFT: #1010ff 2px solid">On Tue, 2006-03-28 at 06:37, Krishna wrote:<BR>&gt; err<BR>&gt; or: read-only variable ΓÇÿ__gu_valΓÇÖ used as ΓÇÿasmΓÇÖ output<BR><BR>This means a new error check in gcc has found a latent kernel bug.<BR><BR>It is also sometimes the case that a new linux kernel finds a latent gcc<BR>bug.<BR><BR>Note, in general, key parts of linux such as the kernel, glibc, and gcc,<BR>often have such heavy dependencies on each other that you can not pick<BR>and choose random versions. If you want to use a particular kernel<BR>version, then there are often particular glibc and gcc versions you<BR>should use with it, otherwise you are likely to run into trouble.<BR><BR>This link:<BR>http://www.linux-mips.org/wiki/Toolchains#Prologue<BR>recommends gcc-3.4. And if you follow the "recommended" link to<BR>http://www.linux-mips.org/wiki/GCC<BR>it specifically recommends against use of gcc-4.1 for compiling the<BR>linux kernel, as this hasn't been well
 tested yet.<BR>-- <BR>Jim Wilson, GNU Tools Support, http://www.specifix.com<BR><BR></BLOCKQUOTE><BR><BR><BR>*Krishna*<p>
		<hr size=1>New Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman6/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Call regular phones from your PC</a> and save big.
--0-767580075-1143632943=:8136--
