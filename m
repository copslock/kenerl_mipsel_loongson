Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3HML48d023663
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 15:21:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3HML4Gs023662
	for linux-mips-outgoing; Wed, 17 Apr 2002 15:21:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3HML18d023657
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 15:21:02 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Wed, 17 Apr 2002 15:21:54 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from nt-sjcb-0501.sv.broadcom.com (
 nt-sjcb-0501.sj.broadcom.com [10.19.192.19]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id PAA11685 for
 <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 15:21:58 -0700 (PDT)
Received: by mail.sv.broadcom.com with Internet Mail Service (
 5.5.2653.19) id <FKGJ9725>; Wed, 17 Apr 2002 15:21:57 -0700
Message-ID: <E1EBEF4633DBD3118AD1009027E2FFA0023FB64D@mail.sv.broadcom.com>
From: "Mark Huang" <mhuang@broadcom.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: DBE table ordering
Date: Wed, 17 Apr 2002 15:21:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 10A32A08228643-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

search_one_table() in arch/mips/kernel/traps.c does a binary search for the
erring instruction address in the DBE table. What guarantee is there that
the table is in order by instruction address? It looks like the code hasn't
changed in a long time and it has worked for me since at least 2.4.3.
However, a top of tree (2.5.1) kernel crashes on me as soon as a get_dbe()
fails, because the table is out of order at link time---possibly run time if
there's some code that I missed that is reordering the table at __init. Any
ideas?

Thanks in advance,

--Mark
