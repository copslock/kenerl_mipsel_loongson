Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Aug 2013 04:47:24 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2184 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817537Ab3HZCrRx02I1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Aug 2013 04:47:17 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 25 Aug 2013 19:43:07 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from SJEXCHCAS05.corp.ad.broadcom.com (10.16.203.12) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 25 Aug 2013 19:47:00 -0700
Received: from SJEXCHMB12.corp.ad.broadcom.com (
 [fe80::bc15:c1e1:c29a:36f7]) by SJEXCHCAS05.corp.ad.broadcom.com (
 [::1]) with mapi id 14.01.0438.000; Sun, 25 Aug 2013 19:46:56 -0700
From:   "Sherman Yin" <syin@broadcom.com>
To:     "Linus Walleij" <linus.walleij@linaro.org>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Matt Porter" <matt.porter@linaro.org>,
        "Stephen Warren (swarren@wwwdotorg.org)" <swarren@wwwdotorg.org>
Subject: RE: [PATCH v2] pinctrl: Pass all configs to driver on
 pin_config_set()
Thread-Topic: [PATCH v2] pinctrl: Pass all configs to driver on
 pin_config_set()
Thread-Index: AQHOntXJmgdj0T+r5kuSCtgUWAQalJmjh/cAgANGgmA=
Date:   Mon, 26 Aug 2013 02:46:56 +0000
Message-ID: <051069C10411E24D9749790C498526FA1BDDCD3B@SJEXCHMB12.corp.ad.broadcom.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
 <1377134300-25480-1-git-send-email-syin@broadcom.com>
 <CACRpkdZeET601+jOsjQxu-VAhi1owgtMX60Fij=uU489eGVFXg@mail.gmail.com>
In-Reply-To: <CACRpkdZeET601+jOsjQxu-VAhi1owgtMX60Fij=uU489eGVFXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.203.100]
MIME-Version: 1.0
X-WSS-ID: 7E041F310UO442618-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <syin@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: syin@broadcom.com
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

Hi Linus,

>Didn't you get review from Stephen Warren?

Yes, just wasn't sure when those tags should be added.  They have been 
added to v3 now.

>Please try to put all the maintainers for the above files on the To: line
>so they get a chance to review/ack the patch.

Ok.  I've added the emails from get_maintainer.pl for each of the files.
v3 has been rebased today and I also applied the API changes to 
pinctrl-palmas.c

Regards,
Sherman
