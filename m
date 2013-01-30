Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 03:52:57 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:35362 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824767Ab3A3Cw42yI4S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jan 2013 03:52:56 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r0U2qnvK021534;
        Tue, 29 Jan 2013 18:52:49 -0800
X-WSS-ID: 0MHF400-01-3ON-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2F52236464F;
        Tue, 29 Jan 2013 18:52:48 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([::1]) with mapi id 14.02.0247.003; Tue, 29 Jan 2013
 18:52:44 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "ddaney.cavm@gmail.com" <ddaney.cavm@gmail.com>
Subject: RE: [PATCH][RFC] MIPS: microMIPS: Add support to micro-assembler.
Thread-Topic: [PATCH][RFC] MIPS: microMIPS: Add support to micro-assembler.
Thread-Index: AQHN/pSXpmmHN005Y0SyRQVcOld1K5hhLArc
Date:   Wed, 30 Jan 2013 02:52:43 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146CA474@exchdb03.mips.com>
References: <1359514228-2161-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1359514228-2161-1-git-send-email-sjhill@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: hgcrGpyllDdFX47c/bJAgg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35622
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

I am hoping that this patch addresses a lot of the comments from Kevin's input. Another follow-on patch would take the instruction array out of this file and put it in 'uasm-mips.c' and create a new file 'uasm-micromips.c' with the microMIPS instruction array. Please let me know if this patch is more acceptable. Thanks.

-Steve
