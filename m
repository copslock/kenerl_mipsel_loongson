Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2005 00:06:10 +0000 (GMT)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.192]:42053 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225331AbVBJAFx>;
	Thu, 10 Feb 2005 00:05:53 +0000
Received: by rproxy.gmail.com with SMTP id 40so166995rnz
        for <linux-mips@linux-mips.org>; Wed, 09 Feb 2005 16:05:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=pRKAdqz70H4r2quUY1f7MFTHJwjxZ1Ab6QaxZUH/8GbQCJPUcSa+j5ikosMxaoF+Lr66X+qRDlGOVl/D75jz/5MY2IagXr1ZsO6PClt715ePexqy6ykTePfdf8gojNku5ZkBMkcGVmnP84BjIIj/CobVTKQoGCP/qjVK4INWDok=
Received: by 10.38.179.61 with SMTP id b61mr26672rnf;
        Wed, 09 Feb 2005 16:05:40 -0800 (PST)
Received: by 10.38.179.17 with HTTP; Wed, 9 Feb 2005 16:05:40 -0800 (PST)
Message-ID: <52dd17640502091605ba90f08@mail.gmail.com>
Date:	Wed, 9 Feb 2005 18:05:40 -0600
From:	Guy Streeter <guy.streeter@gmail.com>
Reply-To: Guy Streeter <guy.streeter@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: interrupt problems with USB on malta 4kc
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <guy.streeter@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guy.streeter@gmail.com
Precedence: bulk
X-list: linux-mips

 I am trying to use USB devices on a 4kc malta board. I see no
problems from USB unless a device (any device, apparently) is plugged
in to a USB port. After that, interrupts stop working (for everything,
not just USB, as far as I can tell). I jave seen this on 2.6.8.1,
2.6.10, and 2.6.11-rc2.
 I have traced this down to the point where the mips_pcibios_iack
routine sometimes gets an irq value of 0xFF. I put in a BUG_ON that
condition, and it looks to me as though interrupts are happening
during the interrupt service routine. I am attaching the backtrace
below. Does this look familiar to anyone?

thanks,
--Guy

backtrace from mips_pcibios_iack() when irq == 0xFF (2.6.10 kernel
from mips.org CVS):

Call Trace:
 [<801008a8>] mipsIRQ+0x128/0x180
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<80126ba0>] do_softirq+0x8c/0xb8
 [<801069ac>] timer_interrupt+0x128/0x270
 [<80126a20>] __do_softirq+0x50/0x144
 [<80126ba0>] do_softirq+0x8c/0xb8
 [<80106b34>] ll_timer_interrupt+0x40/0x4c
 [<80100890>] mipsIRQ+0x110/0x180
 [<80100f64>] malta_hw0_irqdispatch+0x1e4/0x20c
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80102040>] handle_bp_int+0x18/0x38
 [<802b70e8>] skb_read_and_csum_bits+0x0/0xb4
 [<8012b3b0>] upate_process_times+0xe4/0x14c
 [<80100f64>] malta_hw0_irqdispatch+0x1e4/0x20c
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<80106b34>] ll_timer_interrupt+0x40/0x4c
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80106b34>] ll_timer_interrupt+0x40/0x4c
 [<80100f80>] malta_hw0_irqdispatch+0x200/0x20c
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80100f64>] malta_hw0_irqdispatch+0x1e4/0x20c
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<8014be14>] cache_fee_debugcheck+0x258/0x2d4
 [<8014bde4>] cache_free_debugcheck+0x228/0x2d
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80102040>] handle_bp_int+0x18/0x38
 [<8024ef48>] kfree_skbmem+0x14/0x30
 [<80100f64>] malta_hw0_irqdispatch+0x1e4/0x20c
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<8011cef4>] tr_to_wake_up+0x84/0x178
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80100f80>] malta_hw0_irqdispatch+0x200/0x20c
 [<8011dcf8>] __wake_up_common+0x68/0xb8
 [<8024e358>] alloc_skb+0x58/0xf4
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80240000>] usb_rmove_sysfs_dev_files+0xac/0xe0
 [<80100f64>] malta_hw0_rqdispatch+0x1e4/0x20c
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<801008a8>] mipsIRQ+0x128/0x180
 [<c0046300>] init_stall_timer+0x50/0x60 [uhci_hcd]
 [<80102040>] handle_bp_int+0x18/0x38
 [<8011cef4>] try_to_wake_up+0x84/0x178
 [<80100f64>] malta_hw0_irqdispatch+0x1e4/0x0c
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80100f80>] malta_hw0_irqdispatch+0x2000x20c
 [<80126ba0>] do_softirq+0x8c/0xb8
 [<80106b34>] ll_timer_interrupt+0x40/0x4c
 [<801008a8>] mipsIRQ+0x128/0x180
 [<80100890>] mipsIRQ+0x110/0x180
 [<801011ec>] r4k_wait+0x0/0xc
 [<8023b398>] hcd_submit_urb+0x0/0x898
 [<80102c44>] cpu_idle+0x3c/0x60
 [<801011f0>] r4k_wait+0x4/0xc
 [<8010041c>] rest_init+0x1c/0x28
 [<80122064>] printk+0x2c/0x38
 [<8032d96c>] start_kernel+0x1bc/0x264
 [<8032d95c>] start_kernel+0x1ac/0x264
 [<8032d30c>] unknown_bootoption+0x0/0x304
