Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0JNR6b12291
	for linux-mips-outgoing; Sat, 19 Jan 2002 15:27:06 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0JNR4P12287
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 15:27:04 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA00999;
	Sat, 19 Jan 2002 14:26:55 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA11693;
	Sat, 19 Jan 2002 14:26:53 -0800 (PST)
Message-ID: <003601c1a138$868fdc20$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "renc stone" <renwei@huawei.com>, <linux-mips@oss.sgi.com>
References: <025901c1a0c4$30ec20e0$3d6e0b0a@huawei.com>
Subject: Re: use float in no-fpu mips kernel modules?
Date: Sat, 19 Jan 2002 23:27:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>   Any one know how to use float point in mips kernel?
>   We use some 2.4.5 kernel, on idt mips 32334, which has no fpu, I think.
>   we want to use the float numbers like this:
>   float a = 87;
>   a * = 1.04;
>   Any kernel functions to do this? or how to compile it use soft fpu
> support?

The way I integrated the Algorithmics FPU emulaton
code into the kernel *used* to work for kernel FP.
Maybe someone has broken it since, and there may
well be situations where it was unsafe, but have you 
tried simply confuguring FPU emulation and running 
your code with it?

            Kevin K.
