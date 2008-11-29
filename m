Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Nov 2008 04:42:45 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.158]:65018 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S23981166AbYK2Emf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Nov 2008 04:42:35 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1149518fga.32
        for <linux-mips@linux-mips.org>; Fri, 28 Nov 2008 20:42:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=90NnJesHb7cJOOXoDJTA695VZcBFQ7zuzOFaEYbOVw4=;
        b=FBMSPKkr0Gdkidl2XRzX9eFf+jnAi/JvV0LZV6ShkDAWu5D9QfZOu8rsWwyTks9kSE
         mKqG7tWqfBfGnXQZqouppO+mx7ZIp/ZMBmeUkI8FGK5j7ksNSjZ67RuNog0UymD9EfjY
         RcH4TUDsZtbJVpHGsgaZL1atTqzkghHXJCI/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=S8LvC/o2S+J1mYPqPeWyEo0BaWQ0vW/efN0VW+hVxqaR3jb0LoLN4RctS1fno9RJ31
         M1AyeOU8IGeMisUPqSsRHIAokLutIhwmDiNgUNVuR3bRQt7Hvhz0+Ky0tzoT4zDu+pAP
         v6ZKCnsEYEUwVqTIWfOBTyY2ow1xM9lK04Hs0=
Received: by 10.181.48.4 with SMTP id a4mr3013865bkk.59.1227933753691;
        Fri, 28 Nov 2008 20:42:33 -0800 (PST)
Received: by 10.180.231.13 with HTTP; Fri, 28 Nov 2008 20:42:33 -0800 (PST)
Message-ID: <5c9cd53b0811282042w677979bawc692d3ffbbe6686b@mail.gmail.com>
Date:	Fri, 28 Nov 2008 20:42:33 -0800
From:	"mike zheng" <mail4mz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How to start Linux kernel on MIPS32
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <mail4mz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mail4mz@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am doing development on a MIPS32 processor. However it failed to
boot when I try to use a boot loader to start the kernel in the
memory. The boot loader uses following command to jump to kernel entry
point in the memory:
         entryPoint = (void *) 0x8036a000;
         entryPoint();
I confirm the kernel image is able to boot up. Using JTAG debugger. I
set PC to the entry point of memory 0x8036a000, the kernel boots up. I
also disable the Cache before the jump.

Any idea on this issue?

Thanks,

Mike
