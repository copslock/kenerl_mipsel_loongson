Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 03:07:09 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3372 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491056Ab1EQBHC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2011 03:07:02 +0200
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 16 May 2011 18:10:20 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB02.corp.ad.broadcom.com ([10.9.200.133]) with mapi; Mon, 16
 May 2011 18:06:38 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "David Daney" <ddaney@caviumnetworks.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 16 May 2011 18:06:38 -0700
Subject: RE: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwUJyNLQCWWsMBMTS+k87EyCgNiPAABwD8A
Message-ID: <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
In-Reply-To: <4DD1BD72.2000408@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: AbBj CEM+ EETr H4fC LvJ/ MT7A NmvF NzQD OLoi TWfe
 TlvX VOIH ZRz7 ZnmE Z7XP
 d2qQ;3;ZABkAGEAbgBlAHkAQABjAGEAdgBpAHUAbQBuAGUAdAB3AG8AcgBrAHMALgBjAG8AbQA7AGwAaQBuAHUAeAAtAG0AaQBwAHMAQABsAGkAbgB1AHgALQBtAGkAcABzAC4AbwByAGcAOwByAGEAbABmAEAAbABpAG4AdQB4AC0AbQBpAHAAcwAuAG8AcgBnAA==;Sosha1_v1;7;{A338645E-6FC6-4C3B-9984-48147B7446EA};agBpAHAAZQBuAGcAQABiAHIAbwBhAGQAYwBvAG0ALgBjAG8AbQA=;Tue,
 17 May 2011 01:06:38
 GMT;UgBFADoAIABwAGEAdABjAGgAIAB0AG8AIABzAHUAcABwAG8AcgB0ACAAdABvAHAAZABvAHcAbgAgAG0AbQBhAHAAIABhAGwAbABvAGMAYQB0AGkAbwBuACAAaQBuACAATQBJAFAAUwA=
x-cr-puzzleid: {A338645E-6FC6-4C3B-9984-48147B7446EA}
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61CF15764NS8491924-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <jipeng@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips

Thank you for reviewing. Here is new one with all fixings you want.
