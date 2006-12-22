Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2006 22:04:45 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:5490 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20043946AbWLVWEl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Dec 2006 22:04:41 +0000
Received: by ug-out-1314.google.com with SMTP id 40so3578020uga
        for <linux-mips@linux-mips.org>; Fri, 22 Dec 2006 14:04:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pc60rFlPIlzqIy9FOU+qwzz1Hx2zES56mpatxysJO1Qk+aQmRXxBJJ1lug5pksuHpRMipM16iD24m/5FXJP8r2UwtCZhzFuZ/o65QMEwBsrW+Oi4EFeGa+qGBr1bvWyH/NWrUNEe4kqw7aRRRERS9UITfw1PLHvaWkUhjReQ350=
Received: by 10.78.204.1 with SMTP id b1mr1624791hug.1166825081001;
        Fri, 22 Dec 2006 14:04:41 -0800 (PST)
Received: by 10.78.45.19 with HTTP; Fri, 22 Dec 2006 14:04:40 -0800 (PST)
Message-ID: <d31941710612221404t7a6a2b8cnec4854b872e089e9@mail.gmail.com>
Date:	Fri, 22 Dec 2006 15:04:40 -0700
From:	"Allan Young" <auriculatus@gmail.com>
To:	linux-mips@linux-mips.org
Subject: any hints for running linux on an old galileo ev-64120 eval board?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <auriculatus@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: auriculatus@gmail.com
Precedence: bulk
X-list: linux-mips

It would be great if I could get a few hints on how to get Linux
running on one of these old gt64120 based PCI eval cards from Galileo.
I know these cards are quite old and crufty but since I see evidence
of support in the kernel I thought I'd ask if anyone still uses the
ev-64120 support.

Currently I have an ev-64120 inserted into a passive PCI backplane and
have access to pmon over the serial port.

I expect that I should be able to cross compile the kernel, with the
ev-64120 board support enabled, and convert the resulting elf into
srec format for loading via pmon (ouch).  However, I'm not sure what
to do for providing a root filesystem or even how one should specify
kernel command line parameters.

I'm wondering if it's feasible to put a supported NIC in the PCI
passive backplane with the ev-64120 and provide a suitable root file
system over a network connection?  I'm not aware if the linux kernel
can perform the PCI configuration (setting up the PCI base address
registers etc).

Any way, if anyone has gone down this ev-64120 path I'd greatly
appreciate hearing any suggestions, even if they are along the lines
of "abandon all hope". :)

Thanks,
Allan
