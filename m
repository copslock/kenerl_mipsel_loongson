Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2012 20:27:45 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:49698 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903450Ab2GLS1l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2012 20:27:41 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q6CIRXxI029951;
        Thu, 12 Jul 2012 11:27:33 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Thu, 12 Jul 2012
 11:27:14 -0700
From:   "Hill, Steven" <sjhill@mips.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v4,04/10] Add the MIPS32R2 'ins' and 'ext' instructions
 for use by the kernel's micro-assembler.
Thread-Topic: [PATCH v4,04/10] Add the MIPS32R2 'ins' and 'ext' instructions
 for use by the kernel's micro-assembler.
Thread-Index: AQHNViX6NQwUfW+0XUuBvsFSkLeGqpcTwJeAgBJJqAo=
Date:   Thu, 12 Jul 2012 18:27:14 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B80114699ED9@exchdb03.mips.com>
References: <1340994924-3922-1-git-send-email-sjhill@mips.com>,<4FEF5C29.50107@mvista.com>
In-Reply-To: <4FEF5C29.50107@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: 1Tqaygz5P2idrI1ZkSNI6g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

>> @@ -396,6 +405,8 @@ I_u2u1u3(_drotr)
>>   I_u2u1u3(_drotr32)
>>   I_u3u1u2(_dsubu)
>>   I_0(_eret)
>> +I_u2u1mmsbu3(_ext)
>> +I_u2u1msbu3(_ins)
>
>   Not I_u2u1mmsbu3()?
>
No, the 'ins' instruction opcode layout is identical to the 'dins' instruction. Thus, it is correct.
