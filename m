Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 15:26:56 +0100 (BST)
Received: from web53507.mail.yahoo.com ([206.190.37.68]:12435 "HELO
	web53507.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8126480AbWC1O0r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 15:26:47 +0100
Received: (qmail 57993 invoked by uid 60001); 28 Mar 2006 14:37:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G7SapihgKSlwgyfa7f4CmZU+AUqsLtN4JB0DA/PBJSvrdpzZ/rIIvCpjE8sUpHGC5IIZ7GWq1cmfquppwoxPYMr0z53RsXHIiJxVcXmVB04ts1+LlbqNNrIkfkK59T7FYUtc7+wlgzCJPwkmuTZ5+R6FAx3Q8LFAh2yeoDPlbcw=  ;
Message-ID: <20060328143708.57991.qmail@web53507.mail.yahoo.com>
Received: from [203.145.155.11] by web53507.mail.yahoo.com via HTTP; Tue, 28 Mar 2006 06:37:08 PST
Date:	Tue, 28 Mar 2006 06:37:08 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: compilation problem with kernel 2.6.15 
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-351059717-1143556628=:53650"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-351059717-1143556628=:53650
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I tried to cross compile kernel 2.6.15 for BCM1480. Please tell me what the following error indicates:
   
    Using /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15 as source for kernel
  GEN    /home/ssf/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-mips
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  GEN    /home/ssf/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15/Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/mips/Kconfig
#
# using defaults found in .config
#
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/mips/kernel/asm-offsets.s
  GEN     include/asm-mips/asm-offsets.h
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
In file included from /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/li
nux/nfs_fs.h:15,
                 from /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/init/do_mo
unts.c:12:
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h: In func
tion &#915;Çÿfault_in_pages_readable&#915;ÇÖ:
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err
or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output
make[2]: *** [init/do_mounts.o] Error 1
make[1]: *** [init] Error 2
make: *** [_all] Error 2
   
  Thanks and Regards,
  Krishna

		
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ countries) for 2¢/min or less.
--0-351059717-1143556628=:53650
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>I tried to cross compile kernel 2.6.15 for BCM1480.&nbsp;Please tell me what the following error indicates:</div>  <div>&nbsp;</div>  <div>&nbsp; Using /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15 as source for kernel<BR>&nbsp; GEN&nbsp;&nbsp;&nbsp; /home/ssf/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15/Makefile<BR>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<BR>&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<BR>&nbsp; SYMLINK include/asm -&gt; include/asm-mips<BR>&nbsp; HOSTCC&nbsp; scripts/basic/fixdep<BR>&nbsp; HOSTCC&nbsp; scripts/basic/split-include<BR>&nbsp; HOSTCC&nbsp; scripts/basic/docproc<BR>&nbsp; GEN&nbsp;&nbsp;&nbsp; /home/ssf/bdcom/linux-mips-kernels/linux-mips-kernel-2.6.15/Makefile<BR>&nbsp; HOSTCC&nbsp; scripts/kconfig/conf.o<BR>&nbsp; HOSTCC&nbsp; scripts/kconfig/kxgettext.o<BR>&nbsp; HOSTCC&nbsp; scripts/kconfig/mconf.o<BR>&nbsp; SHIPPED scripts/kconfig/zconf.tab.c<BR>&nbsp; SHIPPED scripts/kconfig/lex.zconf.c<BR>&nbsp; SHIPPED
 scripts/kconfig/zconf.hash.c<BR>&nbsp; HOSTCC&nbsp; scripts/kconfig/zconf.tab.o<BR>&nbsp; HOSTLD&nbsp; scripts/kconfig/conf<BR>scripts/kconfig/conf -s arch/mips/Kconfig<BR>#<BR># using defaults found in .config<BR>#<BR>&nbsp; SPLIT&nbsp;&nbsp; include/linux/autoconf.h -&gt; include/config/*<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/kernel/asm-offsets.s<BR>&nbsp; GEN&nbsp;&nbsp;&nbsp;&nbsp; include/asm-mips/asm-offsets.h<BR>&nbsp; HOSTCC&nbsp; scripts/genksyms/genksyms.o<BR>&nbsp; SHIPPED scripts/genksyms/lex.c<BR>&nbsp; SHIPPED scripts/genksyms/parse.h<BR>&nbsp; SHIPPED scripts/genksyms/keywords.c<BR>&nbsp; HOSTCC&nbsp; scripts/genksyms/lex.o<BR>&nbsp; SHIPPED scripts/genksyms/parse.c<BR>&nbsp; HOSTCC&nbsp; scripts/genksyms/parse.o<BR>&nbsp; HOSTLD&nbsp; scripts/genksyms/genksyms<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scripts/mod/empty.o<BR>&nbsp; HOSTCC&nbsp; scripts/mod/mk_elfconfig<BR>&nbsp; MKELF&nbsp;&nbsp; scripts/mod/elfconfig.h<BR>&nbsp; HOSTCC&nbsp;
 scripts/mod/file2alias.o<BR>&nbsp; HOSTCC&nbsp; scripts/mod/modpost.o<BR>&nbsp; HOSTCC&nbsp; scripts/mod/sumversion.o<BR>&nbsp; HOSTLD&nbsp; scripts/mod/modpost<BR>&nbsp; HOSTCC&nbsp; scripts/kallsyms<BR>&nbsp; HOSTCC&nbsp; scripts/pnmtologo<BR>&nbsp; HOSTCC&nbsp; scripts/conmakehash<BR>&nbsp; HOSTCC&nbsp; scripts/bin2c<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/main.o<BR>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<BR>&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/version.o<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/do_mounts.o<BR>In file included from /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/li<BR>nux/nfs_fs.h:15,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/init/do_mo<BR>unts.c:12:<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h: In func<BR>tion
 &#915;Çÿfault_in_pages_readable&#915;ÇÖ:<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:237: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err<BR>or: read-only
 variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>/home/ssf/bdcom/linux-mips-kernels/linux-2.6.15/include/linux/pagemap.h:243: err<BR>or: read-only variable &#915;Çÿ__gu_val&#915;ÇÖ used as &#915;Çÿasm&#915;ÇÖ output<BR>make[2]: *** [init/do_mounts.o] Error 1<BR>make[1]: *** [init] Error 2<BR>make: *** [_all] Error 2</div>  <div>&nbsp;</div>  <div>Thanks and Regards,</div>  <div>Krishna</div><p>
		<hr size=1>Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman1/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Make PC-to-Phone Calls</a> to the US (and 30+ countries) for 2¢/min or less.
--0-351059717-1143556628=:53650--
