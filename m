Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1O8H6E23250
	for linux-mips-outgoing; Sun, 24 Feb 2002 00:17:06 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1O8H2923246
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 00:17:02 -0800
Message-Id: <200202240817.g1O8H2923246@oss.sgi.com>
Received: (qmail 19959 invoked from network); 24 Feb 2002 07:20:38 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 24 Feb 2002 07:20:38 -0000
Date: Sun, 24 Feb 2002 15:13:50 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "H . J . Lu" <hjl@lucon.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: pthread support in mipsel-linux
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1O8H3923247
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

  finally i manage to compile glibc-2.2.5 with gcc-3.1(both from latest cvs,
with some patches for glibc),and 'make check' finish successfully after i 
comment out some math tests.

ÔÚ 2002-02-22 22:11:00 you wrote£º
>On Sat, Feb 23, 2002 at 11:12:06AM +0800, Zhang Fuxin wrote:
>> hi,
>> 
>> >
>> >Mutex is now implemented with spin lock by default. BTW, how many
>> >people have run "make check" on glibc compiled -mips1?
>> I did with glibc-2.2.4 natively compiled,no failure till libm-test
>
>The linuxthreads test comes after math.
>
>> (i configured it by default,then it used -mips1?)
>> 
>
>Yes. BTW, I found the ll/sc bug by doing "make check" on gcc 3.1 in
>CVS.
>
>
>H.J.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
