Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 13:04:51 +0100 (BST)
Received: from H42.C233.tor.velocet.net ([IPv6:::ffff:216.138.233.42]:59555
	"EHLO copper.vtnet.vjbtlw") by linux-mips.org with ESMTP
	id <S8225240AbTFLMEt>; Thu, 12 Jun 2003 13:04:49 +0100
Received: from silicon.vtint.vjbtlw (silicon.vtint.vjbtlw [192.168.141.14])
	by copper.vtnet.vjbtlw (Postfix) with ESMTP
	id 0B31A39AFE; Thu, 12 Jun 2003 08:04:48 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <mips081@vtnet.ca>
Reply-To: mips081@vtnet.ca
To: tor@spacetec.no (Tor Arntsen), linux-mips@linux-mips.org
Subject: Re: 64-bit sysinfo
Date: Thu, 12 Jun 2003 08:04:47 -0400
User-Agent: KMail/1.4.3
References: <200306121119.h5CBJWqC027855@pallas.spacetec.no>
In-Reply-To: <200306121119.h5CBJWqC027855@pallas.spacetec.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306120804.47827.mips081@vtnet.ca>
Return-Path: <mips081@vtnet.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips081@vtnet.ca
Precedence: bulk
X-list: linux-mips

On June 12, 2003 07:19 am, Tor Arntsen wrote:
> Hm, that sounds wrong to me. 'int' is supposed to be 32 bits also on
> 64-bit systems, only 'long' should be 64 bits.

Right, sorry. That was suppsed to read long. In any case, I put 'printk' 
where the calls are being made as printed out the sizeof() of the 
values and discovered that in user space they're 32 bits and in the 
kernel they're 64 bits.

	Trevor
