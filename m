Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3918LC23012
	for linux-mips-outgoing; Sun, 8 Apr 2001 18:08:21 -0700
Received: from smtp.huawei.com ([202.96.135.132])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3918IM23009
	for <linux-mips@oss.sgi.com>; Sun, 8 Apr 2001 18:08:19 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GBI2YE00.T0D; Mon, 9 Apr 2001 09:03:50 +0800 
Message-ID: <001101c0c091$bdb1a220$8021690a@huawei.com>
From: "machael" <dony.he@huawei.com.cn>
To: "Quinn Jensen" <jensenq@Lineo.COM>, <linux-mips@oss.sgi.com>
References: <007e01c0bd70$9052b4a0$8021690a@huawei.com> <3ACDF3A1.4020109@Lineo.COM>
Subject: Re: Does Linux support RC32332 CPU now?
Date: Mon, 9 Apr 2001 09:09:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thank you, Quinn. I have downloaded your  patch.
I find that you use linux-sgi-20010307 in your patch file. Is this an
offcial release which I can find in ftp.kernel.org ?
Where can I download it?
Thank you very much.

machael


----- Original Message -----
From: "Quinn Jensen" <jensenq@Lineo.COM>
To: <linux-mips@oss.sgi.com>
Sent: Saturday, April 07, 2001 12:49 AM
Subject: Re: Does Linux support RC32332 CPU now?


> The IDT RC32332 is a subset of the RC32334, which
> a working port exists for.  I have submitted a
> patch to Ralf, but haven't seen it go into his tree
> yet.  The patch is available at
> http://www.zdomain.com/patch.sgi.idt
>
> Quinn
>
> owner-linux-mips@oss.sgi.com wrote:
>
>  > Hi, folks:
>  >
>  >      I am a newbie in linux-mips. I have questions to ask:
>  >
>  >      1   Does Linux support RC32332 CPU now?
>  >      2   I want to build my cross-compile environment  for MIPS target
on my
>  > X86 host. Are there any documents about how to implement it?
>  >
>  > Thank you very much.
>
>
