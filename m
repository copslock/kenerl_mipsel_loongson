Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5H9kAnC014461
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 02:46:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5H9kAZk014460
	for linux-mips-outgoing; Mon, 17 Jun 2002 02:46:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ws3-2.us4.outblaze.com (205-158-62-92.outblaze.com [205.158.62.92])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5H9k7nC014457
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 02:46:07 -0700
Received: (qmail 30732 invoked by uid 1001); 17 Jun 2002 09:48:51 -0000
Message-ID: <20020617094851.30730.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [202.140.142.131] by ws3-2.us4.outblaze.com with http for
    balakris_ananth@email.com; Mon, 17 Jun 2002 04:48:51 -0500
From: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>
To: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
   redhat-list@redhat.com
Date: Mon, 17 Jun 2002 04:48:51 -0500
Subject: Code error - why?
X-Originating-Ip: 202.140.142.131
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I wrote a SAMPLE CODE - Hello.S to work for a cross-assembler mips-linux-as - but this is giving me an error message:
   ".data 
         quest: .asciiz "Hello World!"
    .text
    _start:
         la $a0, quest
         li $v0, 4
         syscall   "
       
The error messages are:
  " Hello.S line 5: illegal operands 'la' 
    Hello.S line 6: illegal operands 'li'"

Can anyone help? What is wrong?

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8
