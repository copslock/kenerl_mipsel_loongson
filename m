Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Aug 2004 01:38:46 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:40074 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8224897AbUHUAim>; Sat, 21 Aug 2004 01:38:42 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20040821003829014007romte>
          (Authid: kumba12345);
          Sat, 21 Aug 2004 00:38:33 +0000
Message-ID: <41269A5D.50700@gentoo.org>
Date: Fri, 20 Aug 2004 20:42:05 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 64-bit kernels for the Qube
References: <20040820224724.GB7373@skeleton-jack>
In-Reply-To: <20040820224724.GB7373@skeleton-jack>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:

> I'm looking to build a 64-bit 2.6.x kernel for running on the Cobalt
> Qube. Can someone tell me which binutils and gcc versions I should be
> using ?
> 
> P.

gcc-3.3.4 and binutils-2.14.90.0.8 work for me (also tested 
2.15.90.0.3).  3.4.x has some issues, any kernel built with it seems to 
crash after checking for the daddui bug (tested on cobalt 32bit and O2 
64bit after applying a patch to remove 'accum' from several files).


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
