Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 10:35:30 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:44220
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225232AbTE0JfX>; Tue, 27 May 2003 10:35:23 +0100
Received: (qmail 16451 invoked from network); 27 May 2003 09:05:03 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 27 May 2003 09:05:03 -0000
Message-ID: <3ED33148.2040008@ict.ac.cn>
Date: Tue, 27 May 2003 17:35:04 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: about gas load_address
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

hi,all

(sorry if it is somewhat out of topic,but i think most mips experts
are here:)

else if (mips_pic == SVR4_PIC && ! mips_big_got)
{
expressionS ex;

/* If this is a reference to an external symbol, we want
lw $reg,<sym>($gp) (BFD_RELOC_MIPS_GOT16)
Otherwise we want
lw $reg,<sym>($gp) (BFD_RELOC_MIPS_GOT16)
nop
QUESTION:
Could somebody tell me why we generate a unconditional 'nop' here?
addiu $reg,$reg,<sym> (BFD_RELOC_LO16)
If there is a constant, it must be added in after.

If we have NewABI, we want
lw $reg,<sym+cst>($gp) (BFD_RELOC_MIPS_GOT_DISP)
unless we're referencing a global symbol with a non-zero
offset, in which case cst must be added separately. */

Thanks in advance.
