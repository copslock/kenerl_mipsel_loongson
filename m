Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f745B2e14382
	for linux-mips-outgoing; Fri, 3 Aug 2001 22:11:02 -0700
Received: from dea.waldorf-gmbh.de (u-146-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f745AxV14378
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 22:10:59 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f745AGD02372;
	Sat, 4 Aug 2001 07:10:16 +0200
Date: Sat, 4 Aug 2001 07:10:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Where is the first entry point for linux-mips boot?
Message-ID: <20010804071016.A1275@bacchus.dhis.org>
References: <000701c11c8b$77e039e0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c11c8b$77e039e0$8021690a@huawei.com>; from dony.he@huawei.com on Sat, Aug 04, 2001 at 10:16:27AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Aug 04, 2001 at 10:16:27AM +0800, machael thailer wrote:

>     There are many many subdirectories in arch/mips, I don't know where is
> the FIRST entry point for embedded linux-mips boot process? I find that
> there is "kernel_entry" in arch/mips/kernel/head.S. I know this is the entry
> point for linux kernel ,but it is not the FIRST entry point for embedded
> linux-mips boot process. So my questions is :
>     After the board initializations finish, it should load linux kernel into
> RAM and jump there .  Just before it runs the linux kernel, who calls
> "kernel_entry"?

The firmware or bootloader.

  Ralf
