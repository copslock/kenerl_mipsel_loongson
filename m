Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KHgAnC001515
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 10:42:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4KHgAAX001514
	for linux-mips-outgoing; Mon, 20 May 2002 10:42:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from portal.wmi.com (wmi.com [66.105.85.211])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4KHg8nC001511
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 10:42:09 -0700
Received: from cac0.wmi.com (cac0.wmi.com [66.105.85.220])
	by portal.wmi.com (8.11.6/8.11.6) with ESMTP id g4KHhPR02928
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 13:43:25 -0400
Received: from wmiddm (wmiddm.wmi.com [192.168.1.139])
	by cac0.wmi.com (8.11.0/8.11.0) with SMTP id g4KHhPe19856
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 13:43:25 -0400
Message-ID: <000e01c20025$d6216d20$8b01a8c0@wmiddm>
From: "David D. McCoach" <ddm@wmi.com>
To: <linux-mips@oss.sgi.com>
Subject: 2.4.3 bss alignment bug
Date: Mon, 20 May 2002 13:43:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does anyone know of a bug the cause an unaligned access in the kernel when
the alignment
of the bss segment os changed?

Thanks
