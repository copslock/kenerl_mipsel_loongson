Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2004 09:00:01 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:11471
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8224924AbUI0H75>; Mon, 27 Sep 2004 08:59:57 +0100
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.12.11/8.12.11) with ESMTP id i8R7u7Xx004456;
	Mon, 27 Sep 2004 11:56:08 +0400
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id i8R7xXGr023726;
	Mon, 27 Sep 2004 11:59:33 +0400
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id i8R7xX3N023724;
	Mon, 27 Sep 2004 11:59:33 +0400
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id i8R7rqga002212;
	Mon, 27 Sep 2004 11:53:52 +0400
Message-ID: <4157C84F.1050308@niisi.msk.ru>
Date: Mon, 27 Sep 2004 11:59:11 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Dominik 'Rathann' Mierzejewski" <D.Mierzejewski@icm.edu.pl>
CC: linux-mips@linux-mips.org
Subject: Re: redhat/7.3/NIISI updated
References: <4154597C.3080405@niisi.msk.ru> <20040924174313.GB6050@liandra.icm.edu.pl>
In-Reply-To: <20040924174313.GB6050@liandra.icm.edu.pl>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: milter-spamc/0.13.216 (aa19 [172.16.0.19]); Mon, 27 Sep 2004 11:53:53 +0400
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

hello!

Dominik 'Rathann' Mierzejewski wrote:
> Is there a HOWTO available specifically for cross-building RH7.3 for MIPS
> on another (x86) RedHat/Fedora box?

We used RH 7.3/i386. As I said every package in redhat/7.3/NIISI was 
cross-compiled on i386 for the MIPS I BE arch.

nano-HOWTO:

1. Install rpm and toolchain from RPMS/devel on RH 7.3/i386
2. Rebuild packages. Use rpmrc, rpmmacro, and 
find-requires-mips-linux-full during rebuild
3. Use scripts/spec-gen to get mips-linux- packages

That's all.

Regards,
Gleb.
