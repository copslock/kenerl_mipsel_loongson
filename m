Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 20:40:09 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:22144
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225248AbTBUUkI>; Fri, 21 Feb 2003 20:40:08 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h1LKeiM01029;
	Fri, 21 Feb 2003 15:40:44 -0500
Message-ID: <3E568ECC.2090601@embeddededge.com>
Date: Fri, 21 Feb 2003 15:40:44 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: baitisj@evolution.com
CC: ppopov@mvista.com, linux-mips@linux-mips.org
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
References: <200302201135.09154.krishnakumar@naturesoft.net> <20030221.112456.41627052.nemoto@toshiba-tops.co.jp> <20030221122515.E20129@luca.pas.lab>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Jeff Baitis wrote:

> I'd love to know where this mystery fixup_bigphys_addr comes from!?

You need the 36-bit patch from Pete that is not yet part of the
linux-mips tree.

You can find it on linux-mips.org in /pub/linux/mips/people/ppopov.

Have fun!


	-- Dan
