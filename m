Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2009 19:06:24 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:51468 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366793AbZCGTGW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2009 19:06:22 +0000
Received: from 10.8.0.23 ([10.8.0.23]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Sat,  7 Mar 2009 19:06:15 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 07 Mar 2009 13:06:15 -0600
Subject: Re: [PATCH 07/10] Alchemy: SMSC 9210 Ethernet support
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20090307103529.23c36da0@scarran.roarinelk.net>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
	 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
	 <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
	 <7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
	 <df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
	 <20090307103529.23c36da0@scarran.roarinelk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 07 Mar 2009 13:06:05 -0600
Message-Id: <1236452765.9848.3.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-03-07 at 10:35 +0100, Manuel Lauss wrote:
> On Fri,  6 Mar 2009 10:20:06 -0600
> Kevin Hickey <khickey@rmicorp.com> wrote:
> 
> > This patch adds support for the SMSC 9210 Ethernet chip, specialized for
> > Alchemy platforms (including the DB1300).  The ethernet driver code was
> > provided by SMSC; the platform shim by RMI.

> What's wrong with the in-kernel smsc911x.c driver?  It can handle the
> 9210 just fine (we use it on an ARM board).

I was unaware that smsc911x.c could handle 9210.  I'll try it out
sometime and if it works then we can drop this one.

=Kevin
-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
