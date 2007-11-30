Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2007 01:51:43 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:41001 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S28577473AbXK3Bvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2007 01:51:35 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problem in the usage of mmap command(in directFB)
Date:	Thu, 29 Nov 2007 17:51:26 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C552E3F4@exchange.ZeugmaSystems.local>
In-Reply-To: <eea8a9c90711282148g67ec85e0q9decd3e0e1f4325f@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem in the usage of mmap command(in directFB)
Thread-Index: AcgyS8v5FiRvVoKyQbWDSyssetYbmgApcpzA
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"kaka" <share.kt@gmail.com>, <linux-mips@linux-mips.org>,
	<uclinux-dev@uclinux.org>, <celinux-dev@tree.celinuxforum.org>,
	<linux-fbdev-users@lists.sourceforge.net>
Cc:	<directfb-users@directfb.org>, <directfb-dev@directfb.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Dear Aptly-Named User, 

The first clue you need to get is that you shouldn't send MIME-encoded,
HTML crap to open source mailing lists. 

Repeatedly sending the same question to half a dozen mailing lists won't
solve your problem. (Everyone heard you the first N times already, and
it's unlikely that anyone new signed up within the last week who can
magically fix the failing mmap cll for you.

You have a 100% reproducible problem: no timing dependencies or race
conditions. Everytime you make the call with more than a certain size,
you nicely get this predictable EINVAL result. 

You have the source code to everything; you can add debug printk calls
anywhere you want and rebuild the kernel. If there are multiple places
that can produce an -EINVAL return value, you can precisely identify
which one is doing it.

Golly, gee, lucky you! This is like the software equivalent of taking a
shot against a wide-open net: just kick the ball!

What is missing?
