Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2012 06:30:00 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:47046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901166Ab2F1E3s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2012 06:29:48 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A346958469F;
        Wed, 27 Jun 2012 21:29:42 -0700 (PDT)
Date:   Wed, 27 Jun 2012 21:29:41 -0700 (PDT)
Message-Id: <20120627.212941.485325944406335522.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, david.daney@cavium.com
Subject: Re: [PATCH v2 0/4] netdev/phy: 10G PHY support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.97 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-archive-position: 33861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

RnJvbTogRGF2aWQgRGFuZXkgPGRkYW5leS5jYXZtQGdtYWlsLmNvbT4NCkRhdGU6IFdlZCwgMjcg
SnVuIDIwMTIgMTA6MzM6MzQgLTA3MDANCg0KPiBGcm9tOiBEYXZpZCBEYW5leSA8ZGF2aWQuZGFu
ZXlAY2F2aXVtLmNvbT4NCj4gDQo+IFRoZSBvbmx5IG5vbi1jb3NtZXRpYyBjaGFuZ2UgZnJvbSB2
MSBpcyB0byBwYXNzIGFuIGFkZGl0aW9uYWwgYXJndW1lbnQNCj4gdG8gZ2V0X3BoeV9kZXZpY2Uo
KSB0aGF0IGluZGljYXRlcyB0aGF0IHRoZSBQSFkgdXNlcyA4MDIuMyBjbGF1c2UgNDUNCj4gc2ln
bmFsaW5nLCBwcmV2aW91c2x5IEkgaGFkIGJlZW4gdXNpbmcgYSBoaWdoIG9yZGVyIGJpdCBvZiB0
aGUgYWRkcg0KPiBwYXJhbWV0ZXIgZm9yIHRoaXMuDQo+IA0KPiBUaGVyZSBhcmUgYWxzbyBjaGFu
Z2VzIGZyb20gdjEgaW4gdGhlIGNvZGUgYW5kIGNvbW1lbnQgZm9ybWF0dGluZy4NCj4gVGhlc2Ug
c2hvdWxkIG5vdyBiZSBjbG9zZXIgdG8gd2hhdCBEYXZpZCBNaWxsZXIgcHJlZmVycy4NCg0KQXBw
bGllZCwgYnV0IEkgaGFkIHRvIGFkZCB0aGUgZm9sbG93aW5nIHdhcm5pbmcgZml4dXA6DQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpwaHk6IEZpeCB3YXJuaW5nIGluIGdldF9waHlfZGV2aWNlKCku
DQoNCmRyaXZlcnMvbmV0L3BoeS9waHlfZGV2aWNlLmM6IEluIGZ1bmN0aW9uIKFnZXRfcGh5X2Rl
dmljZaI6DQpkcml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5jOjM0MDoxNDogd2FybmluZzogoXBo
eV9pZKIgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJl
LXVuaW5pdGlhbGl6ZWRdDQoNCkdDQyBjYW4ndCBzZWUgdGhhdCB3aGVuIHdlIHJldHVybiB6ZXJv
IHdlIGFsd2F5cyBpbml0aWFsaXplDQpwaHlfaWQgYW5kIHRoYXQncyB0aGUgb25seSBwYXRoIHdo
ZXJlIHdlIHVzZSBpdC4NCg0KSW5pdGlhbGl6ZSBwaHlfaWQgdG8gemVybyB0byBzaHV0IGl0IHVw
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
DQotLS0NCiBkcml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5jIHwgICAgNCArKy0tDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3BoeS9waHlfZGV2aWNlLmMgYi9kcml2ZXJzL25ldC9waHkvcGh5X2Rldmlj
ZS5jDQppbmRleCBlZjRjZGVlLi40N2UwMmU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvcGh5
L3BoeV9kZXZpY2UuYw0KKysrIGIvZHJpdmVycy9uZXQvcGh5L3BoeV9kZXZpY2UuYw0KQEAgLTMy
Nyw5ICszMjcsOSBAQCBzdGF0aWMgaW50IGdldF9waHlfaWQoc3RydWN0IG1paV9idXMgKmJ1cywg
aW50IGFkZHIsIHUzMiAqcGh5X2lkLA0KICAqLw0KIHN0cnVjdCBwaHlfZGV2aWNlICpnZXRfcGh5
X2RldmljZShzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBpbnQgYWRkciwgYm9vbCBpc19jNDUpDQogew0K
LQlzdHJ1Y3QgcGh5X2RldmljZSAqZGV2ID0gTlVMTDsNCi0JdTMyIHBoeV9pZDsNCiAJc3RydWN0
IHBoeV9jNDVfZGV2aWNlX2lkcyBjNDVfaWRzID0gezB9Ow0KKwlzdHJ1Y3QgcGh5X2RldmljZSAq
ZGV2ID0gTlVMTDsNCisJdTMyIHBoeV9pZCA9IDA7DQogCWludCByOw0KIA0KIAlyID0gZ2V0X3Bo
eV9pZChidXMsIGFkZHIsICZwaHlfaWQsIGlzX2M0NSwgJmM0NV9pZHMpOw0KLS0gDQoxLjcuMTAu
Mg0KDQo=
