Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 13:35:53 +0100 (CET)
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991416AbeBUMfqBTieT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 13:35:46 +0100
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w1LCYHs7022461;
        Wed, 21 Feb 2018 13:34:55 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2g8s9xbn7k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 21 Feb 2018 13:34:55 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B404F31;
        Wed, 21 Feb 2018 12:34:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8B1229F2;
        Wed, 21 Feb 2018 12:34:44 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 21 Feb
 2018 13:34:44 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 21 Feb 2018 13:34:44 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@free-electrons.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "William Breathitt Gray" <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Johannes Thumshirn" <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Zwane Mwaikambo" <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Topic: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Index: AQHTqi2i4rbAU6I8X0a7F6OjU1GAX6Ouu5UA
Date:   Wed, 21 Feb 2018 12:34:44 +0000
Message-ID: <9cf6fba8-7708-bbb3-1586-e195a2b440c6@st.com>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <48F34DB30D29F349BAC1998601DA2043@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_04:,,
 signatures=0
Return-Path: <patrice.chotard@st.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: patrice.chotard@st.com
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

SGkgTWFyY3VzDQoNCk9uIDAyLzIwLzIwMTggMTA6MzEgQU0sIE1hcmN1cyBGb2xrZXNzb24gd3Jv
dGU6DQo+IC0gQWRkIFNQRFggaWRlbnRpZmllcg0KPiAtIFJlbW92ZSBib2lsZXIgcGxhdGUgbGlj
ZW5zZSB0ZXh0DQo+IC0gSWYgTU9EVUxFX0xJQ0VOU0UgYW5kIGJvaWxlciBwbGF0ZSBkb2VzIG5v
dCBtYXRjaCwgZ28gZm9yIGJvaWxlciBwbGF0ZQ0KPiAgICBsaWNlbnNlDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXJjdXMgRm9sa2Vzc29uIDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT4NCj4g
LS0tDQo+IA0KPiBOb3RlczoNCj4gICAgICB2MTogUGxlYXNlIGhhdmUgYW4gZXh0cmEgbG9vayBh
dCBtZXNvbl9neGJiX3dkdC5jDQo+IA0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3dhdGNoZG9nL3N0X2xwY193ZHQuYyBiL2RyaXZlcnMvd2F0Y2hkb2cvc3RfbHBjX3dkdC5jDQo+
IGluZGV4IGU2MTAwZTQ0N2RkOC4uMTc3ODI5YjM3OWRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3dhdGNoZG9nL3N0X2xwY193ZHQuYw0KPiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3N0X2xwY193
ZHQuYw0KPiBAQCAtMSwzICsxLDQgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wKw0KPiAgIC8qDQo+ICAgICogU1QncyBMUEMgV2F0Y2hkb2cNCj4gICAgKg0KPiBAQCAt
NSwxMSArNiw2IEBADQo+ICAgICoNCj4gICAgKiBBdXRob3I6IERhdmlkIFBhcmlzIDxkYXZpZC5w
YXJpc0BzdC5jb20+IGZvciBTVE1pY3JvZWxlY3Ryb25pY3MNCj4gICAgKiAgICAgICAgIExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IGZvciBTVE1pY3JvZWxlY3Ryb25pY3MNCj4gLSAq
DQo+IC0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yDQo+IC0gKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5jZQ0KPiAtICogYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uDQo+IC0gKiAyIG9mIHRoZSBMaWNlbmNl
LCBvciAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0KPiAgICAqLw0KPiAgIA0K
DQpGb3Igc3RfbHBjX3dkdC5jDQoNCkFja2VkLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2Uu
Y2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw0KDQo=
