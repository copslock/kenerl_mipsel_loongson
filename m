Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3HA2M8d014912
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 03:02:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3HA2Lr8014911
	for linux-mips-outgoing; Wed, 17 Apr 2002 03:02:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3HA2G8d014907
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 03:02:17 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id g3HA3Dc12954
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 12:03:14 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id JBQJ7RPG; Wed, 17 Apr 2002 12:03:13 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Wed, 17 Apr 2002 12:03:12 +0200
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <D4M0V4ZH>; Wed, 17 Apr 2002 12:03:20 +0200
Message-ID: <86048F07C015D311864100902760F1DD01B5E8DD@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: Wait queue problem
Date: Wed, 17 Apr 2002 12:03:19 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Does anybody else have problems using wait queues in a 2.4.5 MIPS kernel?
When I try to wake up a process from an interrupt it won't start to execute.
It always waits for the timeout before resuming work. 
In principal my code look like this:

wait_queue_head_t wq;

foo() {
init_waitqueue_head(&wq);
interruptible_sleep_on_timeout(&wq,10*HZ);
}

foo_int() {
wake_up_interuptible(&wq);
}

Am I missing something? 

best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
