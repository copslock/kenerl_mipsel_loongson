Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 13:38:27 +0100 (CET)
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15658 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeBUMiTskaMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 13:38:19 +0100
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w1LCXmvE008360;
        Wed, 21 Feb 2018 13:37:22 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2g96umrhk1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 21 Feb 2018 13:37:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFB9334;
        Wed, 21 Feb 2018 12:37:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 013512A11;
        Wed, 21 Feb 2018 12:37:19 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 21 Feb
 2018 13:37:19 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 21 Feb 2018 13:37:19 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@free-electrons.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: Re: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Topic: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Index: AQHTqw9yRgoLm5yiOUq4U6rveeL+caOuuoqA
Date:   Wed, 21 Feb 2018 12:37:19 +0000
Message-ID: <9d7e8b4c-f0b5-a99d-aaaa-08d0b85ef06c@st.com>
References: <20180221122744.28300-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180221122744.28300-1-marcus.folkesson@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1772141F77F5F34F972EC007C72EDC50@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_04:,,
 signatures=0
Return-Path: <patrice.chotard@st.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62673
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

SEkgTWFyY3VzDQoNCk9uIDAyLzIxLzIwMTggMDE6MjcgUE0sIE1hcmN1cyBGb2xrZXNzb24gd3Jv
dGU6DQo+IC0gQWRkIFNQRFggaWRlbnRpZmllcg0KPiAtIFJlbW92ZSBib2lsZXIgcGxhdGUgbGlj
ZW5zZSB0ZXh0DQo+IC0gSWYgTU9EVUxFX0xJQ0VOU0UgYW5kIGJvaWxlciBwbGF0ZSBkb2VzIG5v
dCBtYXRjaCwgZ28gZm9yIGJvaWxlciBwbGF0ZQ0KPiAgICBsaWNlbnNlDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXJjdXMgRm9sa2Vzc29uIDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT4NCj4g
QWNrZWQtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5UaG9tc29uLk9wZW5zb3VyY2VAZGlhc2VtaS5j
b20+DQo+IEFja2VkLWJ5OiBDaGFybGVzIEtlZXBheCA8Y2tlZXBheEBvcGVuc291cmNlLmNpcnJ1
cy5jb20+DQo+IEFja2VkLWJ5OiBNYW5zIFJ1bGxnYXJkIDxtYW5zQG1hbnNyLmNvbT4NCj4gQWNr
ZWQtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+IEFja2Vk
LWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPiBBY2tlZC1ieTog
TmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPg0KPiBBY2tlZC1ieTogTmlj
b2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiBBY2tlZC1ieTogVGhp
ZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEVyaWMgQW5o
b2x0IDxlcmljQGFuaG9sdC5uZXQ+DQo+IC0tLQ0KPiANCj4gTm90ZXM6DQo+ICAgICAgdjM6DQo+
ICAgICAgCS0gS2VlcCBsaWNlbnNlIHRleHQgZm9yIGViYy1jMzg0X3dkdA0KPiAgICAgIHYyOg0K
PiAgICAgIAktIFB1dCBiYWNrIHJlbW92ZWQgY29weXJpZ2h0IHRleHRzIGZvciBtZXNvbl9neGJi
X3dkdCBhbmQgY29oOTAxMzI3X3dkdA0KPiAgICAgIAktIENoYW5nZSB0byBCU0QtMy1DbGF1c2Ug
Zm9yIG1lc29uX2d4YmJfd2R0DQo+ICAgICAgdjE6IFBsZWFzZSBoYXZlIGFuIGV4dHJhIGxvb2sg
YXQgbWVzb25fZ3hiYl93ZHQuYw0KPiANCg0KWy4uLl0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy93YXRjaGRvZy9zdF9scGNfd2R0LmMgYi9kcml2ZXJzL3dhdGNoZG9nL3N0X2xwY193ZHQuYw0K
PiBpbmRleCBlNjEwMGU0NDdkZDguLjE3NzgyOWIzNzlkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy93YXRjaGRvZy9zdF9scGNfd2R0LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9zdF9scGNf
d2R0LmMNCj4gQEAgLTEsMyArMSw0IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCsNCj4gICAvKg0KPiAgICAqIFNUJ3MgTFBDIFdhdGNoZG9nDQo+ICAgICoNCj4gQEAg
LTUsMTEgKzYsNiBAQA0KPiAgICAqDQo+ICAgICogQXV0aG9yOiBEYXZpZCBQYXJpcyA8ZGF2aWQu
cGFyaXNAc3QuY29tPiBmb3IgU1RNaWNyb2VsZWN0cm9uaWNzDQo+ICAgICogICAgICAgICBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiBmb3IgU1RNaWNyb2VsZWN0cm9uaWNzDQo+IC0g
Kg0KPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vcg0KPiAtICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2VuY2UNCj4gLSAqIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbg0KPiAtICogMiBvZiB0aGUgTGljZW5j
ZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4gICAgKi8NCj4gICAN
Cg0KDQpGb3Igc3RfbHBjX3dkdC5jDQoNCkFja2VkLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJp
Y2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw==
