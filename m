Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 00:15:42 +0000 (GMT)
Received: from savages.net ([IPv6:::ffff:12.154.202.18]:37118 "EHLO
	savages.net") by linux-mips.org with ESMTP id <S8225316AbUBEAPl>;
	Thu, 5 Feb 2004 00:15:41 +0000
Received: from savages.net (ws20.savages.net [::ffff:192.168.4.20])
  (TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by server with esmtp; Wed, 04 Feb 2004 16:15:37 -0800
Message-ID: <40218B29.8010803@savages.net>
Date: Wed, 04 Feb 2004 16:15:37 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prashant Viswanathan <vprashant@echelon.com>
CC: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: loading kernel via EJTAG interface
References: <5375D9FB1CC3994D9DCBC47C344EEB59383A14@miles.echelon.com>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB59383A14@miles.echelon.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <savages@savages.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savages@savages.net
Precedence: bulk
X-list: linux-mips

Prashant Viswanathan wrote:
> Hi, 
> 
> I am trying to load a linux kernel through a EJTAG device. I was told that I
> should modify the kernel so that it doesnt attempt to use the parameters
> passed to it by the loader. However, I am not quite sure as to what it means
> and what exactly one has to do. I would really appreciate any
> pointers/help/suggestions.
> 
> Thanks!
> Prashant
> 
> 
Ouch!  The best way would be to load a bootloader that knows about bootp 
and TFTP. Then do a network boot.

If you dont't have a ethernet connection on the board then in 
/arch/mips/kernel/head.S is where the loader  info is read into the kernel.

But I am sure there is a better way.

shaun
