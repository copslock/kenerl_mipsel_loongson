Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 21:45:26 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:18087 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225375AbUAMVpZ>;
	Tue, 13 Jan 2004 21:45:25 +0000
Received: from zebra.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0DLiqQF002310;
	Tue, 13 Jan 2004 22:44:52 +0100 (MET)
Received: from dimitri by zebra.sonytel.be with local (Exim 3.35 #1 )
	id 1AgWLG-0000jo-00; Tue, 13 Jan 2004 22:44:54 +0100
Date: Tue, 13 Jan 2004 22:44:54 +0100
To: Pete Popov <ppopov@mvista.com>, kph@cisco.com
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: How stable is 2.6 on a SB1250 processor?
Message-ID: <20040113214454.GA2737@sonycom.com>
References: <1074027809.20636.91.camel@shakedown> <1074028164.21857.120.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074028164.21857.120.camel@zeus.mvista.com>
User-Agent: Mutt/1.3.28i
From: Dimitri Torfs <dimitri@sonycom.com>
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2004 at 01:09:25PM -0800, Pete Popov wrote:
> 
> I think userland is still broken. Ralf was working on the access_ok
> problem the last time I talked to him.
> 

Yes, if it's a 32-bit kernel then it's definitely broken. You might want
to check out
http://www.linux-mips.org/archives/linux-mips/2004-01/msg00000.html.

After that fix, user space stuff started to work for me.

Dimitri


-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
