Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 03:02:03 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:28070
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225239AbTFYCCB>; Wed, 25 Jun 2003 03:02:01 +0100
Received: (qmail 15178 invoked from network); 25 Jun 2003 01:26:43 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 25 Jun 2003 01:26:43 -0000
Message-ID: <3EF90275.2050903@ict.ac.cn>
Date: Wed, 25 Jun 2003 10:01:25 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: ik@cyberspace.org
CC: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Subject: Re: is there any docs/manuals for linker scripts symbols
References: <Pine.SUN.3.96.1030624055005.4605A-100000@grex.cyberspace.org>
In-Reply-To: <Pine.SUN.3.96.1030624055005.4605A-100000@grex.cyberspace.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

info ld give much more information than man ld.

for those symbols,you need to learn something about ELF file format
(its concept of sections)

ik@cyberspace.org wrote:

>Hi All,
>
>Is there any documentation for the symbols in the ld.script linker
>scripts for the linux kernel. 
>
>I'm porting Linux kernel to a mips board for which I need to understand
>the various symbols used in the kernel.
>
>For example what is the use of the following symbols
>`__init_begin'
>`__init_end'
>`__initcall_start
>`__initcall_end'
>`_ftext'
>`__setup_start'
>`__setup_end'
>
>I'm not good in these linker scripts... any help pointers would be of
>great help to me ! (I'm referrring gnu ld  manual pages ... still have a
>long way to go :(
>
>Thanks in advance !
>Indu
>
>
>
>
>  
>
