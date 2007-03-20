Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 02:06:19 +0000 (GMT)
Received: from centurysys.co.jp ([125.206.128.231]:36619 "EHLO
	centurysys.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022473AbXCTCFx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 02:05:53 +0000
Received: from 125.206.128.231 (220x151x150x170.ap220.ftth.ucom.ne.jp [220.151.150.170])
	(authenticated bits=0)
	by centurysys.co.jp (8.13.6.20060614/8.13.6) with ESMTP id l2K24WgH020041;
	Tue, 20 Mar 2007 11:04:33 +0900 (JST)
Message-Id: <200703200204.l2K24WgH020041@centurysys.co.jp>
Date:	Tue, 20 Mar 2007 11:04:27 +0900
From:	Takeyoshi Kikuchi <kikuchi@centurysys.co.jp>
X-Mailer: EdMax Ver2.85.6F
MIME-Version: 1.0
To:	"Marco Braga" <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Re: Au1500 and TI PCI1510 cardbus
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
X-VSS-HEADER: SID:005; PID:2743; Tue, 20 Mar 2007 11:04:33 +0900 (JST)
Return-Path: <kikuchi@centurysys.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kikuchi@centurysys.co.jp
Precedence: bulk
X-list: linux-mips

Hello.

"Marco Braga" <marco.braga@gmail.com> wrote:

>Hi,
>
>we need PCI so Au15xx is our only choice. Internal USB 1.1 is working well,
>but what about adding a PCI to USB controller? Has anyone tried this?
>
>Regards,
>Marco

Our Au1500 board works fine with Ricoh CardBus Bridge and NEC USB 
controller.
However, the board does not work stably with TI PCI1520 controller.

~# lspci 
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 82)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 82)
00:0b.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)
05:00.0 USB Controller: NEC Corporation USB (rev 43)
05:00.1 USB Controller: NEC Corporation USB (rev 43)
05:00.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

-- log --
usb 4-1: USB disconnect, address 3
usb 4-1: new high speed USB device using ehci_hcd and address 4
usb 4-1: configuration #1 chosen from 1 choice
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: USB 2.0   Model: Flash Disk        Rev: 1100
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 8093696 512-byte hdwr sectors (4144 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
SCSI device sda: 8093696 512-byte hdwr sectors (4144 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
 sda: sda1
sd 2:0:0:0: Attached scsi removable disk sda

~# dd if=/dev/sda of=/dev/null bs=1048576 count=64
64+0 records in
64+0 records out
67108864 bytes (67 MB) copied, 5.04437 seconds, 13.3 MB/s

~# cat /proc/cpuinfo 
system type             : Century Systems MA420
processor               : 0
cpu model               : Au1500 V0.2
BogoMIPS                : 395.26
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes
ASEs implemented        :
VCED exceptions         : not available
VCEI exceptions         : not available

~# uname -a
Linux MA-420 2.6.18.5 #6 PREEMPT Tue Mar 20 10:22:01 JST 2007 mips GNU/Linux


---------------------------------
Takeyoshi Kikuchi
