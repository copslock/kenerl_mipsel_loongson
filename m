Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Feb 2013 17:06:57 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:52341 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823901Ab3BDQGzmuUQw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Feb 2013 17:06:55 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r14G6mRY001243;
        Mon, 4 Feb 2013 08:06:48 -0800
X-WSS-ID: 0MHPE39-01-0U0-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2E65F364664;
        Mon,  4 Feb 2013 08:06:44 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([::1]) with mapi id 14.02.0247.003; Mon, 4 Feb 2013
 08:06:40 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>
Subject: RE: [PATCH][RFC] MIPS: microMIPS: Add support to micro-assembler.
Thread-Topic: [PATCH][RFC] MIPS: microMIPS: Add support to micro-assembler.
Thread-Index: AQHN/pSXpmmHN005Y0SyRQVcOld1K5hisX+AgAcyAHs=
Date:   Mon, 4 Feb 2013 16:06:39 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146CA6BA@exchdb03.mips.com>
References: <1359514228-2161-1-git-send-email-sjhill@mips.com>,<510960B9.1060800@gmail.com>
In-Reply-To: <510960B9.1060800@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: OLtTF1Ph702SdH+XV5a0hQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35701
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

> I wonder if we could get rid of most of these #ifdefs by taking the
> approach used in scripts/recordmcount.{c,h} or scripts/sortextable.{c,h}
> 
I do not see how these are at all applicable. I am not going to modify any compiled
ELF binary.

> That is, move all the code that varies between microMIPS and MIPS to an
> included file.  At the top of that file have a single
> #if...#else...#endif block that defines the constants for each variety.
> 
> Then include this file as many times as needed (once or twice) to
> produce the definitions required.
> 
> This would allow both a MIPS and microMIPS uasm to exist in the same kernel.
> 
I did this already did this once before in the <http://patchwork.linux-mips.org/patch/4688/> patch. The only modification of the patch would be to get rid of CONFIG_CPU_MICROMIPS controlling the inclusion of the 'uasm-micromips' and to include it unconditionally. Comments?

-Steve
