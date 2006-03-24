Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 13:20:06 +0000 (GMT)
Received: from web53514.mail.yahoo.com ([206.190.39.68]:42857 "HELO
	web53514.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133904AbWCXNT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 13:19:56 +0000
Received: (qmail 96165 invoked by uid 60001); 24 Mar 2006 13:29:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ac54qI2Z+MNXAJwBWEiimKjNV57De3szFhgpci8sIVhnN0lW59u8c1+oKpcVK1fU6EMXxhsohXonVTAF2yX+sRKbrtbkAd/hoSRlzJitDXqdH+xAA9PlcKPXoF8ZD5i+ZZjZKMF43dMRTN8GX0384RbfOauiiCvIN9s9jX+cELk=  ;
Message-ID: <20060324132954.96163.qmail@web53514.mail.yahoo.com>
Received: from [203.145.155.11] by web53514.mail.yahoo.com via HTTP; Fri, 24 Mar 2006 05:29:54 PST
Date:	Fri, 24 Mar 2006 05:29:54 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: Re: Compilation problem with kernel 2.4.16
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060324113525.GA3250@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2012749339-1143206994=:96010"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-2012749339-1143206994=:96010
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

then will u please suggest me which compiler to use to compile kernel 2.6.14 for BCM1480 or else where i get the proper compiler.

Ralf Baechle <ralf@linux-mips.org> wrote:   On Fri, Mar 24, 2006 at 01:49:16AM -0800, Krishna wrote:

> Sorry I mentioned version incorrectly. It is 2.6.14. The compiler i m using
> is sb1-elf-gcc (which i downloaded from
> www.broadcom.com/products/sibyte_downloads.php#toolchain). Her is the error description:

The *-elf gcc configuration will not work for compiling Linux/MIPS or
applications; you need a mips-linux target.

> **********************************************
> Makefile:489: .config: No such file or directory
> scripts/basic/fixdep.c: In function `parse_config_file':
> scripts/basic/fixdep.c:228: warning: implicit declaration of function `ntohl'
> scripts/basic/fixdep.c: In function `print_deps':
> scripts/basic/fixdep.c:336: warning: unused variable `map'
> /home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040
> /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr

These messages seem to indicate you did something bad to the makefiles.
The crosscompiler is being invoked where the target compiler should be.

Ralf




*Krishna*
			
---------------------------------
Yahoo! Messenger with Voice. PC-to-Phone calls for ridiculously low rates.
--0-2012749339-1143206994=:96010
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

then&nbsp;will&nbsp;u please suggest me which compiler to use to compile kernel 2.6.14 for BCM1480 or else where i get the proper compiler.<BR><BR><B><I>Ralf Baechle &lt;ralf@linux-mips.org&gt;</I></B> wrote:   <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Fri, Mar 24, 2006 at 01:49:16AM -0800, Krishna wrote:<BR><BR>&gt; Sorry I mentioned version incorrectly. It is 2.6.14. The compiler i m using<BR>&gt; is sb1-elf-gcc (which i downloaded from<BR>&gt; www.broadcom.com/products/sibyte_downloads.php#toolchain). Her is the error description:<BR><BR>The *-elf gcc configuration will not work for compiling Linux/MIPS or<BR>applications; you need a mips-linux target.<BR><BR>&gt; **********************************************<BR>&gt; Makefile:489: .config: No such file or directory<BR>&gt; scripts/basic/fixdep.c: In function `parse_config_file':<BR>&gt; scripts/basic/fixdep.c:228: warning: implicit declaration of function
 `ntohl'<BR>&gt; scripts/basic/fixdep.c: In function `print_deps':<BR>&gt; scripts/basic/fixdep.c:336: warning: unused variable `map'<BR>&gt; /home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040<BR>&gt; /tmp/ccb1vCvc.o(.text+0x4): In function `usage':<BR>&gt; : undefined reference to `_impure_ptr'<BR>&gt; /tmp/ccb1vCvc.o(.text+0x4): In function `usage':<BR>&gt; : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr<BR><BR>These messages seem to indicate you did something bad to the makefiles.<BR>The crosscompiler is being invoked where the target compiler should be.<BR><BR>Ralf<BR><BR></BLOCKQUOTE><BR><BR><BR>*Krishna*<p>
	
		<hr size=1><a href="http://us.rd.yahoo.com/mail_us/taglines/postman3/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com 
">Yahoo! Messenger with Voice.</a> PC-to-Phone calls for ridiculously low rates.
--0-2012749339-1143206994=:96010--
