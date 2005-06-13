Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 15:06:58 +0100 (BST)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:20150 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225824AbVFMOGl>;
	Mon, 13 Jun 2005 15:06:41 +0100
Received: (qmail 28575 invoked by uid 0); 13 Jun 2005 14:06:34 -0000
Received: from 129.13.186.3 by www68.gmx.net with HTTP;
	Mon, 13 Jun 2005 16:06:34 +0200 (MEST)
Date:	Mon, 13 Jun 2005 16:06:34 +0200 (MEST)
From:	"Mad Props" <madprops@gmx.net>
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Subject: tlb magic
X-Priority: 3 (Normal)
X-Authenticated: #24801140
Message-ID: <31886.1118671594@www68.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <madprops@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madprops@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to understand how to implement an TLB Exception handler for a
MIPS32 ( 4KC ). As far as I got it, it makes sense to locate the user
process page tables in kseg2 to save physical memory. The book I'm reading
states another advantage using kseg2. I'm not quite sure what they mean,
stating that

"It provides an easy mechanism for remapping a new user page table when
changing context, without having to find enough virtual addresses in the OS
to map all the page tables at once. Instead, you just change the ASID value,
and the kseg2 pointer to the page table is now automatically remapped onto
the correct page table. It's nearly magic."


1. Is there only one kseg2 containing all page tables for 256 processes,
i.e. only one ASID is used or

2. Has each page table it's own address space ( using different ASID for
those addresses in kseg2 )

3. Will I need another untranslated page table in kseg0/kseg1 to translate
kseg2 addresses ?

4. What is this kseg2 pointer they are talking about ?

5. Are they talking about the ASID in EntryHi ?

6. Where is the magic ?

Would be smashing if anybody could help me out.

Kind regards,

Thomas

 

-- 
Geschenkt: 3 Monate GMX ProMail gratis + 3 Ausgaben stern gratis
++ Jetzt anmelden & testen ++ http://www.gmx.net/de/go/promail ++
