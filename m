Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IHZel03248
	for linux-mips-outgoing; Tue, 18 Sep 2001 10:35:40 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IHZbe03245
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 10:35:38 -0700
Message-Id: <200109181735.f8IHZbe03245@oss.sgi.com>
Received: (qmail 32668 invoked from network); 18 Sep 2001 17:29:48 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 18 Sep 2001 17:29:48 -0000
Date: Wed, 19 Sep 2001 1:34:56 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re:different PCI & CPU address space
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8IHZce03246
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Gleb O. Raiko£¬
      Do you mean change p6032 setting or change those interfaces?
To make more drivers and userland apps like X happy,it seems better
to make both address space consistent.And since current code seems to
assume same CPU & PCI space,this may make Ralf happy if someday he
accept the code:). Just that I am not sure the setting can be freely 
changed.Will try later.


ÔÚ 2001-09-18 16:16:00 you wrote£º
>Zhang Fuxin wrote:
>>   BTW,is that current code has no support for different PCI & CPU
>> address space?In p6032 default setting,PCI memory address 0 is
>> CPU physical address 0x10000000,and main memory is 0-0x10000000
>> for CPU,but 0x80000000-0x90000000 for pci. So I have to change
>> ioremap,virt_to_bus & bus_to_virt. I think this problem should
>> exist in many nonpc hw,could you point me a clean way?
>> 
>
>Change them.
>
>Regards,
>Gleb.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
