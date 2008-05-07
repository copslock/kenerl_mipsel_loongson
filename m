Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 08:09:56 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:13026 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20044702AbYEGHJy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 08:09:54 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4778vLt010021
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2008 00:08:59 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m4778r74017104;
	Wed, 7 May 2008 00:08:55 -0700
Date:	Wed, 7 May 2008 00:08:53 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Jean Delvare <khali@linux-fr.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Message-Id: <20080507000853.17f1316b.akpm@linux-foundation.org>
In-Reply-To: <20080507085953.2c08b854@hyperion.delvare>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
	<20080507085953.2c08b854@hyperion.delvare>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 May 2008 08:59:53 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> I'm not sure how you intend to push these changes upstream. I would
> take a patch only touching drivers/i2c/busses/i2c-sibyte.c in my i2c
> tree, however a patch also touching arch code, must be handled be the
> maintainer for that architecture or platform.

Not "must".  The arch maintainer could ask you to merge it or you could ask
the arch maintainer to merge it.

It's some little one-line change like this one appeared to be, it's
fair to assume the arch maintainer won't care much about it.  View it as an
i2c patch?
