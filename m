Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8F2Y0109974
	for linux-mips-outgoing; Fri, 14 Sep 2001 19:34:00 -0700
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8F2Xse09971;
	Fri, 14 Sep 2001 19:33:55 -0700
Received: from hechendong11752 ([10.105.28.117]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GJON0Y00.F3N; Sat, 15 Sep 2001 10:31:46 +0800 
Message-ID: <000901c13d8f$1471bb20$751c690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
Subject: About KGDB debug questions...
Date: Sat, 15 Sep 2001 10:35:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

    I have a question about KGDB debug. Sometimes when I run 'n' on host
GDB, then the target KGDB receive many packets and cannot stop, and the EPC
is adding 4 each time it receives a packet. It looks like  'c'without any
breakpoints.
Any suggestions? Are there any patches?

And what is the latest mips version of linux? Which tree can I download it ?

BTW:Currently I use linux-2.4.5-pre1.



machael thailer
