Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IH26002087
	for linux-mips-outgoing; Tue, 18 Sep 2001 10:02:06 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IH22e02084
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 10:02:04 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id RAA02199;
	Tue, 18 Sep 2001 17:07:39 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id RAA28851; Tue, 18 Sep 2001 17:04:55 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id QAA21475; Tue, 18 Sep 2001 16:15:39 +0400 (MSD)
Message-ID: <3BA73B11.A522EBA9@niisi.msk.ru>
Date: Tue, 18 Sep 2001 16:16:17 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
References: <200109181034.f8IAYIe27614@oss.sgi.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:
>   BTW,is that current code has no support for different PCI & CPU
> address space?In p6032 default setting,PCI memory address 0 is
> CPU physical address 0x10000000,and main memory is 0-0x10000000
> for CPU,but 0x80000000-0x90000000 for pci. So I have to change
> ioremap,virt_to_bus & bus_to_virt. I think this problem should
> exist in many nonpc hw,could you point me a clean way?
> 

Change them.

Regards,
Gleb.
