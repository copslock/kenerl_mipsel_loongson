Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 08:36:41 +0000 (GMT)
Received: from webmail-outgoing.us4.outblaze.com ([IPv6:::ffff:205.158.62.67]:50574
	"EHLO webmail-outgoing.us4.outblaze.com") by linux-mips.org
	with ESMTP id <S8224772AbUCYIgi>; Thu, 25 Mar 2004 08:36:38 +0000
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com [205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 8A5D11801538
	for <linux-mips@linux-mips.org>; Thu, 25 Mar 2004 08:36:29 +0000 (GMT)
X-OB-Received: from unknown (205.158.62.131)
  by wfilter.us4.outblaze.com; 25 Mar 2004 08:35:46 -0000
Received: by ws5-1.us4.outblaze.com (Postfix, from userid 1001)
	id 8255C39834A; Thu, 25 Mar 2004 08:36:29 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [203.197.141.34] by ws5-1.us4.outblaze.com with http for
    xavier_prabhu@linuxmail.org; Thu, 25 Mar 2004 16:36:29 +0800
From: "xavier prabhu" <xavier_prabhu@linuxmail.org>
To: linux-mips@linux-mips.org
Date: Thu, 25 Mar 2004 16:36:29 +0800
Subject: __up and __down not found in 2.25 kernel
X-Originating-Ip: 203.197.141.34
X-Originating-Server: ws5-1.us4.outblaze.com
Message-Id: <20040325083629.8255C39834A@ws5-1.us4.outblaze.com>
Return-Path: <xavier_prabhu@linuxmail.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xavier_prabhu@linuxmail.org
Precedence: bulk
X-list: linux-mips

Hi,

I'm using a module which is developed for 2.22 kernel.
This module uses __up and __down semaphore functions. 
While I insmod this module with 2.25 kernel,
I get the following error message
"insmod: unresolved symbol __up
insmod: unresolved symbol __down"

I checked the semaphore.c. It doesn't define these two functions.
Is there any way to work around this issue.

Please help me to solve this issue.
Thanks in advance.

Regards,
Xavier.
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
