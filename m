Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HBlQG31986
	for linux-mips-outgoing; Fri, 17 Aug 2001 04:47:26 -0700
Received: from dea.waldorf-gmbh.de (u-214-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.214])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HBlIj31971
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 04:47:18 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7HBjWn05335
	for linux-mips@oss.sgi.com; Fri, 17 Aug 2001 13:45:32 +0200
Received: from smtp.huawei.com (nszx104.121.szptt.net.cn [202.104.121.208] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7H3Bfj20266;
	Thu, 16 Aug 2001 20:11:41 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GI6Z6000.016; Fri, 17 Aug 2001 11:03:36 +0800 
Message-ID: <001501c126ca$4a5331a0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <000701c11c8b$77e039e0$8021690a@huawei.com> <20010804071016.A1275@bacchus.dhis.org>
Subject: Re: Where is the first entry point for linux-mips boot?
Date: Fri, 17 Aug 2001 11:11:21 +0800
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


----- Original Message -----
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "machael thailer" <dony.he@huawei.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Saturday, August 04, 2001 1:10 PM
Subject: Re: Where is the first entry point for linux-mips boot?


> On Sat, Aug 04, 2001 at 10:16:27AM +0800, machael thailer wrote:
>
> >     There are many many subdirectories in arch/mips, I don't know where
is
> > the FIRST entry point for embedded linux-mips boot process? I find that
> > there is "kernel_entry" in arch/mips/kernel/head.S. I know this is the
entry
> > point for linux kernel ,but it is not the FIRST entry point for embedded
> > linux-mips boot process. So my questions is :
> >     After the board initializations finish, it should load linux kernel
into
> > RAM and jump there .  Just before it runs the linux kernel, who calls
> > "kernel_entry"?
>
> The firmware or bootloader.

Another question:

After my custom board  finished initializations, It should load "linux
kernel" into RAM.
The question is :  Is this a compressed "linux kernel" just like vmlinux.gz
of X86 that I should load? Or is it "/usr/src/linux/vmlinux" that is not
compressed that I should load? And what RAM address should it loaded at?
Since it is linked at 0x80200000,Should I load there or at somewhere else?

Thanks very much.

machael
