Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 23:12:42 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1672 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491054Ab1EPVMg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 23:12:36 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 16 May 2011 14:13:47 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB01.corp.ad.broadcom.com ([10.9.200.131]) with mapi; Mon, 16
 May 2011 14:09:51 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
cc:     "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 16 May 2011 14:09:46 -0700
Subject: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwUDZV1rkskQxMpROqms+cuQJj71w==
Message-ID: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: BY3Z CL+o Cbvi Ce5G Fbp4 FqCU G4zI J/1J KIWF Kp/u
 Ljeu O7xN O9c4 O+3c Pxau
 RVdN;2;bABpAG4AdQB4AC0AbQBpAHAAcwBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA7AHIAYQBsAGYAQABsAGkAbgB1AHgALQBtAGkAcABzAC4AbwByAGcA;Sosha1_v1;7;{529305D6-144C-433F-B3E5-2920E3B268FA};agBpAHAAZQBuAGcAQABiAHIAbwBhAGQAYwBvAG0ALgBjAG8AbQA=;Mon,
 16 May 2011 21:09:46
 GMT;cABhAHQAYwBoACAAdABvACAAcwB1AHAAcABvAHIAdAAgAHQAbwBwAGQAbwB3AG4AIABtAG0AYQBwACAAYQBsAGwAbwBjAGEAdABpAG8AbgAgAGkAbgAgAE0ASQBQAFMA
x-cr-puzzleid: {529305D6-144C-433F-B3E5-2920E3B268FA}
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61CF4C011IC8261062-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <jipeng@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips

