Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UEYQ905870
	for linux-mips-outgoing; Mon, 30 Jul 2001 07:34:26 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UEYOV05867
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 07:34:24 -0700
Message-Id: <200107301434.f6UEYOV05867@oss.sgi.com>
Received: (qmail 25215 invoked from network); 30 Jul 2001 14:29:31 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 30 Jul 2001 14:29:31 -0000
Date: Mon, 30 Jul 2001 22:37:14 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: "Kevin D. Kissell" <kevink@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re:/sbin/init problem in HH2.0 distro
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f6UEYOV05868
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,Kevin
  
2001-07-30 16:17:00£º
>Well, if you can run "passwd", can you run "nm"
>or some other utility to see if libc.so.6 does
>in fact define the symbol _sec0?
Yes,I can. And there is no such symbol,so I suspect the disk drive first
>
>            Kevin K.
>
>----- Original Message -----
>From: "Fuxin Zhang" <fxzhang@ict.ac.cn>
>To: <linux-mips@oss.sgi.com>
>Sent: Monday, July 30, 2001 3:48 PM
>
>
>> hello,linux-mips
>>     I am porting support of Algorithmics P6032 evalution board from
>> 2.2 kernel to 2.4. I started with the kernel 2.4.3 from hardhat2.0
>> distribution.Now I am able to boot the kernel but it hangs up when
>> trying to exec /sbin/init.The error message is something like:
>>    Init: Kernel panic: trying to kill init
>>    Init:error loading libc.so.6, undefined symbol _sec0
>>
>> But if i let the kernel execute /bin/ash.static directly,it can give me
>> a shell while complaining something like" no tty found,job control
>disabled". Then I can use most commands such as ls,passwd,cat.So the
>> libc.so.6 can't be a corrupted one.
>>
>>   The test environment is:
>>        Algorithmics P6032 with a idt79RC64474 CPU
>>        IDE hard disk(IBM Deskstar 40M,7200rpm)
>>   Kernel options:
>>        pci,ide(with/without dma,multimode) enabled
>>        serial console enabled
>>
>>   What can be the cause?
>>
>>   I suspect the ide driver first.But disabling dma doesn't help and it
>> seems to work quite well under ash.
>>
>>   I am investigating the cause,if you want,I can provide more
>> information.
>>
>>
>>
>>
>>
>> Regards
>>             Fuxin Zhang
>>             fxzhang@ict.ac.cn
>>

Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn
