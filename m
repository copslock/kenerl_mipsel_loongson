Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 20:15:14 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:38314 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823732Ab2KMTPNLrNct convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 20:15:13 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qADJF4jN004759
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2012 11:15:05 -0800
X-WSS-ID: 0MDFXH0-01-0SX-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 25634364653
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2012 11:15:00 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Tue, 13 Nov 2012 11:15:00 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     kbuild test robot <fengguang.wu@intel.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [mips-sjhill:mti-next 7/16] arch/mips/kernel/traps.c:1822:6:
 error: token "[" is not valid in preprocessor expressions
Thread-Topic: [mips-sjhill:mti-next 7/16] arch/mips/kernel/traps.c:1822:6:
 error: token "[" is not valid in preprocessor expressions
Thread-Index: AQHNwXrGie4vyxUigEmtfvgajCoqbJfoI0j7
Date:   Tue, 13 Nov 2012 19:14:59 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146A7A9B@exchdb03.mips.com>
References: <50a207ef.gpSoNhAZ8NXm7FDK%fengguang.wu@intel.com>
In-Reply-To: <50a207ef.gpSoNhAZ8NXm7FDK%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: Jocbi6UyFUDjwH3CtHGJ6g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34986
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
