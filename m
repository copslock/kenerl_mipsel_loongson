Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g149s0D18077
	for linux-mips-outgoing; Mon, 4 Feb 2002 01:54:00 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g149rrA17976
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 01:53:56 -0800
Message-Id: <200202040953.g149rrA17976@oss.sgi.com>
Received: (qmail 2779 invoked from network); 4 Feb 2002 08:54:06 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 4 Feb 2002 08:54:06 -0000
Date: Mon, 4 Feb 2002 16:50:43 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "H . J . Lu" <hjl@lucon.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: SNaN & QNaN on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g149ruA18014
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


ÔÚ 2002-02-03 22:54:00 you wrote£º
>On Mon, Feb 04, 2002 at 02:22:48PM +0800, Zhang Fuxin wrote:
>> hi,
>> 
>> Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
>> optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
>> (maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
>>  say so.And experiments confirm this.
>> 
>> Should we correct it?
>
>Yes. Do you have a patch?
Not currently but I will have a try. glibc seems having the same problem.

>
>Thanks.
>
>
>H.J.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
