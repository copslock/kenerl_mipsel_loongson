Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 18:31:16 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:48101
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225252AbUIXRbM>; Fri, 24 Sep 2004 18:31:12 +0100
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.12.11/8.12.11) with ESMTP id i8OHSIdB017767
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 21:28:18 +0400
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id i8OHVfGr028848
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 21:31:41 +0400
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id i8OHVfr6028846
	for linux-mips@linux-mips.org; Fri, 24 Sep 2004 21:31:41 +0400
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id i8OHOnga025697
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 21:24:49 +0400
Message-ID: <4154597C.3080405@niisi.msk.ru>
Date: Fri, 24 Sep 2004 21:29:32 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: redhat/7.3/NIISI updated
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: milter-spamc/0.13.216 (aa19 [172.16.0.19]); Fri, 24 Sep 2004 21:24:49 +0400
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hello,

I've uploaded new NIISI packages in 
ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/NIISI/

The NIISI packages are updated version of H.J. Lu's mini-port of RedHat 7.3.

Most important change in this update is all packages from mini-port and 
previous NIISI updates were recompiled due to a bug in the C/C++ 
compiler from the original toolchain package. Of course, the bug itself 
is fixed in toolchain.

Other changes include RH/FL security fixes and a lot of new stuff.

Finally, a (not-so-)minimal root fs package  is provided in tools.

Regards,
Gleb.
