Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 17:23:28 +0000 (GMT)
Received: from moutvdom.kundenserver.de ([IPv6:::ffff:212.227.126.251]:28879
	"EHLO moutvdom.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225223AbTCMRX1>; Thu, 13 Mar 2003 17:23:27 +0000
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdom.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18tWQN-0002Gq-00; Thu, 13 Mar 2003 18:23:23 +0100
Received: from [62.109.119.183] (helo=192.168.202.41)
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18tWQN-0000yG-00; Thu, 13 Mar 2003 18:23:23 +0100
From: Bruno Randolf <br1@4g-systems.de>
Organization: 4G Mobile Systeme
To: Dan Malek <dan@embeddededge.com>
Subject: Re: Mycable XXS board
Date: Thu, 13 Mar 2003 18:23:22 +0100
User-Agent: KMail/1.5
Cc: linux-mips@linux-mips.org
References: <3E689267.3070509@prosyst.bg> <200303131408.05612.br1@4g-systems.de> <3E70ABCE.9030909@embeddededge.com>
In-Reply-To: <3E70ABCE.9030909@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303131823.22343.br1@4g-systems.de>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips

On Thursday 13 March 2003 17:03, Dan Malek wrote:

> The way this should really be done is to have a board definition,
> directory and files unique to the XXS board.  Hacking the PB1500
> may be the fast way to get it done locally, but it isn't the right
> way from a Linux structure/maintenance viewpoint.

allright, i can do that - but doesn't this create a lot of unnecessary copied 
code?

bruno
