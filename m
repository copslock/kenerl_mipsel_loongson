Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 09:13:20 +0200 (CEST)
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37703 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990510AbdEaHNMBZ6dO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 09:13:12 +0200
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v4V79I2B022001;
        Wed, 31 May 2017 09:11:49 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-.pphosted.com with ESMTP id 2apxk3wr4g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 May 2017 09:11:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF9B838;
        Wed, 31 May 2017 07:11:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 636B11088;
        Wed, 31 May 2017 07:11:42 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 31 May
 2017 09:11:42 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1178.000; Wed, 31 May 2017 09:11:41 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Michal Simek" <monstr@monstr.eu>, John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?utf-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Carlo Caione" <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        "Barry Song" <baohua@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Noam Camus <noamca@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/OXNAS platform support" 
        <linux-oxnas@lists.tuxfamily.org>
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
Thread-Topic: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
Thread-Index: AQHS1s/pfBonD/tpTEu9ID3UNbyQJqIN6yUA
Date:   Wed, 31 May 2017 07:11:41 +0000
Message-ID: <e6ebd144-414a-51da-d2b4-8d7877eb5d99@st.com>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <267EBEA7178F2C4F80A2CFADCAB2FBA3@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-05-31_02:,,
 signatures=0
Return-Path: <patrice.chotard@st.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58081
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

SGkgRGFuaWVsDQoNCk9uIDA1LzI3LzIwMTcgMTE6NTggQU0sIERhbmllbCBMZXpjYW5vIHdyb3Rl
Og0KPiBUaGUgQ0xPQ0tTT1VDRV9PRl9ERUNMQVJFIG1hY3JvIGlzIHVzZWQgd2lkZWx5IGZvciB0
aGUgdGltZXJzIHRvIGRlY2xhcmUgdGhlDQo+IGNsb2Nrc291cmNlIGF0IGVhcmx5IHN0YWdlLiBI
b3dldmVyLCB0aGlzIG1hY3JvIGlzIGFsc28gdXNlZCB0byBpbml0aWFsaXplDQo+IHRoZSBjbG9j
a2V2ZW50IGlmIGFueSwgb3IgdGhlIGNsb2NrZXZlbnQgb25seS4NCj4gDQo+IEl0IHdhcyBvcmln
aW5hbGx5IHN1Z2dlc3RlZCB0byBkZWNsYXJlIGFub3RoZXIgbWFjcm8gdG8gaW5pdGlhbGl6ZSBh
DQo+IGNsb2NrZXZlbnQsIHNvIGluIG9yZGVyIHRvIHNlcGFyYXRlIHRoZSB0d28gZW50aXRpZXMg
ZXZlbiB0aGV5IGJlbG9uZyB0byB0aGUNCj4gc2FtZSBJUC4gVGhpcyB3YXMgbm90IGFjY2VwdGVk
IGJlY2F1c2Ugb2YgdGhlIGltcGFjdCBvbiB0aGUgRFQgd2hlcmUgc3BsaXR0aW5nDQo+IGEgY2xv
Y2tzb3VyY2UvY2xvY2tldmVudCBkZWZpbml0aW9uIGRvZXMgbm90IG1ha2Ugc2Vuc2UgYXMgaXQg
aXMgYSBMaW51eA0KPiBjb25jZXB0IG5vdCBhIGhhcmR3YXJlIGRlc2NyaXB0aW9uLg0KPiANCj4g
T24gdGhlIG90aGVyIHNpZGUsIHRoZSBjbG9ja3NvdXJjZSBoYXMgbm90IGludGVycnVwdCBkZWNs
YXJlZCB3aGlsZSB0aGUNCj4gY2xvY2tldmVudCBoYXMsIHNvIGl0IGlzIGVhc3kgZnJvbSB0aGUg
ZHJpdmVyIHRvIGtub3cgaWYgdGhlIGRlc2NyaXB0aW9uIGlzDQo+IGZvciBhIGNsb2NrZXZlbnQg
b3IgYSBjbG9ja3NvdXJjZSwgSU9XIGl0IGNvdWxkIGJlIGltcGxlbWVudGVkIGF0IHRoZSBkcml2
ZXINCj4gbGV2ZWwuDQo+IA0KPiBTbyBpbnN0ZWFkIG9mIGRlYWxpbmcgd2l0aCBhIG5hbWVkIGNs
b2Nrc291cmNlIG1hY3JvLCBsZXQncyB1c2UgYSBtb3JlIGdlbmVyaWMNCj4gb25lOiBUSU1FUl9P
Rl9ERUNMQVJFLg0KPiANCj4gVGhlIHBhdGNoIGhhcyBub3QgZnVuY3Rpb25hbCBjaGFuZ2VzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFy
by5vcmc+DQo+IC0tLQ0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291
cmNlL2Nsa3NyY19zdF9scGMuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvY2xrc3JjX3N0X2xwYy5j
DQo+IGluZGV4IDAzY2M0OTIuLmExZDAxZWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xvY2tz
b3VyY2UvY2xrc3JjX3N0X2xwYy5jDQo+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvY2xrc3Jj
X3N0X2xwYy5jDQo+IEBAIC0xMzIsNCArMTMyLDQgQEAgc3RhdGljIGludCBfX2luaXQgc3RfY2xr
c3JjX29mX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+ICAgDQo+ICAgCXJldHVy
biByZXQ7DQo+ICAgfQ0KPiAtQ0xPQ0tTT1VSQ0VfT0ZfREVDTEFSRShkZGF0YSwgInN0LHN0aWg0
MDctbHBjIiwgc3RfY2xrc3JjX29mX3JlZ2lzdGVyKTsNCj4gK1RJTUVSX09GX0RFQ0xBUkUoZGRh
dGEsICJzdCxzdGloNDA3LWxwYyIsIHN0X2Nsa3NyY19vZl9yZWdpc3Rlcik7DQoNCkZvciB0aGUg
U1RpIGRyaXZlcjoNCg0KQWNrZWQtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJk
QHN0LmNvbT4NCg0KVGhhbmtzDQoNCg==
