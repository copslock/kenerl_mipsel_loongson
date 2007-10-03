Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 20:19:02 +0100 (BST)
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:32019 "EHLO
	mailrelay004.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S20025638AbXJCTSy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 20:18:54 +0100
Received: from 226.218-64-87.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([87.64.218.226])
  by mailrelay004.isp.belgacom.be with ESMTP; 03 Oct 2007 21:18:45 +0200
Received: from 226.218-64-87.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([87.64.218.226])
  by mailrelay004.isp.belgacom.be with ESMTP; 03 Oct 2007 21:18:45 +0200
Received: from 226.218-64-87.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([87.64.218.226])
  by mailrelay004.isp.belgacom.be with ESMTP; 03 Oct 2007 21:18:45 +0200
Received: from 226.218-64-87.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([87.64.218.226])
  by mailrelay004.isp.belgacom.be with ESMTP; 03 Oct 2007 21:18:45 +0200
X-Belgacom-Dynamic: yes
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.8/8.12.11) with ESMTP id l93JOKqh007629;
	Wed, 3 Oct 2007 21:24:20 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.8/8.13.8/Submit) id l93JOEuF007627;
	Wed, 3 Oct 2007 21:24:14 +0200
Date:	Wed, 3 Oct 2007 21:24:14 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Message-ID: <20071003192414.GA7543@infomag.infomag.iguana.be>
References: <200709201728.10866.technoboy85@gmail.com> <200709201806.41942.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709201806.41942.technoboy85@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Matteo,

Sorry for the late response. Some personal/work issues
prevented me in reacting faster.

> +static int ar7_wdt_open(struct inode *inode, struct file *file)
> +{
> +	/* only allow one at a time */
> +	if (down_trylock(&open_semaphore))
> +		return -EBUSY;
> +	ar7_wdt_enable_wdt();
> +	expect_close = 0;
> +
> +	return 0;
> +}

The /dev/watchdog device is a VFS (Virtual File System). We thus
use a: return nonseekable_open(inode, file);

> +static ssize_t ar7_wdt_write(struct file *file, const char *data,
> +			     size_t len, loff_t *ppos)
> +{
> +	if (*ppos != file->f_pos)
> +		return -ESPIPE;
> +

Since we use the nonseekable_open we don't need the
 if (*ppos != file->f_pos) return -ESPIPE;

> +static int __init ar7_wdt_init(void)
> +{
...
> +	rc = misc_register(&ar7_wdt_miscdev);
> +	if (rc) {
> +		printk(KERN_ERR DRVNAME ": unable to register misc device\n");
> +		goto out_alloc;
> +	}
> +
> +	rc = register_reboot_notifier(&ar7_wdt_notifier);
> +	if (rc) {
> +		printk(KERN_ERR DRVNAME
> +			": unable to register reboot notifier\n");
> +		goto out_register;
> +	}
> +	goto out;
> +
> +out_register:
> +	misc_deregister(&ar7_wdt_miscdev);
> +out_alloc:
> +	release_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt));
> +out:
> +	return rc;
> +}

It's better to first register the reboot-notifier instead of
registering the misc-device. The misc-device gives userspace
allready access to the device and that's something that you
want to do as the last action to prevent problems.

For the rest: all OK.

If you want I'll add it to the linux-2.6-watchdog-mm tree with
the above mentioned changes.

Greetings,
Wim.
