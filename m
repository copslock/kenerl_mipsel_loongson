Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 09:25:29 +0000 (GMT)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:2505 "EHLO
	kojot.voda.cz") by linux-mips.org with ESMTP id <S8224901AbVASJZX>;
	Wed, 19 Jan 2005 09:25:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by kojot.voda.cz (Postfix) with ESMTP id 218D84CB41
	for <linux-mips@ftp.linux-mips.org>; Wed, 19 Jan 2005 10:25:22 +0100 (CET)
Received: from kojot.voda.cz ([127.0.0.1])
 by localhost (kojot [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10027-03 for <linux-mips@ftp.linux-mips.org>;
 Wed, 19 Jan 2005 10:25:20 +0100 (CET)
Received: from [10.1.1.77] (unknown [10.1.1.77])
	by kojot.voda.cz (Postfix) with ESMTP id D0D674BE8D
	for <linux-mips@ftp.linux-mips.org>; Wed, 19 Jan 2005 10:25:19 +0100 (CET)
Message-ID: <41EE277F.5090002@voda.cz>
Date: Wed, 19 Jan 2005 10:25:19 +0100
From: =?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@ftp.linux-mips.org
Subject: porting to ADM5120
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at voda.cz
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 6948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Hi,

I am working on solution using ADM5120 SoC (a 4kc MIPS). I as well have 
docs for the SoC and patched kernel 2.4.18 sources that I am able to 
compile, make image anf run on the system. The problem is that I need to 
have some more recent kernel, eg. 2.4.27. I have diffing out all the 
relevant changes from the old version and include them in cvs check-out 
version 2.4.27. After some cleanup, I got it to compile, but the image 
just doesn't do anything when run on the SoC. It says jump to linux 
code... and dies. I have checked just about everything that I can ( and 
at least a bit understand) including the early printk patch. Not a 
single byte of output on the serial console.

The question is, whether there is someone, who could possibly help to 
look into this, as assembly code level is really not my skill, but I 
really need to get the kernel running and I feel like I'm out of 
options.  Any help will be greatly appreciated.

                                     TIA, Tom

-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
