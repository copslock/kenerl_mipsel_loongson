Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 04:33:48 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.152]:27794 "EHLO
	yw-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024842AbZD0Ddl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 04:33:41 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1302073ywk.24
        for <linux-mips@linux-mips.org>; Sun, 26 Apr 2009 20:33:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=YFiwCF5THj2ve+WDp3/G89q8tyz2bSl1oyJDYI52piw=;
        b=DNM1PdZ3HkwOZoG0/rgfovcemSUiuZ+4SK/jPrUjvntVsWTBogO24KX+FUst5plH5X
         FXo2WxQHWeW3w++AVU3tGkzSyzZOWNySnXBTWex8b7mD3fE9spTOvtVT9ZBJUYE2Ahb3
         SEfsCdSjMi4NrSotg4w7iH3w2L0dP1ykBqITY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=T2w1CCerIMLsqTufp/3Rc/vt4VyUXhwOWNPBJR+O8tLtvGsFpaRYgLtNEzUX/xVEtc
         wwD9uJvPAh/cDd90VB8sxi9JT/RHf9BiF0vbmv+cghJJ6oD4I7zLq/v+YWKs82nNVvAa
         gJmPXb9IVfSHzasRIehCABYFHHOO8Fjer0P5s=
MIME-Version: 1.0
Received: by 10.151.121.11 with SMTP id y11mr7957527ybm.106.1240803219468; 
	Sun, 26 Apr 2009 20:33:39 -0700 (PDT)
Date:	Mon, 27 Apr 2009 11:33:39 +0800
Message-ID: <777f39b10904262033o124be1f1o22297da7c67f9dbd@mail.gmail.com>
Subject: =?GB2312?Q?how_to_debug_mips_AdEL_error=A3=BF_Cause_register=27s_Exc?=
	=?GB2312?Q?Code_field_equal_to_=274=27_=28AdEL=29?=
From:	Bob Zhang <2004.zhang@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	"bob.zhang2004" <bob.zhang2004@gmail.com>,
	"Christophe.Carvounas" <christophe.carvounas@gmail.com>,
	Bob Zhang <2004.zhang@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <2004.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 2004.zhang@gmail.com
Precedence: bulk
X-list: linux-mips

I am porting suspend2 to mips archtecture,
suspend is OK, but resume has kernel panic.

my mips is mips4KE
I only want to know how to debug this issue from kernel panic info
,thanks very much! any comments will be welcome.

this kernel panic:
About to restore original console.
swsusp_default_console_level = 1
console_loglevel=7
default_message_loglevel = 4
orig_default_message_loglevel=0
at end of do_software_suspend
Kernel unaligned instruction access in unaligned.c::do_ade, line 446:

CPU Regs : ===========================================================
$0 : 00000000 80290000 00000100 fffdffff 00000007 00000006 8023427c 820e83d4
$8 : 00000000 00000000 00000000 820e83dc 820e83f4 820e8000 80278010 00000000
$16: 8028f7b8 0000d32b 0000132b 802a53a0 0000d34d 7fff7d48 00000004 00000014
$24: 8200000c 2abe4090                   820e8000 820e9e70 00000000 0000000a
Hi : 0000007a
Lo : 000000b7
epc   : 0000000a    Tainted: G Z             # obvisouly 0x0000000a is
error , 1:too small 2:not 4 byte boundary.
BadVaddr:0000000a                              #equal to epc value.
Status: 10008403
Cause : 10800010                                 #ExcCode is AdEL
PrId  : 0001906c
Process init (pid: 1, stackpage=820e8000)
show_stack ============================================================
Stack:    80287ce0 0000003e 0000003c 800b93cc 00000000 00000400 80111b40
 00000000 0000134d ffffffff 0000d34d 10008400 00000001 800b9460 0000000b
 00000185 00000004 00000001 10008400 802a4fc4 80287cf0 10008400 00000001
 0000000a 80287ce0 0000003c 800b9ac0 800b99bc 802391b0 10008400 8023916c
 802391b0 802a4fc2 802a4fc4 800b9868 820b6d94 00000185 820b72e0 80238ac2
 7fff7ba8 00000022 00000000 8028a23c 80287cdc 802391b0 8023916c 8023916c
 802391b0 80287cdc 00000014 00000005 800da974 80238aa0 99669967 83feb000
 8028a9d4 00000202 00000000 0000000b 7fff7ba8 00000000 00000001 00008400
 820b1ea0 00000000 00000002 8028a9d4 00000003 820e9ef8 00000002 00000000
 7fff7ba8 0000000b 00000000 7fff7a28 7fff7d48 00000004 00000014 00000000
 2ab61a30 00000000 00000000 2abe7bf0 7fff79b8 00000005 0040709c 00000000
 00000000 2ab61a94 00000008 00008413 10800020 fbbffffe fb7fffff ffffdffb
 bfefefef fdf67ffe b6edefff f7f7fff6 efedffff
show_trace =============================================================
Call Trace:   [<800b93cc>] [<80111b40>] [<800b9460>] [<800b9ac0>] [<800b99bc>]
 [<802391b0>] [<8023916c>] [<802391b0>] [<800b9868>] [<80238ac2>] [<802391b0>]
 [<8023916c>] [<8023916c>] [<802391b0>] [<800da974>] [<80238aa0>]
show_code ==============================================================

Code:<7>init: Forwarding exception at [<800acfe0>] (802569d8)
 (Bad address in epc)

Kernel panic: Attempted to kill init!
 UART_MSR_ANY_DELTA



about error exception :mips mannual :
4.8.9 Address Error Exception — Instruction Fetch/Data Access
An address error exception occurs on an instruction or data access
when an attempt is made to execute one of the following:
       • Fetch an instruction, load a word, or store a word that is
not aligned on a word boundary
       • Load or store a halfword that is not aligned on a halfword boundary
       • Reference the kernel address space from user mode

Note that in the case of an instruction fetch that is not aligned on a
word boundary, PC is updated before the condition
is detected. Therefore, both EPC and BadVAddr point to the unaligned
instruction address. In the case of a data
access the exception is taken if either an unaligned address or an
address that was inaccessible in the current processor
mode was referenced by a load or store instruction.
Cause Register ExcCode Value:
    ADEL: Reference was a load or an instruction fetch
    ADES: Reference was a store


Please note : kernel has printed EPC and Cause ,Status registers value:
epc   : 0000000a    Tainted: G Z
BadVaddr:0000000a
Status: 10008403
Cause : 10800010

I judge this Cause's ExcCode register (bit6:2) is 2#000100    , 10#4

Table 5.23 Cause Register ExcCode Field
    4 16#04 AdEL Address error exception (load or instruction fetch)

so this error is AdEL exception.

from this info:
     "Note that in the case of an instruction fetch that is not
aligned on a word boundary, PC is updated before the condition
      is detected. Therefore, both EPC and BadVAddr point to the
unaligned instruction address"
we know, this AdEL is of "instruction fetch" error.


5.2.9 BadVAddr Register (CP0 Register 8, Select 0)
The BadVAddr register is a read-only register that captures the most
recent virtual address that caused one of the following
exceptions:
• Address error (AdEL or AdES)
• TLB Refill (4KEc core)
• TLB Invalid (4KEc core)
• TLB Modified (4KEc core)
