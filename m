Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 03:04:15 +0100 (BST)
Received: from web32102.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.116]:36543
	"HELO web32102.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225617AbVIVCD4>; Thu, 22 Sep 2005 03:03:56 +0100
Received: (qmail 77345 invoked by uid 60001); 22 Sep 2005 02:03:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HHKINGEIzbfF4trZ81x+QyzmOg7BzpaUrrox1alri9SD02nNWHl6EqhjkAFvj8ir827vcK4DckF5/qmDPEr27AuHT44Iqv+7SgJ91avx7DOx/oBAhOm1CBStuaWxx8eMCq8keT+MyA6HFYcT9iDrqQgP0mpsjgN3ZmOykfDudvM=  ;
Message-ID: <20050922020349.77343.qmail@web32102.mail.mud.yahoo.com>
Received: from [66.236.104.214] by web32102.mail.mud.yahoo.com via HTTP; Wed, 21 Sep 2005 19:03:49 PDT
Date:	Wed, 21 Sep 2005 19:03:49 -0700 (PDT)
From:	Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: Kernel panic problem
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <raghavanvinay@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghavanvinay@yahoo.com
Precedence: bulk
X-list: linux-mips


Hey guys,


I am getting the following error running Linux on a
MIPS platform.

Its basically a kernel panic errror. The error message
is as below.

Any help/pointers would be of great help. 
Thanks
Vinay


Got mcheck at c0043938

Cpu 0

$ 0   : 00000000 1000e801 c0050000 00000000

$ 4   : 00000093 810b1000 8034bec8 b8038030

$ 8   : 00004000 00000000 1000e800 80dea000

$12   : 00ff0000 ff000000 00000025 c1100000

$16   : 81aebee8 00000000 00000001 00000000

$20   : 8034bec8 00000093 00000010 00000010

$24   : 00000001 00000003                  

$28   : 8034a000 8034be40 fffffffc 80144588

Hi    : 00000000

Lo    : 00000000

epc   : c0043938 linux_layer_isr+0xc/0x28 [n2_drv]    
Tainted: P     

ra    : 80144588 handle_IRQ_event+0x78/0xfc

Status: 1020e803    KERNEL EXL IE 

Cause : 00800060

PrId  : 0001800a

 

Index:  0 pgmask=4kb va=c0046000 asid=45

                        [pa=01ee0000 c=3 d=1 v=1 g=1]

                        [pa=01ee1000 c=3 d=1 v=1 g=1]

 

Index:  8 pgmask=4kb va=c004a000 asid=45

                        [pa=01ee4000 c=3 d=1 v=1 g=1]

                        [pa=00000000 c=0 d=0 v=0 g=1]

 

Kernel panic - not syncing: Caught Machine Check
exception - caused by multiple matching entries in the
TLB.
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
