Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 14:39:50 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:23638 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994559AbeBUNjmfJdlT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Feb 2018 14:39:42 +0100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2018 05:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000"; 
   d="scan'208";a="31682902"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2018 05:39:39 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 21 Feb 2018 05:39:39 -0800
Received: from lcsmsx155.ger.corp.intel.com (10.186.165.233) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 21 Feb 2018 05:39:39 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.211]) by
 LCSMSX155.ger.corp.intel.com ([169.254.12.50]) with mapi id 14.03.0319.002;
 Wed, 21 Feb 2018 15:39:37 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
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
        Johannes Thumshirn <morbidrsa@gmail.com>,
        "Andreas Werner" <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Zwane Mwaikambo" <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
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
Subject: RE: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Topic: [PATCH v3] watchdog: add SPDX identifiers for watchdog
 subsystem
Thread-Index: AQHTqw+HiXiG8yrGmEuQ9pEH/DhCeaOu22xg
Date:   Wed, 21 Feb 2018 13:39:35 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422545A@hasmsx108.ger.corp.intel.com>
References: <20180221122744.28300-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180221122744.28300-1-marcus.folkesson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzZhMjg0YzMtYzNhMS00MjVhLTlhNmEtN2M3YjY3MGM4N2UxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJQWnhDVUxWUTRXb1NEYW9nU01xZDZWaXVFQUZhUnhualZQSDBqRU5jN05XbWdHTzgzcWN2cjJ4QnVzSXNPYnVPIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.167]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <tomas.winkler@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomas.winkler@intel.com
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

PiANCj4gLSBBZGQgU1BEWCBpZGVudGlmaWVyDQo+IC0gUmVtb3ZlIGJvaWxlciBwbGF0ZSBsaWNl
bnNlIHRleHQNCj4gLSBJZiBNT0RVTEVfTElDRU5TRSBhbmQgYm9pbGVyIHBsYXRlIGRvZXMgbm90
IG1hdGNoLCBnbyBmb3IgYm9pbGVyIHBsYXRlDQo+ICAgbGljZW5zZQ0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFyY3VzIEZvbGtlc3NvbiA8bWFyY3VzLmZvbGtlc3NvbkBnbWFpbC5jb20+DQo+IEFj
a2VkLWJ5OiBBZGFtIFRob21zb24gPEFkYW0uVGhvbXNvbi5PcGVuc291cmNlQGRpYXNlbWkuY29t
Pg0KPiBBY2tlZC1ieTogQ2hhcmxlcyBLZWVwYXggPGNrZWVwYXhAb3BlbnNvdXJjZS5jaXJydXMu
Y29tPg0KPiBBY2tlZC1ieTogTWFucyBSdWxsZ2FyZCA8bWFuc0BtYW5zci5jb20+DQo+IEFja2Vk
LWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiBBY2tlZC1i
eTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gQWNrZWQtYnk6IE5l
aWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT4NCj4gQWNrZWQtYnk6IE5pY29s
YXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gQWNrZWQtYnk6IFRoaWVy
cnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+DQo+IFJldmlld2VkLWJ5OiBFcmljIEFuaG9s
dCA8ZXJpY0BhbmhvbHQubmV0Pg0KPiAtLS0NCj4gDQo+IE5vdGVzOg0KPiAgICAgdjM6DQo+ICAg
ICAJLSBLZWVwIGxpY2Vuc2UgdGV4dCBmb3IgZWJjLWMzODRfd2R0DQo+ICAgICB2MjoNCj4gICAg
IAktIFB1dCBiYWNrIHJlbW92ZWQgY29weXJpZ2h0IHRleHRzIGZvciBtZXNvbl9neGJiX3dkdCBh
bmQNCj4gY29oOTAxMzI3X3dkdA0KPiAgICAgCS0gQ2hhbmdlIHRvIEJTRC0zLUNsYXVzZSBmb3Ig
bWVzb25fZ3hiYl93ZHQNCj4gICAgIHYxOiBQbGVhc2UgaGF2ZSBhbiBleHRyYSBsb29rIGF0IG1l
c29uX2d4YmJfd2R0LmMNCj4gDQo+ICAgKg0KPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQNCj4gLSAqIHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAy
IGFzIHB1Ymxpc2hlZA0KPiAtICogYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4NCj4g
ICAqDQo+IA0KDQo+ICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3dhdGNoZG9nL21laV93ZHQuYyBiL2RyaXZlcnMvd2F0Y2hkb2cvbWVpX3dkdC5jDQo+IGlu
ZGV4IGI4MTk0YjAyYWJlMC4uODAyM2NmMjg2NTdhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3dh
dGNoZG9nL21laV93ZHQuYw0KPiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL21laV93ZHQuYw0KPiBA
QCAtMSwxNSArMSw3IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0K
PiAgLyoNCj4gICAqIEludGVsIE1hbmFnZW1lbnQgRW5naW5lIEludGVyZmFjZSAoSW50ZWwgTUVJ
KSBMaW51eCBkcml2ZXINCj4gICAqIENvcHlyaWdodCAoYykgMjAxNSwgSW50ZWwgQ29ycG9yYXRp
b24uDQo+IC0gKg0KPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQNCj4gLSAqIHVuZGVyIHRoZSB0ZXJtcyBh
bmQgY29uZGl0aW9ucyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UsDQo+IC0gKiB2
ZXJzaW9uIDIsIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0K
PiAtICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSBpdCB3
aWxsIGJlIHVzZWZ1bCwgYnV0IFdJVEhPVVQNCj4gLSAqIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+IE1FUkNIQU5UQUJJTElUWSBvcg0KPiAtICog
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuIFNlZSB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UNCj4gZm9yDQo+IC0gKiBtb3JlIGRldGFpbHMuDQo+ICAgKi8NCj4gDQo+ICAj
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+IEBAIC02ODcsNSArNjc5LDUgQEAgc3RhdGljIHN0
cnVjdCBtZWlfY2xfZHJpdmVyIG1laV93ZHRfZHJpdmVyID0gew0KPiAgbW9kdWxlX21laV9jbF9k
cml2ZXIobWVpX3dkdF9kcml2ZXIpOw0KPiANCj4gIE1PRFVMRV9BVVRIT1IoIkludGVsIENvcnBv
cmF0aW9uIik7DQo+IC1NT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ICtNT0RVTEVfTElDRU5TRSgi
R1BMIHYyIik7DQo+ICBNT0RVTEVfREVTQ1JJUFRJT04oIkRldmljZSBkcml2ZXIgZm9yIEludGVs
IE1FSSBpQU1UIHdhdGNoZG9nIik7DQoNCkFja2VkLWJ5OiBUb21hcyBXaW5rbGVyIDx0b21hcy53
aW5rbGVyQGludGVsLmNvbT4NCg0KDQoNCg==
