Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 09:04:23 +0000 (GMT)
Received: from centurysys.co.jp ([125.206.128.231]:41231 "EHLO
	centurysys.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022088AbXCTJEW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 09:04:22 +0000
Received: from 125.206.128.231 (220x151x150x170.ap220.ftth.ucom.ne.jp [220.151.150.170])
	(authenticated bits=0)
	by centurysys.co.jp (8.13.6.20060614/8.13.6) with ESMTP id l2K931b3088391;
	Tue, 20 Mar 2007 18:03:02 +0900 (JST)
Message-Id: <200703200903.l2K931b3088391@centurysys.co.jp>
Date:	Tue, 20 Mar 2007 18:02:56 +0900
From:	Takeyoshi Kikuchi <kikuchi@centurysys.co.jp>
X-Mailer: EdMax Ver2.85.6F
MIME-Version: 1.0
To:	"Marco Braga" <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Re: Re: Au1500 and TI PCI1510 cardbus
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <d459bb380703200032s16993f87s89cd057d8b4ec2c6@mail.gmail.com>
References: <d459bb380703200032s16993f87s89cd057d8b4ec2c6@mail.gmail.com>
X-VSS-HEADER: SID:020; PID:24348; Tue, 20 Mar 2007 18:03:02 +0900 (JST)
Return-Path: <kikuchi@centurysys.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kikuchi@centurysys.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

"Marco Braga" <marco.braga@gmail.com> wrote:

>Hello!
>
>2007/3/20, Takeyoshi Kikuchi <kikuchi@centurysys.co.jp>:
>
>Our Au1500 board works fine with Ricoh CardBus Bridge and NEC USB
>> controller.
>> However, the board does not work stably with TI PCI1520 controller.
>
>
>As you have seen, we've experienced the same problem with the PCI1510. Can
>you please give me the exact product number of both the controllers you use
>(USB / Cardbus)? In particular your cardbus experience is interesting
>because from the informations I've received until now I tought that no
>cardbus controller could work on Au1500's PCI.
>
>Thanks!

The controllers are as follows:

Cardbus Bridge:
  Ricoh R5C486  (Vendor/Device 1180:0476)
USB Controller:
  NEC uPD720101 (CardBus) (Vendor/Device 1033:00e0)

Ali IEEE1394/USB Combo (Vendor/Device 10b9:5239) also works.

The combination of Au1500(MIPS32) and EHCI code has a problem: ll/sc 
always get locked when it manipulates an atomic variable in the EHCI 
descriptor (qh_get() in ehci-mem.c). 
We applied a patch that adds a function to lib/kref.c so that it doesn't
 use ll/sc.

Linux 2.6.20 has a problem in ioremap, so we replaced the code with one in 
2.6.19.


---------------------------------
Takeyoshi Kikuchi
