Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2005 10:20:29 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:49132
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225601AbVGZJUN>; Tue, 26 Jul 2005 10:20:13 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j6Q9MdS5030888
	for <linux-mips@linux-mips.org>; Tue, 26 Jul 2005 18:22:39 +0900
Date:	Tue, 26 Jul 2005 18:25:31 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	linux-mips@linux-mips.org
Subject: how to access structured registers correctly
Message-Id: <20050726182531.6341586f.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello experts,

I am wondering how to access registers correctly by usging structured 
register definitions in TX4938 particularly.

Some time ago, Linus told "volatile" on a data structure as described 
below,

	http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1387.html


In tx4938, every register access is done by using "volatile" like below.

 
    include/asm-mips/tx4938/tx4938.h:
    
       313  struct tx4938_ccfg_reg {
       314          volatile unsigned long long ccfg;
                    ^^^^^^^^
       315          volatile unsigned long long crir;
       316          volatile unsigned long long pcfg;
       317          volatile unsigned long long tear;

    
    arch/mips/tx4938/toshiba_rbtx4938/setup.c:
    
       410  int __init tx4938_pciclk66_setup(void)
       411  {
       412          int pciclk;
       413  
       414          /* Assert M66EN */
       415          tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI66;
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


In order to remove "volatile" on data structure and fix the above situation, I gues, 
some functions are provided in header files:

	1. "reg_rd08(r)" family
	2. "TX4938_RD08(r)" family
	3. "readb(r)" family

Could you tell me which is suitable for this situation?

For exmaple, if #"2" is applied, the code would become like below:

    arch/mips/tx4938/toshiba_rbtx4938/setup.c:

       433  int __init tx4938_pciclk66_setup(void)
       434  {
       435          int pciclk;
       436          unsigned long long v;
       437          /* Assert M66EN */
       438          v = TX4938_RD64(&tx4938_ccfgptr->ccfg);
       439          TX4938_WR64(&tx4938_ccfgptr->ccfg, v | TX4938_CCFG_PCI66);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Any information would be appreciated.

	Hiroshi DOYU
