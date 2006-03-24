Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 08:18:56 +0000 (GMT)
Received: from web53506.mail.yahoo.com ([206.190.37.67]:10608 "HELO
	web53506.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133529AbWCXISp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 08:18:45 +0000
Received: (qmail 68471 invoked by uid 60001); 24 Mar 2006 08:28:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RdovN1EdZy6zPc0F1b4360HWggzOr2pjBPmq36sYcsKJZGg42GHnKr3/+yi3Yvebf6jU0oYAyZLRFbh/7CjseCPlSSLvXtLkJyq4g9zDsPHDDxAkdTnNuJe2ry/REznINZoBHW92LAq9BwlMW1CFz9CFpU7kWJKEDlb4z0Hftq0=  ;
Message-ID: <20060324082842.68469.qmail@web53506.mail.yahoo.com>
Received: from [203.145.155.11] by web53506.mail.yahoo.com via HTTP; Fri, 24 Mar 2006 00:28:42 PST
Date:	Fri, 24 Mar 2006 00:28:42 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: Re: Compilation problem with kernel 2.4.16
To:	gowri@bitel.co.kr
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1143187790.3249.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1129037444-1143188922=:68158"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1129037444-1143188922=:68158
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

here is the error description:
   
  ********************************************************
  Makefile:489: .config: No such file or directory
  scripts/basic/fixdep.c: In function `parse_config_file':
  scripts/basic/fixdep.c:228: warning: implicit declaration of function `ntohl'
  scripts/basic/fixdep.c: In function `print_deps':
  scripts/basic/fixdep.c:336: warning: unused variable `map'
  /home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040
  /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
  : undefined reference to `_impure_ptr'
  /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
  : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
  /tmp/ccb1vCvc.o(.text+0x1c): In function `usage':
  : undefined reference to `fwrite'
  /tmp/ccb1vCvc.o(.text+0x24): In function `usage':
  : undefined reference to `exit'
  /tmp/ccb1vCvc.o(.text+0x3c): In function `print_cmdline':
  : undefined reference to `printf'
  /tmp/ccb1vCvc.o(.text+0x80): In function `grow_config':
  : undefined reference to `realloc'
  /tmp/ccb1vCvc.o(.text+0xc0): In function `grow_config':
  : undefined reference to `perror'
  /tmp/ccb1vCvc.o(.text+0xc8): In function `grow_config':
  : undefined reference to `exit'
  /tmp/ccb1vCvc.o(.text+0x148): In function `is_defined_config':
  : undefined reference to `memcmp'
  /tmp/ccb1vCvc.o(.text+0x1b8): In function `define_config':
  : undefined reference to `memcpy'
  /tmp/ccb1vCvc.o(.text+0x268): In function `use_config':
  : undefined reference to `memcpy'
  /tmp/ccb1vCvc.o(.text+0x340): In function `parse_config_file':
  : undefined reference to `_ctype_'
  /tmp/ccb1vCvc.o(.text+0x290): In function `use_config':
  : undefined reference to `_ctype_'
  /tmp/ccb1vCvc.o(.text+0x2e8): In function `use_config':
  : undefined reference to `printf'
  /tmp/ccb1vCvc.o(.text+0x280): In function `use_config':
  : undefined reference to `_ctype_'
  /tmp/ccb1vCvc.o(.text+0x358): In function `parse_config_file':
  : undefined reference to `_ctype_'
  /tmp/ccb1vCvc.o(.text+0x360): In function `parse_config_file':
  : undefined reference to `ntohl'
  /tmp/ccb1vCvc.o(.text+0x374): In function `parse_config_file':
  : undefined reference to `ntohl'
  /tmp/ccb1vCvc.o(.text+0x388): In function `parse_config_file':
  : undefined reference to `ntohl'
  /tmp/ccb1vCvc.o(.text+0x3b0): In function `parse_config_file':
  : undefined reference to `ntohl'
  /tmp/ccb1vCvc.o(.text+0x3d8): In function `parse_config_file':
  : undefined reference to `memcmp'
  /tmp/ccb1vCvc.o(.text+0x498): In function `strrcmp':
  : undefined reference to `strlen'
  /tmp/ccb1vCvc.o(.text+0x4a4): In function `strrcmp':
  : undefined reference to `strlen'
  /tmp/ccb1vCvc.o(.text+0x4dc): In function `strrcmp':
  : undefined reference to `memcmp'
  /tmp/ccb1vCvc.o(.text+0x514): In function `do_config_file':
  : undefined reference to `open'
  /tmp/ccb1vCvc.o(.text+0x52c): In function `do_config_file':
  : undefined reference to `fstat'
  /tmp/ccb1vCvc.o(.text+0x540): In function `do_config_file':
  : undefined reference to `close'
  /tmp/ccb1vCvc.o(.text+0x560): In function `do_config_file':
  : undefined reference to `close'
  /tmp/ccb1vCvc.o(.text+0x57c): In function `do_config_file':
  : undefined reference to `_impure_ptr'
  /tmp/ccb1vCvc.o(.text+0x57c): In function `do_config_file':
  : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
  /tmp/ccb1vCvc.o(.text+0x590): In function `do_config_file':
  : undefined reference to `fwrite'
  /tmp/ccb1vCvc.o(.text+0x598): In function `do_config_file':
  : undefined reference to `perror'
  /tmp/ccb1vCvc.o(.text+0x5a0): In function `do_config_file':
  : undefined reference to `exit'
  /tmp/ccb1vCvc.o(.text+0x5dc): In function `parse_dep_file':
  : undefined reference to `strchr'
  /tmp/ccb1vCvc.o(.text+0x600): In function `parse_dep_file':
  : undefined reference to `memcpy'
  /tmp/ccb1vCvc.o(.text+0x614): In function `parse_dep_file':
  : undefined reference to `printf'
  /tmp/ccb1vCvc.o(.text+0x6a4): In function `parse_dep_file':
  : undefined reference to `memcpy'
  /tmp/ccb1vCvc.o(.text+0x704): In function `parse_dep_file':
  : undefined reference to `printf'
  /tmp/ccb1vCvc.o(.text+0x714): In function `parse_dep_file':
  : undefined reference to `printf'
  /tmp/ccb1vCvc.o(.text+0x7b8): In function `parse_dep_file':
  : undefined reference to `printf'
  /tmp/ccb1vCvc.o(.text+0x7d0): In function `parse_dep_file':
  : undefined reference to `_impure_ptr'
  /tmp/ccb1vCvc.o(.text+0x7d0): In function `parse_dep_file':
  : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
  /tmp/ccb1vCvc.o(.text+0x7e4): In function `parse_dep_file':
  : undefined reference to `fwrite'
  /tmp/ccb1vCvc.o(.text+0x7ec): In function `parse_dep_file':
  : undefined reference to `exit'
  /tmp/ccb1vCvc.o(.text+0x808): In function `print_deps':
  : undefined reference to `open'
  /tmp/ccb1vCvc.o(.text+0x820): In function `print_deps':
  : undefined reference to `fstat'
  /tmp/ccb1vCvc.o(.text+0x83c): In function `print_deps':
  : undefined reference to `_impure_ptr'
  /tmp/ccb1vCvc.o(.text+0x83c): In function `print_deps':
  : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
  /tmp/ccb1vCvc.o(.text+0x844): In function `print_deps':
  : undefined reference to `fprintf'
  /tmp/ccb1vCvc.o(.text+0x850): In function `print_deps':
  : undefined reference to `close'
  /tmp/ccb1vCvc.o(.text+0x868): In function `print_deps':
  : undefined reference to `_impure_ptr'
  /tmp/ccb1vCvc.o(.text+0x868): In function `print_deps':
  : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
  /tmp/ccb1vCvc.o(.text+0x87c): In function `print_deps':
  : undefined reference to `fwrite'
  /tmp/ccb1vCvc.o(.text+0x884): In function `print_deps':
  : undefined reference to `perror'
  /tmp/ccb1vCvc.o(.text+0x88c): In function `print_deps':
  : undefined reference to `exit'
  /tmp/ccb1vCvc.o(.text+0x8a4): In function `traps':
  : undefined reference to `ntohl'
  /tmp/ccb1vCvc.o(.text+0x8c0): In function `traps':
  : undefined reference to `_impure_ptr'
  /tmp/ccb1vCvc.o(.text+0x8c0): In function `traps':
  : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
  /tmp/ccb1vCvc.o(.text+0x8cc): In function `traps':
  : undefined reference to `fprintf'
  /tmp/ccb1vCvc.o(.text+0x8d4): In function `traps':
  : undefined reference to `exit'
  /tmp/ccb1vCvc.o(.sdata+0x0): undefined reference to `_ctype_'
  collect2: ld returned 1 exit status
  make[2]: *** [scripts/basic/fixdep] Error 1
  make[1]: *** [scripts_basic] Error 2
  make: *** [include/linux/autoconf.h] Error 2
   
  ******************************************************************************************
   
  Hope it will help you to sort it out the problem.
   
  Thanks
  Krishna
  

Gowri Satish Adimulam <gowri@bitel.co.kr> wrote:
  Hi,
could you post the error message , so that group members can analyse and
post you correct solution.

Gowri
On Thu, 2006-03-23 at 23:45 -0800, Krishna wrote:
> Hi,
> 
> I have been trying to cross compile Linux/MIPS kernel verison 2.4.16
> with the specifix's sibyte cross compiler (sb1-elf cross compilers for
> x86 linux hosts) for BCM 1480 Broadcom board. I have set the path for
> cross compiler properly in make file even then the compilation failed.
> Then we tried adding parameter " -Tcfe.ld" (which is must for
> compilation) in compilation command (as has been suggested by
> broadcom) still unble to get it done correctly. Wondering what else we
> need to change in make file. Or else is there any other cross compiler
> for BCM 1480 (than specifix one) that we can use. Anyone suggest me
> the proper way for compiling the kernel with the above cross
> compiler. 
> 
> Thanks and Regards
> Krishna
> 
> ______________________________________________________________________
> New Yahoo! Messenger with Voice. Call regular phones from your PC and
> save big.



		
---------------------------------
Blab-away for as little as 1¢/min. Make  PC-to-Phone Calls using Yahoo! Messenger with Voice.
--0-1129037444-1143188922=:68158
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>here is the error description:</div>  <div>&nbsp;</div>  <div>********************************************************</div><FONT size=2>  <div>Makefile:489: .config: No such file or directory</div>  <div>scripts/basic/fixdep.c: In function `parse_config_file':</div>  <div>scripts/basic/fixdep.c:228: warning: implicit declaration of function `ntohl'</div>  <div>scripts/basic/fixdep.c: In function `print_deps':</div>  <div>scripts/basic/fixdep.c:336: warning: unused variable `map'</div>  <div>/home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040</div>  <div>/tmp/ccb1vCvc.o(.text+0x4): In function `usage':</div>  <div>: undefined reference to `_impure_ptr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x4): In function `usage':</div>  <div>: relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr</div>  <div>/tmp/ccb1vCvc.o(.text+0x1c): In
 function `usage':</div>  <div>: undefined reference to `fwrite'</div>  <div>/tmp/ccb1vCvc.o(.text+0x24): In function `usage':</div>  <div>: undefined reference to `exit'</div>  <div>/tmp/ccb1vCvc.o(.text+0x3c): In function `print_cmdline':</div>  <div>: undefined reference to `printf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x80): In function `grow_config':</div>  <div>: undefined reference to `realloc'</div>  <div>/tmp/ccb1vCvc.o(.text+0xc0): In function `grow_config':</div>  <div>: undefined reference to `perror'</div>  <div>/tmp/ccb1vCvc.o(.text+0xc8): In function `grow_config':</div>  <div>: undefined reference to `exit'</div>  <div>/tmp/ccb1vCvc.o(.text+0x148): In function `is_defined_config':</div>  <div>: undefined reference to `memcmp'</div>  <div>/tmp/ccb1vCvc.o(.text+0x1b8): In function `define_config':</div>  <div>: undefined reference to `memcpy'</div>  <div>/tmp/ccb1vCvc.o(.text+0x268): In function `use_config':</div>  <div>: undefined reference to `memcpy'</div> 
 <div>/tmp/ccb1vCvc.o(.text+0x340): In function `parse_config_file':</div>  <div>: undefined reference to `_ctype_'</div>  <div>/tmp/ccb1vCvc.o(.text+0x290): In function `use_config':</div>  <div>: undefined reference to `_ctype_'</div>  <div>/tmp/ccb1vCvc.o(.text+0x2e8): In function `use_config':</div>  <div>: undefined reference to `printf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x280): In function `use_config':</div>  <div>: undefined reference to `_ctype_'</div>  <div>/tmp/ccb1vCvc.o(.text+0x358): In function `parse_config_file':</div>  <div>: undefined reference to `_ctype_'</div>  <div>/tmp/ccb1vCvc.o(.text+0x360): In function `parse_config_file':</div>  <div>: undefined reference to `ntohl'</div>  <div>/tmp/ccb1vCvc.o(.text+0x374): In function `parse_config_file':</div>  <div>: undefined reference to `ntohl'</div>  <div>/tmp/ccb1vCvc.o(.text+0x388): In function `parse_config_file':</div>  <div>: undefined reference to `ntohl'</div>  <div>/tmp/ccb1vCvc.o(.text+0x3b0): In function
 `parse_config_file':</div>  <div>: undefined reference to `ntohl'</div>  <div>/tmp/ccb1vCvc.o(.text+0x3d8): In function `parse_config_file':</div>  <div>: undefined reference to `memcmp'</div>  <div>/tmp/ccb1vCvc.o(.text+0x498): In function `strrcmp':</div>  <div>: undefined reference to `strlen'</div>  <div>/tmp/ccb1vCvc.o(.text+0x4a4): In function `strrcmp':</div>  <div>: undefined reference to `strlen'</div>  <div>/tmp/ccb1vCvc.o(.text+0x4dc): In function `strrcmp':</div>  <div>: undefined reference to `memcmp'</div>  <div>/tmp/ccb1vCvc.o(.text+0x514): In function `do_config_file':</div>  <div>: undefined reference to `open'</div>  <div>/tmp/ccb1vCvc.o(.text+0x52c): In function `do_config_file':</div>  <div>: undefined reference to `fstat'</div>  <div>/tmp/ccb1vCvc.o(.text+0x540): In function `do_config_file':</div>  <div>: undefined reference to `close'</div>  <div>/tmp/ccb1vCvc.o(.text+0x560): In function `do_config_file':</div>  <div>: undefined reference to `close'</div> 
 <div>/tmp/ccb1vCvc.o(.text+0x57c): In function `do_config_file':</div>  <div>: undefined reference to `_impure_ptr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x57c): In function `do_config_file':</div>  <div>: relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr</div>  <div>/tmp/ccb1vCvc.o(.text+0x590): In function `do_config_file':</div>  <div>: undefined reference to `fwrite'</div>  <div>/tmp/ccb1vCvc.o(.text+0x598): In function `do_config_file':</div>  <div>: undefined reference to `perror'</div>  <div>/tmp/ccb1vCvc.o(.text+0x5a0): In function `do_config_file':</div>  <div>: undefined reference to `exit'</div>  <div>/tmp/ccb1vCvc.o(.text+0x5dc): In function `parse_dep_file':</div>  <div>: undefined reference to `strchr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x600): In function `parse_dep_file':</div>  <div>: undefined reference to `memcpy'</div>  <div>/tmp/ccb1vCvc.o(.text+0x614): In function `parse_dep_file':</div>  <div>: undefined reference to `printf'</div> 
 <div>/tmp/ccb1vCvc.o(.text+0x6a4): In function `parse_dep_file':</div>  <div>: undefined reference to `memcpy'</div>  <div>/tmp/ccb1vCvc.o(.text+0x704): In function `parse_dep_file':</div>  <div>: undefined reference to `printf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x714): In function `parse_dep_file':</div>  <div>: undefined reference to `printf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x7b8): In function `parse_dep_file':</div>  <div>: undefined reference to `printf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x7d0): In function `parse_dep_file':</div>  <div>: undefined reference to `_impure_ptr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x7d0): In function `parse_dep_file':</div>  <div>: relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr</div>  <div>/tmp/ccb1vCvc.o(.text+0x7e4): In function `parse_dep_file':</div>  <div>: undefined reference to `fwrite'</div>  <div>/tmp/ccb1vCvc.o(.text+0x7ec): In function `parse_dep_file':</div>  <div>: undefined reference to `exit'</div> 
 <div>/tmp/ccb1vCvc.o(.text+0x808): In function `print_deps':</div>  <div>: undefined reference to `open'</div>  <div>/tmp/ccb1vCvc.o(.text+0x820): In function `print_deps':</div>  <div>: undefined reference to `fstat'</div>  <div>/tmp/ccb1vCvc.o(.text+0x83c): In function `print_deps':</div>  <div>: undefined reference to `_impure_ptr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x83c): In function `print_deps':</div>  <div>: relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr</div>  <div>/tmp/ccb1vCvc.o(.text+0x844): In function `print_deps':</div>  <div>: undefined reference to `fprintf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x850): In function `print_deps':</div>  <div>: undefined reference to `close'</div>  <div>/tmp/ccb1vCvc.o(.text+0x868): In function `print_deps':</div>  <div>: undefined reference to `_impure_ptr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x868): In function `print_deps':</div>  <div>: relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr</div> 
 <div>/tmp/ccb1vCvc.o(.text+0x87c): In function `print_deps':</div>  <div>: undefined reference to `fwrite'</div>  <div>/tmp/ccb1vCvc.o(.text+0x884): In function `print_deps':</div>  <div>: undefined reference to `perror'</div>  <div>/tmp/ccb1vCvc.o(.text+0x88c): In function `print_deps':</div>  <div>: undefined reference to `exit'</div>  <div>/tmp/ccb1vCvc.o(.text+0x8a4): In function `traps':</div>  <div>: undefined reference to `ntohl'</div>  <div>/tmp/ccb1vCvc.o(.text+0x8c0): In function `traps':</div>  <div>: undefined reference to `_impure_ptr'</div>  <div>/tmp/ccb1vCvc.o(.text+0x8c0): In function `traps':</div>  <div>: relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr</div>  <div>/tmp/ccb1vCvc.o(.text+0x8cc): In function `traps':</div>  <div>: undefined reference to `fprintf'</div>  <div>/tmp/ccb1vCvc.o(.text+0x8d4): In function `traps':</div>  <div>: undefined reference to `exit'</div>  <div>/tmp/ccb1vCvc.o(.sdata+0x0): undefined reference to `_ctype_'</div> 
 <div>collect2: ld returned 1 exit status</div>  <div>make[2]: *** [scripts/basic/fixdep] Error 1</div>  <div>make[1]: *** [scripts_basic] Error 2</div>  <div>make: *** [include/linux/autoconf.h] Error 2</div>  <div></FONT>&nbsp;</div>  <div>******************************************************************************************</div>  <div>&nbsp;</div>  <div>Hope it will help you to sort it out the problem.</div>  <div>&nbsp;</div>  <div>Thanks</div>  <div>Krishna</div>  <div><BR><BR><B><I>Gowri Satish Adimulam &lt;gowri@bitel.co.kr&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR>could you post the error message , so that group members can analyse and<BR>post you correct solution.<BR><BR>Gowri<BR>On Thu, 2006-03-23 at 23:45 -0800, Krishna wrote:<BR>&gt; Hi,<BR>&gt; <BR>&gt; I have been trying to cross compile Linux/MIPS kernel verison 2.4.16<BR>&gt; with the specifix's sibyte cross compiler
 (sb1-elf cross compilers for<BR>&gt; x86 linux hosts) for BCM 1480 Broadcom board. I have set the path for<BR>&gt; cross compiler properly in make file even then the compilation failed.<BR>&gt; Then we tried adding parameter " -Tcfe.ld" (which is must for<BR>&gt; compilation) in compilation command (as has been suggested by<BR>&gt; broadcom) still unble to get it done correctly. Wondering what else we<BR>&gt; need to change in make file. Or else is there any other cross compiler<BR>&gt; for BCM 1480 (than specifix one) that we can use. Anyone suggest me<BR>&gt; the proper way for compiling the kernel with the above cross<BR>&gt; compiler. <BR>&gt; <BR>&gt; Thanks and Regards<BR>&gt; Krishna<BR>&gt; <BR>&gt; ______________________________________________________________________<BR>&gt; New Yahoo! Messenger with Voice. Call regular phones from your PC and<BR>&gt; save big.<BR><BR></BLOCKQUOTE><BR><p>
		<hr size=1>Blab-away for as little as 1¢/min. Make <a href="http://us.rd.yahoo.com/mail_us/taglines/postman2/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone Calls</a> using Yahoo! Messenger with Voice.
--0-1129037444-1143188922=:68158--
