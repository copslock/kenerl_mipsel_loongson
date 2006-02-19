Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 23:36:44 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:22797 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133603AbWBSXge (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 23:36:34 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E9E6264D3D; Sun, 19 Feb 2006 23:43:26 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B2FDF8D5D; Sun, 19 Feb 2006 23:43:18 +0000 (GMT)
Date:	Sun, 19 Feb 2006 23:43:18 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	stevel@mvista.com, wyldfier@iname.com, lachwani@pmc-sierra.com,
	dan@embeddededge.com, johuang@siliconmotion.com
Subject: Diff between Linus' and linux-mips git: drivers!
Message-ID: <20060219234318.GA16311@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I just did a diff between the git trees of Linus and linux-mips and
noticed that there's a large number of drivers in the MIPS tree which
are not in mainline.  I think these are still from the days when Ralf
would apply MIPS related drivers to his tree instead of telling people
to talk to the respective sub-system maintainers (like he does now).

We should find out whether these drivers are still needed, and if so,
send them to the appropriate sub-system maintainer.  If they're no
longer useful, they should be removed from the linux-mips tree.


 drivers/char/au1000_gpio.c                 |  266 +++
 drivers/char/au1000_ts.c                   |  677 +++++++++
 drivers/char/au1000_usbraw.c               |  573 ++++++++
 drivers/char/au1000_usbtty.c               |  761 ++++++++++
stevel@mvista.com

 drivers/char/ibm_workpad_keymap.map        |  343 ++++
Michael Klar <wyldfier@iname.com>

 drivers/char/sb1250_duart.c                |  911 ++++++++++++
BCM (I think they wanted to rewrite this?  Mark?)

 drivers/net/big_sur_ge.c                   | 2005 ++++++++++++++++++++++++++++
 drivers/net/big_sur_ge.h                   |  713 +++++++++
Manish Lachwani <lachwani@pmc-sierra.com>

 drivers/net/titan_ge.c                     | 2071 +++++++++++++++++++++++++++++
 drivers/net/titan_ge.h                     |  419 +++++
 drivers/net/titan_mdio.c                   |  217 +++
 drivers/net/titan_mdio.h                   |   56 
Manish Lachwani <lachwani@pmc-sierra.com>
(I thought most of this stuff was in mainline; do we have two copies
under different names?)

 drivers/net/gt64240eth.c                   | 1672 +++++++++++++++++++++++
 drivers/net/gt64240eth.h                   |   10 
stevel@mvista.com

 drivers/serial/ip3106_uart.c               |  912 ++++++++++++
 include/linux/serial_ip3106.h              |   12 
Per Hallsmark per.hallsmark@mvista.com

 drivers/video/au1200fb.c                   | 1940 +++++++++++++++++++++++++++
 drivers/video/au1200fb.h                   |  288 ++++
AMD (?)

 drivers/video/smivgxfb.c                   |  387 +++++
johuang@siliconmotion.com

 sound/oss/au1550_i2s.c                     | 2029 ++++++++++++++++++++++++++++
dan@embeddededge.com"

 drivers/usb/host/ohci-pnx8550.c            |  277 +++
dan@embeddededge.com"

-- 
Martin Michlmayr
http://www.cyrius.com/
