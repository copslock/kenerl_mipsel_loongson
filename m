Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 15:03:31 +0000 (GMT)
Received: from xes-inc.com ([IPv6:::ffff:24.196.136.110]:11410 "EHLO
	xes-inc.com") by linux-mips.org with ESMTP id <S8225272AbULOPD0>;
	Wed, 15 Dec 2004 15:03:26 +0000
Received: from matts ([10.52.0.13])
	by xes-inc.com (8.11.6/8.11.6) with SMTP id iBFF2pi13189;
	Wed, 15 Dec 2004 09:02:54 -0600
Message-ID: <064501c4e2b7$2591c820$0d00340a@matts>
From: "Matthew Starzewski" <mstarzewski@xes-inc.com>
To: "Thomas Petazzoni" <thomas.petazzoni@enix.org>
Cc: <linux-mips@linux-mips.org>
References: <062301c4de41$5bf43cb0$0d00340a@matts> <41B96281.2050806@enix.org> <073a01c4dec7$184527a0$0d00340a@matts> <41B9CA72.7030208@enix.org>
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode, revisited
Date: Wed, 15 Dec 2004 09:02:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <mstarzewski@xes-inc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mstarzewski@xes-inc.com
Precedence: bulk
X-list: linux-mips

> This may be an ancillary effect of what's mentioned above, but when
num_physpages
> grows in size, nr_free_pages doesn't track with it, so in void
vfs_caches_init(unsigned long
> mempages) and the like, you get a horrible underflow condition:
>
> /* code */
>        printk("MJS - nr_free_pages():0x%X\n", nr_free_pages());
>        printk("MJS - OLD mempages:0x%X\n", mempages);
>        reserve = (mempages - nr_free_pages()) * 3/2;
>        mempages -= reserve;
>        printk("MJS - NEW reserve:0x%X mempages:0x%X\n",
>               reserve, mempages);
>
> /* printout */
> MJS - nr_free_pages():0x1E9A0
> MJS - OLD mempages:0x90000
> MJS - NEW reserve:0xAA190 mempages:0xFFFE5E70

I thought I'd wrap up this thread, especially with the HIGHMEM thread still
going around:

http://www.linux-mips.org/archives/linux-mips/2004-12/msg00141.html

The above underflow *was* my problem.  I was working in 2.6.6-rc3 before;
with the patch below from 2.6.7-rc1 everything works fine.

#  VFS cache sizing fix for small machines
http://linux.bkbits.net:8080/linux-2.6/diffs/fs/dcache.c@1.81?nav=index.html
|src/|src/fs|hist/fs/dcache.c
# BitKeeper ChangeSet
http://linux.bkbits.net:8080/linux-2.6/cset@1.1717.23.50?nav=index.html|src/
|src/fs|related/fs/dcache.c

In fs/dcache.c, vfs_caches_init():
<  reserve = (mempages - nr_free_pages()) * 3/2;
> reserve = min((mempages - nr_free_pages()) * 3/2, mempages - 1);

Regards,
Matt


----- Original Message -----
From: "Thomas Petazzoni" <thomas.petazzoni@enix.org>
To: "Matthew Starzewski" <mstarzewski@xes-inc.com>
Cc: <linux-mips@linux-mips.org>
Sent: Friday, December 10, 2004 10:10 AM
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode,
revisited
