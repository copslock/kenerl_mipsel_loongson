Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2009 09:35:34 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:43739 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366511AbZCGJfb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Mar 2009 09:35:31 +0000
Received: (qmail 20058 invoked from network); 7 Mar 2009 10:35:30 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 7 Mar 2009 10:35:30 +0100
Date:	Sat, 7 Mar 2009 10:35:29 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH 07/10] Alchemy: SMSC 9210 Ethernet support
Message-ID: <20090307103529.23c36da0@scarran.roarinelk.net>
In-Reply-To: <df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	<788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	<0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	<7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
	<0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
	<394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
	<7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
	<df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri,  6 Mar 2009 10:20:06 -0600
Kevin Hickey <khickey@rmicorp.com> wrote:

> This patch adds support for the SMSC 9210 Ethernet chip, specialized for
> Alchemy platforms (including the DB1300).  The ethernet driver code was
> provided by SMSC; the platform shim by RMI.
> 
> Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
> ---
>  drivers/net/Kconfig                     |    6 +
>  drivers/net/Makefile                    |    3 +
>  drivers/net/smsc9210/Makefile           |    9 +
>  drivers/net/smsc9210/ioctl_118.h        |  298 ++
>  drivers/net/smsc9210/platform_alchemy.c |   88 +
>  drivers/net/smsc9210/platform_alchemy.h |  117 +
>  drivers/net/smsc9210/smsc9210.h         |   23 +
>  drivers/net/smsc9210/smsc9210_main.c    | 7189 +++++++++++++++++++++++++++++++

What's wrong with the in-kernel smsc911x.c driver?  It can handle the
9210 just fine (we use it on an ARM board).

Best regards,
	Manuel Lauss
