Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2002 18:16:28 +0100 (CET)
Received: from real.realitydiluted.com ([208.242.241.164]:45463 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1122121AbSKDRQ2>; Mon, 4 Nov 2002 18:16:28 +0100
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 188kpn-0004YX-00; Mon, 04 Nov 2002 11:16:19 -0600
Message-ID: <3DC6AB62.7000603@realitydiluted.com>
Date: Mon, 04 Nov 2002 11:16:18 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <20021104070233.C8860@lucon.org> <3DC6A6E7.6000107@realitydiluted.com> <20021104091119.A10646@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

H. J. Lu wrote:
>>
>>Fine. Still, that doesn't solve the problem, or what I perceive to
>>be a problem. I'll submit my patch and watch it be ignored or for
>>someone to say something.
> 
> 
> The Linux binutils works fine for me.
> 
Really? Good. Go get this tarball:

     ftp://ftp.realitydiluted.com/Linux/MIPS/zlib-1.1.4-mips-prob.tar.bz2

make sure your tools are in your path and just do 'make' and see
what ISA your 'libz.so.1.1.4' is. Thanks.

-Steve
