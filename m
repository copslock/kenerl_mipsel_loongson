Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 22:50:28 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:43156 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832246Ab3APVu1QoFVa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 22:50:27 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r0GLoJ76031578;
        Wed, 16 Jan 2013 13:50:19 -0800
X-WSS-ID: 0MGQNBS-01-0ZF-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 27A9B364671;
        Wed, 16 Jan 2013 13:50:16 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Wed, 16 Jan 2013
 13:50:11 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "kevink@paralogos.com" <kevink@paralogos.com>,
        "Daney, David" <David.Daney@caviumnetworks.com>
Subject: RE: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Thread-Topic: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Thread-Index: AQHN8ud/23VXA8A/UkelDJ80Zymw1ZhLUM8A//+kFDGAAI21gIABVHwA//+plwM=
Date:   Wed, 16 Jan 2013 21:50:10 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146C627E@exchdb03.mips.com>
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>,<50F5B0D0.9010604@gmail.com>
 <31E06A9FC96CEC488B43B19E2957C1B801146C51CC@exchdb03.mips.com>
 <50F5DA93.2080706@gmail.com>,<50F6F832.1060807@gmail.com>
In-Reply-To: <50F6F832.1060807@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: iUjMj2nGx/bp020DVNHFlQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35473
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

I will take whatever method everyone chooses. This is the path I need for microMIPS, so I am an agnostic.
