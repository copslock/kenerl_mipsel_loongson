Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1N4FMf30905
	for linux-mips-outgoing; Fri, 22 Feb 2002 20:15:22 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1N4FI930898
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 20:15:18 -0800
Message-Id: <200202230415.g1N4FI930898@oss.sgi.com>
Received: (qmail 13236 invoked from network); 23 Feb 2002 03:18:39 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 23 Feb 2002 03:18:39 -0000
Date: Sat, 23 Feb 2002 11:12:6 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "H . J . Lu" <hjl@lucon.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: pthread support in mipsel-linux
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

>
>Mutex is now implemented with spin lock by default. BTW, how many
>people have run "make check" on glibc compiled -mips1?
I did with glibc-2.2.4 natively compiled,no failure till libm-test
(i configured it by default,then it used -mips1?)


>
>H.J.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
