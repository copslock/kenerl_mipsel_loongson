Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 08:56:29 +0000 (GMT)
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237]:18362 "HELO
	smtp102.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133718AbVLUI4L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 08:56:11 +0000
Received: (qmail 37599 invoked from network); 21 Dec 2005 08:57:13 -0000
Received: from unknown (HELO ?192.168.1.121?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 21 Dec 2005 08:57:13 -0000
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 21 Dec 2005 00:57:12 -0800
Message-Id: <1135155432.9009.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Wed, 2005-12-21 at 16:51 +0800, zhuzhenhua wrote:
> i want to compile a 2.6.14 kernel for mips 4kec, does someone compile
> the 2.6 kernel with self-build toolchain? 

Quite a few people have, I'm sure.

> how to select the gcc,
> gdb,glibc,linux head and binutils version?
> and where to get the guide doc?

If you have such questions, I would suggest you start by compiling and
booting your kernel with a toolchain and distribution that already
works. Build your own toolchain, if you must, later.

Pete
