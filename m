Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 04:17:49 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.195]:43962 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8126552AbWAXER0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 04:17:26 +0000
Received: by uproxy.gmail.com with SMTP id e2so154583ugf
        for <linux-mips@linux-mips.org>; Mon, 23 Jan 2006 20:21:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KjzYDfxSPoRrRfSn5cYptg8BoDz+cfbKxrpg9S9aj19eBteTViBSH9FPAtMKI/L6CJT42BRcODroHoI2CvR5hwsDH2g9ffGAiDgLWKzGdSCnWoa0qHSSwwJ4QdVKRn15+XOwplgSLmPyK+hdEe0GjzESSybAvQuiQ1Xbk7WxGvY=
Received: by 10.49.40.5 with SMTP id s5mr403867nfj;
        Mon, 23 Jan 2006 20:21:42 -0800 (PST)
Received: by 10.48.243.16 with HTTP; Mon, 23 Jan 2006 20:21:42 -0800 (PST)
Message-ID: <38dc7fce0601232021k2bc19c6em7b6cbee627b3df40@mail.gmail.com>
Date:	Tue, 24 Jan 2006 13:21:42 +0900
From:	Youngduk Goo <ydgoo9@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Au1200 IDE Interface (interrupt) error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

I got the below error message.
=======================================
Au1xxx IDE(builtin) configured for PIO+DDMA(offload)
hda: FUJITSU MHT2020AT, ATA DISK drive
hda: setting Au1XXX IDE to PIO mode4
ide0 at 0xb8800000-0xb8800007,0xb88001c0 on irq 64
hda: max request size: 64KiB
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63
hda: lost interrupt
hda: lost interrupt
 hda:<4>hda: lost interrupt
 hda1 hda2
hda: lost interrupt
==========================================
Our board is based on the Au1200 and we use the Compact Flash as a HDD.
It looks the hdd identified but the interrupt config is bad.
The base address looks fine but don't understand
why the irq number is 64.

I am not sure how can I set this. Please help me,
Thanks,.
