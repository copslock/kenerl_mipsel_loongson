Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 12:54:07 +0000 (GMT)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:33169
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225073AbUKWMyC>; Tue, 23 Nov 2004 12:54:02 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.12.11/8.12.11) with ESMTP id iANCkCbu032074;
	Tue, 23 Nov 2004 15:46:16 +0300
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id iANCoXAh006454;
	Tue, 23 Nov 2004 15:50:33 +0300
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id iANCoWwH006452;
	Tue, 23 Nov 2004 15:50:32 +0300
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id iANCgPfX019144;
	Tue, 23 Nov 2004 15:42:25 +0300
Message-ID: <41A3314D.5050208@niisi.msk.ru>
Date: Tue, 23 Nov 2004 15:47:09 +0300
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Improve o32 syscall handling
References: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: milter-spamc/0.13.216 (aa19 [172.16.0.19]); Tue, 23 Nov 2004 15:42:26 +0300
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hello,

Thiemo Seufer wrote:
> this is a major cleanup for the o32 syscall handling.

While we're here, there is an ptrace exploit in the syscall handling.

The kernel parses arguments, gets the address of the syscall handling 
routine in t2, and goes to the process which ptraces. On return from 
this process, the kernel restores t2 from the user stack and jumps 
there. I've got an example that gets root from this.

Regards,
Gleb.
