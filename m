Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 05:38:39 +0100 (BST)
Received: from mx1.tusur.ru ([IPv6:::ffff:212.192.163.19]:23054 "EHLO tusur.ru")
	by linux-mips.org with ESMTP id <S8224773AbUGUEid>;
	Wed, 21 Jul 2004 05:38:33 +0100
Received: from localhost (localhost.tusur.ru [127.0.0.1])
	by tusur.ru (Postfix) with SMTP id 1DA93B68FC
	for <linux-mips@linux-mips.org>; Wed, 21 Jul 2004 11:34:40 +0700 (TSD)
X-AV-Checked: Wed Jul 21 11:34:40 2004 Ok
Received: from roman (unknown [211.189.32.204])
	by tusur.ru (Postfix) with ESMTP id 90E2EB68D7
	for <linux-mips@linux-mips.org>; Wed, 21 Jul 2004 11:34:32 +0700 (TSD)
Message-ID: <002601c46edc$809fe700$cc20bdd3@roman>
From: "Roman Mashak" <mrv@tusur.ru>
To: <linux-mips@linux-mips.org>
Subject: YAMON compiling
Date: Wed, 21 Jul 2004 13:37:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1081
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1081
FL-Build: Fidolook 2002 (SL) 6.0.2800.85 - 28/1/2003 19:07:30
X-Spam-DCC: : 
Return-Path: <mrv@tusur.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@tusur.ru
Precedence: bulk
X-list: linux-mips

Hello!

After installing  SDE toolkit onto Linux box I tried to compile the
YAMON bootloader source code (version of YAMON is 2.00). Few errors arised:

../arch/include/mips.h: Assembler messages:
../arch/include/mips.h:397: Warning: rest of line ignored; first ignored
character is `/'
../arch/include/mips.h:398: Warning: rest of line ignored; first ignored
character is `/'
../arch/include/mips.h:399: Warning: rest of line ignored; first ignored
character is `/'
../arch/include/pb1000.h:1: Warning: rest of line ignored; first ignored
character is `/'
../arch/include/pb1000.h:3: Warning: rest of line ignored; first ignored
character is `/'
../arch/include/pb1000.h:406: Warning: rest of line ignored; first ignored
character is `/'
./../init/reset/reset.S:98: Warning: rest of line ignored; first ignored
character is `/'
./../init/reset/reset.S:99: Warning: rest of line ignored; first ignored
character is `/'
../arch/init/reset_db1550.S:641: Warning: rest of line ignored; first
ignored character is `/'
../arch/init/reset_db1550.S:739: Error: absolute expression required `li'
../arch/init/reset_db1550.S:783: Error: absolute expression required `li'
../arch/init/reset_db1550.S:821: Error: absolute expression required `li'
make: *** [reset.o] Error1

The lines in mips.h that arise these warnings are the following:

// #define AU1000 0x00030100
//#define AU1000 0x01030200
//#define AU1000_2_1 0x00030200

It seems it doesn't understand the comment syntax.

    I have installed the version 5.03.06-LITE of SDE. Following is the code
extract around which error occures:

#define t1 $9
#define mem_sdconfiga  0x0840
#define MEM_SDCONFIGA_DDR   0x9030060A
#define MEM_SDREFCFG_D_DDR  MEM_SDCONFIGA_DDR

li      t1, MEM_SDREFCFG_D_DDR
sw      t1, mem_sdconfiga(t0)
sync

Compiler thinks  'li t1, MEM_SDREFCFG_D_DDR'  is 'bad expression',  may be
it guesses MEM_SDREFCFG_D_DDR is not defined correctly?

Thank you for every help in advance!

With best regards, Roman Mashak.  E-mail: mrv@tusur.ru
