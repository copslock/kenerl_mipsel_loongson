Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g147k4Q23049
	for linux-mips-outgoing; Sun, 3 Feb 2002 23:46:04 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g147k0A23002
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 23:46:01 -0800
Message-Id: <200202040746.g147k0A23002@oss.sgi.com>
Received: (qmail 19041 invoked from network); 4 Feb 2002 06:26:07 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 4 Feb 2002 06:26:07 -0000
Date: Mon, 4 Feb 2002 14:22:48 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: SNaN & QNaN on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
(maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
 say so.And experiments confirm this.

Should we correct it?

>
>Regards
>            Zhang Fuxin
>            fxzhang@ict.ac.cn

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
