Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 19:38:45 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:33005 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3ADSinkQhQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 19:38:43 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r04Ica87009682;
        Fri, 4 Jan 2013 10:38:36 -0800
X-WSS-ID: 0MG46GC-01-252-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2776436465C;
        Fri,  4 Jan 2013 10:38:36 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Fri, 4 Jan 2013
 10:38:34 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
Thread-Topic: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
Thread-Index: AQHN2X9pyfb9ZaeD/km09iPLMrJAg5gX5feAgAADMQCAIbbgOA==
Date:   Fri, 4 Jan 2013 18:38:32 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AF10B@exchdb03.mips.com>
References: <1355436915-24381-1-git-send-email-sjhill@mips.com>
 <alpine.LFD.2.02.1212132325180.5950@eddie.linux-mips.org>,<50CA6712.1060809@gmail.com>
In-Reply-To: <50CA6712.1060809@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: /Khdoq2rU3xB5aGaH5PAOA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35371
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

> You're exporting privileged context outside the kernel -- have all the
> security implications been considered?
>
Maciej,

I have gone through the config registers bit-by-bit and I do not see where there are any security implications. There are maybe 7 bits total in config registers 0 through 5 that are R/W and this patch, of course, is providing RO access. A motivated person could download the PRA documents from our website even without this patch to discover what was implemented in the system. I could certainly see security implications if we were exporting the STATUS, CAUSE, and other critical registers. Unless you can provide a counterexample, this patch does not compromise the system in anyway.  

-Steve
