Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 20:30:46 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:49974 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820513Ab3ADTapQHtjF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 20:30:45 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r04JUbEb010958;
        Fri, 4 Jan 2013 11:30:37 -0800
X-WSS-ID: 0MG48UY-01-26P-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 231F936465C;
        Fri,  4 Jan 2013 11:30:34 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Fri, 4 Jan 2013
 11:30:33 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
Thread-Topic: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
Thread-Index: AQHN2X9pyfb9ZaeD/km09iPLMrJAg5gX5feAgAADMQCAIbbgOIAAj+WA//+AxrE=
Date:   Fri, 4 Jan 2013 19:30:31 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AF11F@exchdb03.mips.com>
References: <1355436915-24381-1-git-send-email-sjhill@mips.com>
 <alpine.LFD.2.02.1212132325180.5950@eddie.linux-mips.org>,<50CA6712.1060809@gmail.com>
 <31E06A9FC96CEC488B43B19E2957C1B801146AF10B@exchdb03.mips.com>,<50E727E1.8040604@gmail.com>
In-Reply-To: <50E727E1.8040604@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: T1AhJZHQKcGYobS2TeX/pA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35374
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

> The patch stands alone.  Any security problems it might have are
> completely unrelated to any hypothetical Counter Examples.
>
Indeed. So, can I get an ACK or what next? Thanks.

-Steve
