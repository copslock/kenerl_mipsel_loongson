Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OLQqwJ020939
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 14:26:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OLQqrx020938
	for linux-mips-outgoing; Wed, 24 Apr 2002 14:26:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OLQmwJ020934
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 14:26:48 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 24 Apr 2002 14:26:48 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from dtatlaturcotte (dhcp-10-24-65-229.atlanta.broadcom.com
 [10.24.65.229]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with SMTP id
 OAA01263; Wed, 24 Apr 2002 14:27:14 -0700 (PDT)
Reply-to: turcotte@broadcom.com
From: "Maurice Turcotte" <turcotte@broadcom.com>
To: linux-mips@oss.sgi.com
cc: "Maurice Turcotte" <mturc@broadcom.com>
Subject: Linux Shared Memory Issue
Date: Wed, 24 Apr 2002 17:27:12 -0400
Message-ID: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com>
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-WSS-ID: 10D9FC9D671529-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings:

I am having a problem with Linux Kernel 2.4.5 on a mips.

I have two processes using share memory for IPC. This same
code works fine with Kernel 2.4.7 on a x86. The problem is 
that the second process reads old data out of the shared
memory.

The executive summary->

Process #1 writes "A" to shared memory at 0x2aac7210
Process #2 reads 0 from shared memory at address 0x2aaca210
Process #1 writes "B" to shared memory at 0x2aac7210
Process #2 read "A" from shared memory at address 0x2aaca210
Process #1 writes "C" to shared memory at 0x2aac7210
Process #2 read "B" from shared memory at address 0x2aaca210

It is interesting that the processes get different addresses
associated with the same shmId. I assume this is because of 
some user-space mapping that is going on.

I left out the semaphore diddling, but I believe that part of
the code is correct because it works flawlessly on the 2.4.7 x86.

Any tips on debugging this would be greatly appreciated. If this
is not the proper forum for questions like this, please point me
in the right direction.

Thanks,

mturc
