Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 08:56:12 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:7980 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225224AbVAKI4I>;
	Tue, 11 Jan 2005 08:56:08 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0B8u0422636;
	Tue, 11 Jan 2005 09:56:00 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0B8u0i16250;
	Tue, 11 Jan 2005 09:56:00 +0100
Message-ID: <41E394A0.30205@schenk.isar.de>
Date: Tue, 11 Jan 2005 09:56:00 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
CC: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
References: <20041223202526.GA2254@deprecation.cyrius.com> <20041224040051.93587.qmail@web52806.mail.yahoo.com> <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de> <20050107190605.GG31335@rembrandt.csv.ica.uni-stuttgart.de> <41E27A6A.5060204@schenk.isar.de> <20050110140429.GC15344@rembrandt.csv.ica.uni-stuttgart.de> <41E29DF5.6040800@schenk.isar.de> <20050110154246.GH15344@rembrandt.csv.ica.uni-stuttgart.de> <41E38A0A.1010507@schenk.isar.de>
In-Reply-To: <41E38A0A.1010507@schenk.isar.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Rojhalat Ibrahim wrote:
> Thiemo Seufer wrote:
> 
>>
>>
>> This would be a different bug then. It should be relatively easy to
>> catch, there aren't that many places where cpu_has_64bit_gp_regs is
>> used.
>>
>>
> 
> I see you already fixed it. Works fine now. Thanks a lot.
> 

Well, at least for a 32-bit kernel. If I compile a 64-bit
kernel it still stops when it should start init. Any ideas?

Rojhalat Ibrahim
