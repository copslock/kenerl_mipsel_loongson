Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 21:41:16 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:57491 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S20039087AbYBGVlH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 21:41:07 +0000
Received: (qmail 3879 invoked from network); 7 Feb 2008 21:41:05 -0000
Received: from unknown (HELO ?10.41.13.129?) (38.101.235.133)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 7 Feb 2008 14:41:05 -0700
Subject: RE: iomemory causing a data bus error
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Don Hiatt <DHiatt@zeugmasystems.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C57986CE@exchange.ZeugmaSystems.local>
References: <1202397602.3298.25.camel@localhost>
	 <1202416377.3298.44.camel@localhost>
	 <DDFD17CC94A9BD49A82147DDF7D545C57986B1@exchange.ZeugmaSystems.local>
	 <1202418072.3298.49.camel@localhost>
	 <DDFD17CC94A9BD49A82147DDF7D545C57986CE@exchange.ZeugmaSystems.local>
Content-Type: text/plain
Date:	Thu, 07 Feb 2008 16:40:34 -0500
Message-Id: <1202420434.3298.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

> For ERR: http://lkml.org/lkml/2005/1/12/356

Thanks, I read through that. Seems like I could be dealing with some
imperfect hardware.

Whether or no my device is plugged into the box, I get an order of
magnitude of 10^4 ERRs. Does this seem like a huge amount to anyone
else?

Is there anything I can do to try to reduce this number? Or should I
even worry about it? Could this be connected to the device driver issues
I am having?

Thanks,
Jon
