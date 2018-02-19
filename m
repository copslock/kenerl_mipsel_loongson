Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 15:00:52 +0100 (CET)
Received: from smtp-out4.electric.net ([192.162.216.184]:61487 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992973AbeBSOAoIx2pC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Feb 2018 15:00:44 +0100
Received: from 1enlzb-0008qE-Uh by out4d.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1enlzc-0008wM-VB; Mon, 19 Feb 2018 06:00:32 -0800
Received: by emcmailer; Mon, 19 Feb 2018 06:00:32 -0800
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1enlzb-0008qE-Uh; Mon, 19 Feb 2018 06:00:31 -0800
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 19 Feb 2018 14:01:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 19 Feb 2018 14:01:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Burton' <paul.burton@mips.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v5 07/14] net: pch_gbe: Fix handling of TX padding
Thread-Topic: [PATCH v5 07/14] net: pch_gbe: Fix handling of TX padding
Thread-Index: AQHTqCzRjfXXBHe1nUOj8GyASlELI6Orwr4w
Date:   Mon, 19 Feb 2018 14:01:25 +0000
Message-ID: <33d3777368d244a79c6287b2e955853f@AcuMS.aculab.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-8-paul.burton@mips.com>
In-Reply-To: <20180217201037.3006-8-paul.burton@mips.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (s)
X-Virus-Status: Scanned by VirusSMART (c)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Paul Burton
> Sent: 17 February 2018 20:11
> 
> The ethernet controller found in the Intel EG20T Platform Controller
> Hub requires that we place 2 bytes of padding between the ethernet
> header & the packet payload. Our pch_gbe driver handles this by copying
> packets to be transmitted to a temporary struct skb with the padding
> bytes inserted
...

Uggg WFT is the driver doing that for?

I'd guess that the two byte pad is there so that a 4 byte aligned
frame is still 4 byte aligned when the 14 byte ethernet header is added.
So instead of copying the entire frame the MAC header should be built
(or rebuilt?) two bytes further from the actual data.

	David
