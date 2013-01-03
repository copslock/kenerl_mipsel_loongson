Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jan 2013 23:09:51 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:33694 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822150Ab3ACWJuV1UBx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jan 2013 23:09:50 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r03M9gQW021690
        for <linux-mips@linux-mips.org>; Thu, 3 Jan 2013 14:09:43 -0800
X-WSS-ID: 0MG2LK0-01-1SJ-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2126F36465C
        for <linux-mips@linux-mips.org>; Thu,  3 Jan 2013 14:09:36 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Thu, 3 Jan 2013
 14:09:33 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     kbuild test robot <fengguang.wu@intel.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [mips-sjhill:mti-next 31/35] dma-default.c:(.text+0xb958):
 undefined reference to `hw_coherentio'
Thread-Topic: [mips-sjhill:mti-next 31/35] dma-default.c:(.text+0xb958):
 undefined reference to `hw_coherentio'
Thread-Index: AQHN1GRl0PGov6lWJkKPg2zkrF5Dg5g4T2xX
Date:   Thu, 3 Jan 2013 22:09:32 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AF086@exchdb03.mips.com>
References: <50c1c2f5.TyQEXFiN4QI5UfpT%fengguang.wu@intel.com>
In-Reply-To: <50c1c2f5.TyQEXFiN4QI5UfpT%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: 8zZzdHKLd4JPxitlrtaSmQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35359
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

Fixed by the patch "[PATCH v2] MIPS: Add option to disable software I/O coherency."
