Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2005 20:30:14 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:7820 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225322AbVHUT3m>; Sun, 21 Aug 2005 20:29:42 +0100
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.50 #1 (Debian))
	id 1E6uf0-0007tr-N0; Sun, 21 Aug 2005 13:35:10 -0500
Message-ID: <4308D75D.3090205@realitydiluted.com>
Date:	Sun, 21 Aug 2005 14:34:53 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	mohanlal jangir <mohanlaljangir@hotmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: NPTL info needed
References: <200508181804.LAA04568@mon-irva-10.broadcom.com> <4304D201.2060306@mvista.com> <BAY18-DAV2A05369EA8C7D91990C16D2B50@phx.gbl>
In-Reply-To: <BAY18-DAV2A05369EA8C7D91990C16D2B50@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

mohanlal jangir wrote:
>
> Thanks for your help. I tried to apply this patch on Linux-2.6.10 and 
> many hunks failed. Could you tell me which kernel version this patch 
> should be applied? Also do I need to apply any patch to gcc, glibc 
> sources (and build a new toolchain)?
>
Mohanlal,

If you are wanting to work with NPTL and MIPS, please use the latest
Linux version from the Linux/MIPS cvs tree. The latest releases of
binutils-2.16.x contain NPTL support for MIPS. You will need to use
the HEAD of gcc cvs and the HEAD of glibc cvs in order to get the
MIPS NPTL support. Please note that NO backport of NPTL will be done
to versions of GCC older than 4.1.0. Have fun.

-Steve
