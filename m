Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jan 2005 13:29:26 +0000 (GMT)
Received: from bay5-f8.bay5.hotmail.com ([IPv6:::ffff:65.54.173.8]:60564 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8224953AbVAZN3I>;
	Wed, 26 Jan 2005 13:29:08 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 26 Jan 2005 05:29:00 -0800
Message-ID: <BAY5-F8ABF0AF0781483555B042A4870@phx.gbl>
Received: from 61.220.240.162 by by5fd.bay5.hotmail.msn.com with HTTP;
	Wed, 26 Jan 2005 13:28:59 GMT
X-Originating-IP: [61.220.240.162]
X-Originating-Email: [ejhsu@msn.com]
X-Sender: ejhsu@msn.com
From:	"Hsu I-Chieh" <ejhsu@msn.com>
To:	linux-mips@linux-mips.org
Subject: A question about TLB mapping
Date:	Wed, 26 Jan 2005 13:28:59 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
X-OriginalArrivalTime: 26 Jan 2005 13:29:00.0980 (UTC) FILETIME=[FF23FF40:01C503AA]
Return-Path: <ejhsu@msn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ejhsu@msn.com
Precedence: bulk
X-list: linux-mips

Hi all,

In version 2.6.4, I observe that the "global" bit will be set if this tlb 
entry is used to map KSEG2 (kernel segment 2, starting from 0xc0000000). 
But in version 2.6.10, the "global" bit won't be set even if the tlb entry 
is used to map KSEG2.

I would like to know if it's right.

Thanks in advance.

regards,

Jacky

_________________________________________________________________
立即申請 MSN Mobile 服務：在您的手機上收發 MSN Hotmail 
http://msn.com.tw/msnmobile 
