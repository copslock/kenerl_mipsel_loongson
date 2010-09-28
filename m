Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 12:48:57 +0200 (CEST)
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:51933 "EHLO
        eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491958Ab0I1Ksx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 12:48:53 +0200
Received: from source ([167.4.1.35]) (using TLSv1) by eu1sys200aob109.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKHIBFVjFZzB0DsSl+C+sr2G986NGhQx@postini.com; Tue, 28 Sep 2010 10:48:53 UTC
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id DD62EC3;
        Tue, 28 Sep 2010 10:45:01 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 0E09734C;
        Tue, 28 Sep 2010 10:48:16 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 4E659A8096;
        Tue, 28 Sep 2010 12:48:10 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.230.100.3]) by
 exdcvycastm003.EQ1STM.local ([10.230.100.1]) with mapi; Tue, 28 Sep 2010
 12:48:15 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
Date:   Tue, 28 Sep 2010 12:48:12 +0200
Subject: RE: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
Thread-Topic: [PATCH 3/7] leds: pwm: add a new element 'name' to platform
 data
Thread-Index: Acte+jRWeNi88ekyQ5KOTcl29A0fyAAAFG4A
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FC97@EXDCVYMBSTM006.EQ1STM.local>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
 <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
 <4CA1C6C4.20504@mvista.com>
In-Reply-To: <4CA1C6C4.20504@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 27872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22278

> > @@ -16,6 +16,7 @@ struct led_pwm {
> >   struct led_pwm_platform_data {
> >   	int			num_leds;
> >   	struct led_pwm	*leds;
> > +	char *name;
> >   };
> 
>     Shouldn't '*name'be aligned, at least with '*leds'?
Sure, will take care of this in the v2 patch.

Thanks and Regards,
Arun R Murthy
-------------
