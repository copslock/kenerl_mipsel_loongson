Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 20:15:31 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:38316 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823910Ab2KMTPT46yk1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 20:15:19 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qADJFDVn004768
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2012 11:15:13 -0800
X-WSS-ID: 0MDFXHA-01-0T0-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 23B8736465E
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2012 11:15:09 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Tue, 13 Nov 2012
 11:15:08 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     kbuild test robot <fengguang.wu@intel.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [mips-sjhill:mti-next 7/16] arch/mips/kernel/traps.c:1822:6:
 warning: "cpu_data" is not defined
Thread-Topic: [mips-sjhill:mti-next 7/16] arch/mips/kernel/traps.c:1822:6:
 warning: "cpu_data" is not defined
Thread-Index: AQHNwXb6jboQW5XOFE+xOVi1ET0GmJfoI3Cy
Date:   Tue, 13 Nov 2012 19:15:07 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146A7AA5@exchdb03.mips.com>
References: <50a20174.JL3AqbvMzr+q2Po9%fengguang.wu@intel.com>
In-Reply-To: <50a20174.JL3AqbvMzr+q2Po9%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: eQ30GX93IQYjrIT7vPZbiw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34987
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

Fixed and pushed to 'mti-next' branch.
