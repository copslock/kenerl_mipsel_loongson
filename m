Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2005 17:01:59 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:60332 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225226AbVABRBy>; Sun, 2 Jan 2005 17:01:54 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j02GwddW020455;
	Sun, 2 Jan 2005 11:58:39 -0500
Received: from [192.168.1.2] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by vivi.cc.vt.edu (MOS 3.5.6-GR)
	with ESMTP id CIA35012 (AUTH spbecker);
	Sun, 2 Jan 2005 12:01:27 -0500 (EST)
Message-ID: <41D828E9.2020109@gentoo.org>
Date: Sun, 02 Jan 2005 12:01:29 -0500
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Parker <whtghst1@direcway.com>
CC: Mudeem Iqbal <mudeem@Quartics.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: cross compiling gcc for mips
References: <1B701004057AF74FAFF851560087B161064698@1aurora.enabtech> <41D8274F.7070203@direcway.com>
In-Reply-To: <41D8274F.7070203@direcway.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Scott Parker wrote:
> How did you configure GCC?
> 
> Mudeem Iqbal wrote:
> 
>> Hi,
>>
>> I am building a toolchain for mips platform. I am using
>>
>> binutils-2.15
>> gcc-3.4.3
>> glibc-2.3.3
>> linux-2.6.9    (from linux-mips.org)
>>

Try using 2.4 headers instead.  I haven't had much success using 2.6 
headers to build a mips (cross)toolchain.

Steve
