Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:44:18 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:45794 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491842AbZJMCoK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:44:10 +0200
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2hotq016767;
	Tue, 13 Oct 2009 11:43:57 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay31.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:43:57 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:43:56 +0900
Message-ID: <4AD3E974.8080200@necel.com>
Date:	Tue, 13 Oct 2009 11:44:04 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC] i2c-designware patches
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Hi Baruch and lists,

Here're various improvements / bug-fixing patches for DW I2C driver.
I'm working with v2.6.27-based kernel, but they must work fine with the
latest mainline kernel.

It's stil in RFC, and I'm working with it for some time.  Any comments
or suggestions are highly appreciated.  Then I'll respin and give it a
test, thanks.

Baruch, I'd say the base driver is in good shape enogh, so I'm having
a fun with modifing the driver.  Thanks for the initial work.

P.S. ARM and MIPS lists are Cc:ed as I believe there must be potential
users of this driver.


Shinya Kuribayashi (16):
      i2c-designware: Consolidate to use 32-bit word accesses
      i2c-designware: Don't use the IC_CLR_INTR register to clear interrupts
      i2c-designware: Use platform_get_irq helper
      i2c-designware: i2c_dw_read: Take "struct dw_i2c_dev" pointer
      i2c-designware: i2c_dw_xfer_msg: Take "struct dw_i2c_dev" pointer
      i2c-designware: Remove an useless local variable "num"
      i2c-designware: Set a clock name to DesignWare I2C clock source
      i2c-designware: Improve _HCNT/_LCNT calculation
      i2c-designware: i2c_dw_xfer_msg: Fix an i2c_msg search bug
      i2c-designware: Do dw_i2c_pump_msg's jobs in the interrutp handler
      i2c-designware: Set Tx/Rx FIFO threshold levels
      i2c-designware: Divide i2c_dw_xfer_msg into two functions
      i2c-designware: i2c_dw_xfer_msg: Introduce a local "buf" pointer
      i2c-designware: Deferred FIFO-data-counting variables initialization
      i2c-designware: i2c_dw_xfer_msg: Mark as completed on an error
      i2c-designware: Add I2C_FUNC_SMBUS_* bits

 drivers/i2c/busses/i2c-designware.c |  367 +++++++++++++++++++++++++----------
 1 files changed, 264 insertions(+), 103 deletions(-)

-- 
Shinya Kuribayashi
NEC Electronics
