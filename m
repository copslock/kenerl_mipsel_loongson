Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2011 19:47:44 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3184 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491193Ab1EYRrg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2011 19:47:36 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 25 May 2011 10:51:23 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB02.corp.ad.broadcom.com ([10.9.200.133]) with mapi; Wed, 25
 May 2011 10:47:08 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "Jian Peng" <jipeng@broadcom.com>,
        "David Daney" <ddaney@caviumnetworks.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 25 May 2011 10:47:04 -0700
Subject: RE: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwUsneCTlGOAW6VRxSfP9XSJ76cdQAFvGTAAY6LjoA=
Message-ID: <E18F441196CA634DB8E1F1C56A50A874572CCBB6B5@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54D97@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD2A729.9090502@caviumnetworks.com>
 <E18F441196CA634DB8E1F1C56A50A8743242B54FA7@IRVEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A8743242B54FA7@IRVEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: M7z0 NiLp OGNr OhEi PnP/ QiRj RMG2 SX3D WJCy WXeb
 Zxzw cZtu cnf3 gJrS jqBn
 kthi;3;ZABkAGEAbgBlAHkAQABjAGEAdgBpAHUAbQBuAGUAdAB3AG8AcgBrAHMALgBjAG8AbQA7AGwAaQBuAHUAeAAtAG0AaQBwAHMAQABsAGkAbgB1AHgALQBtAGkAcABzAC4AbwByAGcAOwByAGEAbABmAEAAbABpAG4AdQB4AC0AbQBpAHAAcwAuAG8AcgBnAA==;Sosha1_v1;7;{F041D2A0-47BC-4A48-97A6-7B01E3DDCED6};agBpAHAAZQBuAGcAQABiAHIAbwBhAGQAYwBvAG0ALgBjAG8AbQA=;Wed,
 25 May 2011 17:47:04
 GMT;UgBFADoAIABwAGEAdABjAGgAIAB0AG8AIABzAHUAcABwAG8AcgB0ACAAdABvAHAAZABvAHcAbgAgAG0AbQBhAHAAIABhAGwAbABvAGMAYQB0AGkAbwBuACAAaQBuACAATQBJAFAAUwA=
x-cr-puzzleid: {F041D2A0-47BC-4A48-97A6-7B01E3DDCED6}
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61C39E111IC11788649-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <jipeng@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf/David,

What else should I do to get this patch merged?

Thanks,
Jian

-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jian Peng
Sent: Tuesday, May 17, 2011 12:37 PM
To: David Daney
Cc: linux-mips@linux-mips.org; Ralf Baechle
Subject: RE: patch to support topdown mmap allocation in MIPS

This one merged Ralf's patch and removed duplication. I can only test it on MIPS32 system for now.
