Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 21:57:28 +0100 (BST)
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:26373 "HELO
	mallaury.nerim.net") by ftp.linux-mips.org with SMTP
	id S8134095AbWFOU5U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jun 2006 21:57:20 +0100
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with SMTP id 347EA4F3B0;
	Thu, 15 Jun 2006 22:57:04 +0200 (CEST)
Date:	Thu, 15 Jun 2006 22:57:23 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: i2c-algo-ite and i2c-ite planned for removal
Message-Id: <20060615225723.012c82be.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi all,

I noticed today that we have an i2c bus driver named i2c-ite,
supposedly useful on some MIPS systems which have an ITE8172 chip,
which doesn't compile. It is based on an i2c algorithm driver named
i2c-algo-ite, which doesn't compile either, due to some changes made to
the i2c core which weren't properly reflected there. Going back trough
the versions, I found that the bus driver was previously named
i2c-adap-ite, and was introduced in 2.4.10. And I don't think it even
compiled back then either, as it uses a structure (iic_ite) which isn't
defined anywhere.

So basically we have two drivers in the kernel tree for 5 years or so,
which never were usable, and nobody seemed to care. It's about time to
get rid of these 1296 lines of code, don't you think? So, unless someone
volunteers to take care of these drivers, or otherwise has a very
strong reason to object, I'm going to delete them from the tree soon.

Thanks,
-- 
Jean Delvare
