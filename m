Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 10:10:19 +0000 (GMT)
Received: from ppp-104.net10.magic.fr ([IPv6:::ffff:195.154.128.104]:20740
	"HELO volvic.sud.stepmind.com") by linux-mips.org with SMTP
	id <S8225195AbTCMKKS>; Thu, 13 Mar 2003 10:10:18 +0000
Received: (qmail 8226 invoked from network); 13 Mar 2003 10:00:16 -0000
Received: from eku.sud.stepmind.com (HELO stepmind.com) (192.168.1.103)
  by volvic.sud.stepmind.com with SMTP; 13 Mar 2003 10:00:16 -0000
Message-ID: <3E7057A6.60007@stepmind.com>
Date: Thu, 13 Mar 2003 11:04:22 +0100
From: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@stepmind.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030302
X-Accept-Language: fr, en, de
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PROM variables
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <vincent.stehle@stepmind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vincent.stehle@stepmind.com
Precedence: bulk
X-list: linux-mips


Hi all,

Is there a way to get/set PROM variables under Linux ?

I have an indigo2 with no display, and setting the variables without 
reverting to the monitor through the serial line would be very handy.

As I doubt there is currently a solution, I was thinking about 
implementing this as a /proc subdir. What do you think ?

Regards,

-- 
  Vincent Stehlé
