Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0JBPT429528
	for linux-mips-outgoing; Sat, 19 Jan 2002 03:25:29 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0JBPQP29524
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 03:25:26 -0800
Received: from r19223c ([172.17.254.1]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GQ6FUY00.1BA for
          <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 16:35:22 +0800 
Message-ID: <025901c1a0c4$30ec20e0$3d6e0b0a@huawei.com>
From: "renc stone" <renwei@huawei.com>
To: <linux-mips@oss.sgi.com>
Subject: use float in no-fpu mips kernel modules?
Date: Sat, 19 Jan 2002 16:34:59 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
  Any one know how to use float point in mips kernel?
  We use some 2.4.5 kernel, on idt mips 32334, which has no fpu, I think.
  we want to use the float numbers like this:
  float a = 87;
  a * = 1.04;
  Any kernel functions to do this? or how to compile it use soft fpu
support?


     Thanks in advance.
