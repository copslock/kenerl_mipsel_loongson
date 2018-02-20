Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 11:29:25 +0100 (CET)
Received: from mail1.bemta5.messagelabs.com ([195.245.231.147]:61211 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbeBTK3R3IKzl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 11:29:17 +0100
Received: from [85.158.139.51] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-11.bemta-5.messagelabs.com id 06/31-24846-A78FB8A5; Tue, 20 Feb 2018 10:29:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTa0xbZRjmO7eesXaeFZZ+Iy5uDbgoga2SxTf
  GBOJictw0zsRExcssrtJGWrCnM0wTLNdxGQPGFNaxyYAhUgQsIK4ikAa5OFkDTIYTGYxuWUcH
  CoT7xR6abfjv+b7n8j7vj5cl5alsEKtJNGmMBnWckvGnPrhyOSLs84Wc6P0/nAyArnozA5mD5
  QS4HLkk3J3pQlA16KHg+9xfKfgnJZ2E0Zo6EtqTBxAsTXZIYPDBMA23eisZWHaukpBmKaOgwj
  UmgeHaHhLyxidIWDzZSIDTWS+BsyvfElB6fivYxgdpGLCXMDCQ2ocg/6szEij4y6sodrYSkDV
  rYWCotlUCrku/E7A8v0bDzzeuIVgYKyLgx5leEgrqRmhISYuAUXcbgjtFSTDpfhu+m1skodHs
  YKC54RIJM1NtNJR0/4GgpqNcAnfONTAwaXUhuNeogDMOI9iqhhhYtF/0rnYqCXKnLjOwvpTqb
  exwEjDuXiPhl5EZBJMXCiRRL/ApU50MPzWULuEv1nzBW271Mnx2z2mCr79tpfkyt5niXbY+xO
  fVztD8FcvfEt5uT5bwTTcP8OUtboLv+7eT5E950mjeVp3FHFFG0zpDTHzih7TWMz2NEqaDE9M
  vrBBm1BicjfxZOVeJ8NJqJspGW1iGA1zYPcqIRCBX+wS2tpZS4oPkRhi87rlBiaoA7hAuzC7Z
  cARyh/HI7G3Ch5/D9RUeUsQUF4LzbK1ezLIy7gh2Ze4VoZyLxFfzo0TFFi4KDzQUb6QgbheeT
  bZuOElOgW+6vtlIxByHK1qcpA/vwO7xNdqHn8LNc8sSH47EEyOTlBiPuX34dLLg+1bh6q/bKR
  9+Hpd35dGihOSewXX2fb5Je/DZnLGNFBm3Hfecc1H5SGHZVMLy2GHZ5LBscpQiqhrtFTTGzzT
  GMFV4jFEXqzXp1bq4MNX+A+F6jSCoYzVx6hgh/KN4vQ15T+FLPz/0E0rJPehAO1lCuUN2LDgn
  Wr4tJv7YCa1a0B41Ho/TCA70JMsqsax/3sttN2piNYkf6+K89/SQxqxUGSgrE2mZkKDWC7pYH
  /UbimCH7k1kkGxjpSeDlFOGeIMmSCE7LEo5Uao9bngU9PA2+9GuoAAZ8vPzk0sTNEa9zvR//j
  5SsEgZIMsTU6Q6g+nRvPveKoS3ijUwS6xiUj+mgsxIum7OaHKHCVrVu++8+Fpo2sTCSlNzlcx
  EdQ9HtHW+FVh8tYgu3JPVnrT7gbrZVfzJwVe3BmfHLiyfNaQKOSFNhwi79fXR6xNPa669srsp
  tHqK8FfNtwdUuanVnXqtUwg98endbSGRc0MVaUfffEM6Jn256PqfL73fUmZh3pvu6FcgJSVo1
  apnSaOg/g9N9jMRlgQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-180.messagelabs.com!1519122554!109965811!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14868 invoked from network); 20 Feb 2018 10:29:14 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-9.tower-180.messagelabs.com with AES128-SHA encrypted SMTP; 20 Feb 2018 10:29:14 -0000
Received: from SW-EX-MBX01.diasemi.com ([169.254.3.235]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0248.002; Tue,
 20 Feb 2018 10:29:13 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
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
        Support Opensource <Support.Opensource@diasemi.com>,
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
Subject: RE: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Topic: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Index: AQHTqi2hRI3PLm3ZAE2GGaap27+ISaOtFfmA
Date:   Tue, 20 Feb 2018 10:29:12 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C3ADA@SW-EX-MBX01.diasemi.com>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 20/02/2018 08:25:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Adam.Thomson.Opensource@diasemi.com
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

T24gMjAgRmVicnVhcnkgMjAxOCAwOTozMSwgTWFyY3VzIEZvbGtlc3NvbiB3cm90ZToNCg0KPiAt
IEFkZCBTUERYIGlkZW50aWZpZXINCj4gLSBSZW1vdmUgYm9pbGVyIHBsYXRlIGxpY2Vuc2UgdGV4
dA0KPiAtIElmIE1PRFVMRV9MSUNFTlNFIGFuZCBib2lsZXIgcGxhdGUgZG9lcyBub3QgbWF0Y2gs
IGdvIGZvciBib2lsZXIgcGxhdGUNCj4gICBsaWNlbnNlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJjdXMgRm9sa2Vzc29uIDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT4NCj4gLS0tDQoNClsu
Li5dDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDUyX3dkdC5jIGIvZHJp
dmVycy93YXRjaGRvZy9kYTkwNTJfd2R0LmMNCj4gaW5kZXggZDZkNTAwNmVmYTcxLi5lMjYzYmFk
OTk1NzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDUyX3dkdC5jDQo+ICsr
KyBiL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDUyX3dkdC5jDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICAvKg0KPiAgICogU3lzdGVt
IG1vbml0b3JpbmcgZHJpdmVyIGZvciBEQTkwNTIgUE1JQ3MuDQo+ICAgKg0KPiBAQCAtNSwxMSAr
Niw2IEBADQo+ICAgKg0KPiAgICogQXV0aG9yOiBBbnRob255IE9sZWNoIDxBbnRob255Lk9sZWNo
QGRpYXNlbWkuY29tPg0KPiAgICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+IC0gKiBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eQ0KPiAtICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3INCj4gLSAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uDQo+IC0gKg0KPiAgICovDQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9kYTkwNTVfd2R0LmMgYi9kcml2ZXJzL3dhdGNo
ZG9nL2RhOTA1NV93ZHQuYw0KPiBpbmRleCA1MGJkZDEwMjIxODYuLjI2YTViMjk4NDA5NCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9kYTkwNTVfd2R0LmMNCj4gKysrIGIvZHJpdmVy
cy93YXRjaGRvZy9kYTkwNTVfd2R0LmMNCj4gQEAgLTEsMyArMSw0IEBADQo+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gIC8qDQo+ICAgKiBTeXN0ZW0gbW9uaXRvcmlu
ZyBkcml2ZXIgZm9yIERBOTA1NSBQTUlDcy4NCj4gICAqDQo+IEBAIC01LDExICs2LDYgQEANCj4g
ICAqDQo+ICAgKiBBdXRob3I6IERhdmlkIERhanVuIENoZW4gPGRjaGVuQGRpYXNlbWkuY29tPg0K
PiAgICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+IC0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPiAtICogdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3INCj4gLSAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+IC0gKg0KPiAg
ICovDQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy93YXRjaGRvZy9kYTkwNjJfd2R0LmMgYi9kcml2ZXJzL3dhdGNoZG9nL2RhOTA2Ml93ZHQu
Yw0KPiBpbmRleCA4MTRkZmY2MDQ1YTQuLmEwMDE3ODJiYmZkYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy93YXRjaGRvZy9kYTkwNjJfd2R0LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9kYTkw
NjJfd2R0LmMNCj4gQEAgLTEsMTYgKzEsOCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjArDQo+ICAvKg0KPiAgICogV2F0Y2hkb2cgZGV2aWNlIGRyaXZlciBmb3IgREE5
MDYyIGFuZCBEQTkwNjEgUE1JQ3MNCj4gICAqIENvcHlyaWdodCAoQykgMjAxNSAgRGlhbG9nIFNl
bWljb25kdWN0b3IgTHRkLg0KPiAgICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCj4gLSAqIG1vZGlmeSBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+IC0gKiBhcyBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24g
Mg0KPiAtICogb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uDQo+IC0gKg0KPiAtICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+IC0gKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPiAtICogTUVSQ0hBTlRB
QklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPiAt
ICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4gICAqLw0K
PiANCj4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
d2F0Y2hkb2cvZGE5MDYzX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9kYTkwNjNfd2R0LmMNCj4g
aW5kZXggMmEyMGZjMTYzZWQwLi5iMTdhYzFiYjFmMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
d2F0Y2hkb2cvZGE5MDYzX3dkdC5jDQo+ICsrKyBiL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDYzX3dk
dC5jDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjArDQo+ICAvKg0KPiAgICogV2F0Y2hkb2cgZHJpdmVyIGZvciBEQTkwNjMgUE1JQ3MuDQo+
ICAgKg0KPiBAQCAtNSwxMCArNiw2IEBADQo+ICAgKg0KPiAgICogQXV0aG9yOiBNYXJpdXN6IFdv
anRhc2lrIDxtYXJpdXN6LndvanRhc2lrQGRpYXNlbWkuY29tPg0KPiAgICoNCj4gLSAqIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSAgaXQgYW5kL29y
IG1vZGlmeSBpdA0KPiAtICogdW5kZXIgIHRoZSB0ZXJtcyBvZiAgdGhlIEdOVSBHZW5lcmFsICBQ
dWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlDQo+IC0gKiBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb247ICBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSAgTGljZW5zZSwgb3IgKGF0IHlvdXIN
Cj4gLSAqIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+ICAgKi8NCg0KRm9yIERpYWxvZyBk
cml2ZXJzLA0KDQpBY2tlZC1ieTogQWRhbSBUaG9tc29uIDxBZGFtLlRob21zb24uT3BlbnNvdXJj
ZUBkaWFzZW1pLmNvbT4NCg==
