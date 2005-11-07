Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 20:20:06 +0000 (GMT)
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42721 "HELO
	mustang.oldcity.dca.net") by ftp.linux-mips.org with SMTP
	id S8135578AbVKGUTr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Nov 2005 20:19:47 +0000
Received: (qmail 21909 invoked from network); 7 Nov 2005 20:20:59 -0000
Received: from unknown (HELO ?192.168.0.20?) (206.105.184.167)
  by mustang with SMTP; 7 Nov 2005 20:20:59 -0000
Subject: Re: [Alsa-devel] Au1550 OSS driver issues
From:	Lee Revell <rlrevell@joe-job.com>
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	Linux MIPS Development <linux-mips@linux-mips.org>,
	alsa-devel@lists.sourceforge.net, dan@embeddededge.com,
	Pete Popov <ppopov@embeddedalley.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>,
	Manish Lachwani <mlachwani@mvista.com>
In-Reply-To: <436FB1DE.6010405@ru.mvista.com>
References: <43452054.2090305@ru.mvista.com>
	 <436FB1DE.6010405@ru.mvista.com>
Content-Type: text/plain
Date:	Mon, 07 Nov 2005 15:19:14 -0500
Message-Id: <1131394755.8383.92.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Return-Path: <rlrevell@joe-job.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rlrevell@joe-job.com
Precedence: bulk
X-list: linux-mips

On Mon, 2005-11-07 at 22:58 +0300, Sergei Shtylylov wrote:
>          After having a look at sound/oss/au1000.c, here's an updated patch 
> that deals with "nested" spinlocks the same way that driver does, and adds 
> spinlock to start_adc() as well.

The OSS drivers are scheduled for removal, it's unlikely that this will
be accepted into the kernel.  It also has nothing to do with ALSA.

Lee
