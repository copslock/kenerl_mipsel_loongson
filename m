Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HCAFf32580
	for linux-mips-outgoing; Fri, 17 Aug 2001 05:10:15 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HCA3j32576
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 05:10:03 -0700
Received: from dea.waldorf-gmbh.de (u-214-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.214]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA05007
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 05:09:48 -0700 (PDT)
	mail_from (ralf@dea.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7HBjiB05343
	for linux-mips@oss.sgi.com; Fri, 17 Aug 2001 13:45:44 +0200
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HAGFj29642;
	Fri, 17 Aug 2001 03:16:15 -0700
Received: from smtp.huawei.com ([202.104.121.208]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA27269; Fri, 17 Aug 2001 03:15:49 -0700 (PDT)
	mail_from (dony.he@huawei.com)
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GI7IJE03.A2S; Fri, 17 Aug 2001 18:02:02 +0800 
Message-ID: <000901c12704$bf95c2e0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <000701c11c8b$77e039e0$8021690a@huawei.com> <20010804071016.A1275@bacchus.dhis.org> <001501c126ca$4a5331a0$8021690a@huawei.com> <20010817052635.A2931@bacchus.dhis.org>
Subject: Re: Where is the first entry point for linux-mips boot?
Date: Fri, 17 Aug 2001 18:09:48 +0800
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
Sent: Friday, August 17, 2001 11:26 AM
Subject: Re: Where is the first entry point for linux-mips boot?


> On Fri, Aug 17, 2001 at 11:11:21AM +0800, machael thailer wrote:
>
> > After my custom board  finished initializations, It should load "linux
> > kernel" into RAM.
> > The question is :  Is this a compressed "linux kernel" just like
vmlinux.gz
> > of X86 that I should load? Or is it "/usr/src/linux/vmlinux" that is not
> > compressed that I should load?
>
> The standard MIPS kernel doesn't support compressed kernels on MIPS.
>
> > And what RAM address should it loaded at?  Since it is linked at
> > 0x80200000,Should I load there or at somewhere else?
>
> Obviously to the address it's linked for.  You can adjust that address
> as you need.  With compressed kernels it may be necessary to choose a
> different address however so the decompressed kernel doesn't overwrite
> the compressed kernel during compression.

If I load the kernel to RAM address 0x80200000, is this a virtual address or
physical address at this time? Since my RAM can not be so large, I guess
this is virtual address,right? Should I enable MMU in my board
initializations?


Thank you once again.

machael
