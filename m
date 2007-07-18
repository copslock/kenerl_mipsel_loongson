Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2007 09:21:49 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:51043 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20022116AbXGRIVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2007 09:21:46 +0100
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 18 Jul 2007 16:20:33 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Jul 2007 16:20:33 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: linux-2.6.20 setjmp/longjmp OR how to contain bus-error fornon-existing PCI device during PCI device scan?
Date:	Wed, 18 Jul 2007 16:20:33 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C172986019B76DC@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux-2.6.20 setjmp/longjmp OR how to contain bus-error fornon-existing PCI device during PCI device scan?
Thread-Index: AcfInLMyn7WweyFBSb6ezkR5Z/9x0QAcjy6u
References: <31E09F73562D7A4D82119D7F6C172986019B76D7@sinse303.ap.infineon.com> <20070717180247.GA32255@linux-mips.org>
From:	<KokHow.Teh@infineon.com>
To:	<ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 18 Jul 2007 08:20:33.0984 (UTC) FILETIME=[8320C400:01C7C914]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi Ralf;
 
>>    I am using linux-2.6.20 on MIPS24KE and I need to know what is the best way to contain bus error during PCI bus >>scan process for non-existing device? I thought of setjmp/longjmp but unfortunately, I have `googled` and `find` the >>whole kernel source tree there is no such support in the kernel for MIPS architecture. Any insight is appreciated.

>Welcome to the kernel, there are no setjmp / longjmp.  You can can try to
>use the functions from <asm/paccess.h> to protect your memory accesses
>against bus error exceptions.  Note this won't work for cases where the
>bus error exceptions is imprecise because then the EPC for the exception
>isn't guranteed to have the proper value. 
 
Is there any general way to find out if the bus error exception is precise?
 
b7000800: <6>Bus Error!

Data bus error, epc == 80035ca4, ra == 8042f2dc

Oops[#1]:

Cpu 0

$ 0 : 00000000 0000000a 0000000e 00000001

$ 4 : 803b575c ffffffff 803fa314 be100c00

$ 8 : 804c0000 001ac70b 0000000b 804cc6e0

$12 : 804c0000 8040470c 00000002 00000000

$16 : b7000800 00000000 803e0000 b7ffffff

$20 : 803da18c 803b0000 00000000 00000000

$24 : 804c0000 0000000c

$28 : 81058000 81059f20 00000000 8042f2dc

Hi : 00000000

Lo : 00000000

epc : 80035ca4 printk+0x4/0x28 Not tainted

ra : 8042f2dc danube_pcibios_init+0x434/0x458

Status: 1100fe03 KERNEL EXL IE

Cause : 0080001c

PrId : 00019641

Modules linked in:

Process swapper (pid: 1, threadinfo=81058000, task=81056868)

Stack : 803fa314 be100c00 80410000 00000103 8042f2c4 8042f21c 00000000 b7000800

803fa314 00000000 80408dbc 80408dc4 80436948 00000000 80430000 00000000

80436b78 00000000 00000000 80002500 00000000 00000000 00000000 00000000

00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

00000000 00000000 00000001 00000000 00000000 00000000 00000000 00000000

...

Call Trace:

[<80035ca4>] printk+0x4/0x28

[<8042f2dc>] danube_pcibios_init+0x434/0x458

[<80002500>] init+0xb0/0x3b0

[<8000f9b0>] kernel_thread_helper+0x10/0x18

 

Code: 1000fe4e 00000000 27bdffe8 <afa5001c> 27a5001c afbf0010 afa60020 0c00d55e afa70024

Kernel panic - not syncing: Attempted to kill init!

> The get_dbe / put_dbe functions
>are used just like get_user / put_user from <linux/uaccess.h> except that
>those are meant to protect against TLB exceptions.

I used get_dbe and it still doesn't solve the problem.

>Or just temporarily disable the bus error in your PCI config space
>accessors.

I will use this method but I need to know how to find out if the bus error exception is precise.

Thanks & Regards,
KH
