Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 19:41:13 +0000 (GMT)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:19706
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225339AbVAFTlG>; Thu, 6 Jan 2005 19:41:06 +0000
Received: from [192.168.50.222] ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 6 Jan 2005 11:41:03 -0800
Message-ID: <41DD9380.5080305@sunrisetelecom.com>
Date: Thu, 06 Jan 2005 14:37:36 -0500
From: Karl Lessard <klessard@sunrisetelecom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: Floating-point questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2005 19:41:03.0605 (UTC) FILETIME=[A8334250:01C4F427]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

Hi all,

I just want to make sure that I understand correctly the behavior of 
floating-points on systems without
FPU.  There is 2 way for doing floating-point operations:

The first is to let the CPU generate exceptions on a FP operation call , 
which are handl e by the kernel that do the job in software,
using integers only.

The second is to build your app using the -msoft-float compilation flag, 
making GCC to convert itself the FP operations
to integer operations, using its own libraries.

Also, I've test the both methods with simple float operations, and I 
figured suprisingly that the first method is a bit
faster (I though the overhead would have been larger than the second one).

Do I miss something? Is there anything I can do to optimize 
significantly float operations?

Thanks a lot,
Karl
