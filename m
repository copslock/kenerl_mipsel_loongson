Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 19:31:13 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:34062 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225812AbUDESbL>; Mon, 5 Apr 2004 19:31:11 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Mon, 05 Apr 2004 11:30:30 -0700
X-Server-Uuid: 011F2A72-58F1-4BCE-832F-B0D661E896E8
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA29978; Mon, 5 Apr 2004 11:29:59 -0700 (PDT)
Received: from broadcom.com ([10.21.2.22]) by mail-sj1-1.sj.broadcom.com
 (8.12.9/8.12.4/SSM) with ESMTP id i35IUVLn021228; Mon, 5 Apr 2004 11:
 30:31 -0700 (PDT)
Message-ID: <4071A555.8050202@broadcom.com>
Date: Mon, 05 Apr 2004 11:28:37 -0700
From: "Mitch Lichtenberg" <mpl@broadcom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
 Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Jun Sun" <jsun@mvista.com>, "Martin Michlmayr" <tbm@cyrius.com>,
	linux-mips@linux-mips.org
Subject: Re: [patch] swarm-cs4297a: Support little-endian configuration
References: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
 <20040405125436.GA2741@deprecation.cyrius.com>
 <Pine.LNX.4.55.0404051457010.31851@jurand.ds.pg.gda.pl>
 <20040405105535.D13322@mvista.com>
 <Pine.LNX.4.55.0404052010050.31851@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0404052010050.31851@jurand.ds.pg.gda.pl>
X-WSS-ID: 6C6F7A4C1PW7531290-01-01
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mpl@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpl@broadcom.com
Precedence: bulk
X-list: linux-mips


Adding ELF64 to CFE has been on my to-do list for ages.   Thanks for
the reminder, I'll try to bump it up a few notches.
Now I know who to send it to for testing :-).

/Mitch.


> On Mon, 5 Apr 2004, Jun Sun wrote:
> 
> 
>>I have been using objcopy to convert ELF64 to ELF32 and then boot through 
>>CFE (suggested by Drow).  This seems to be working fine.
> 
> 
>  It does work and the Linux Makefile even does the conversion
> automatically.  It's a bit annoying, though, to have to keep two images.
> 
