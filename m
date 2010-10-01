Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 10:47:20 +0200 (CEST)
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:39971 "EHLO
        eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab0JAIrQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 10:47:16 +0200
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob101.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKWf9Zjt+ldnp40V76pIxZ1gtuthXw9m@postini.com; Fri, 01 Oct 2010 08:47:15 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D3E6B155;
        Fri,  1 Oct 2010 08:46:16 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2089FBAB;
        Fri,  1 Oct 2010 08:46:16 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 6837824C075;
        Fri,  1 Oct 2010 10:46:10 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.230.100.3]) by
 exdcvycastm022.EQ1STM.local ([10.230.100.30]) with mapi; Fri, 1 Oct 2010
 10:46:15 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Trilok Soni <soni.trilok@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Bill Gatliff <bgat@billgatliff.com>,
        "broonie@opensource.wolfsonmicro.com" 
        <broonie@opensource.wolfsonmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>,
        STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Samuel Ortiz <sameo@linux.intel.com>
Date:   Fri, 1 Oct 2010 10:46:15 +0200
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Thread-Topic: [PATCH 1/7] pwm: Add pwm core driver
Thread-Index: ActhPEcr6UpPQqOQQ1Cu0ctftJfxHAABcR/g
Message-ID: <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
        <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
        <4CA1AD2B.8000905@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
        <4CA1BC16.3020702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
        <4CA25841.4090702@metafoo.de>
        <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
        <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
        <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
        <AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
        <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
 <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
In-Reply-To: <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

PiBPbiBGcmksIE9jdCAxLCAyMDEwIGF0IDQ6MjUgUE0sIEFydW4gTVVSVEhZDQo+IDxhcnVuLm11
cnRoeUBzdGVyaWNzc29uLmNvbT4gd3JvdGU6DQo+ID4gWW91IGNhbiBoYXZlIGEgbG9vayBhdCB0
aGUgcHdtX2NvbmZpZ19ub3NsZWVwKCkscHdtX3NldF9wb2xhcml0eSgpLA0KPiA+IHB3bV9zeW5j
aHJvbml6ZSgpLHB3bV91bnN5bmNocm9uaXplKCksIHB3bV9zZXRfaGFuZGxlcigpIGV0Yy4NCj4g
PiBUaGVzZSBhcmUgbm90IGJlaW5nIHVzZWQgYnkgdGhlIGV4c3RpbmcgcHdtIGRyaXZlcnMgZXhj
ZXB0IEF0bWVsIHB3bS4NCj4gSG93IHdvdWxkIHlvdXIgJ3NpbXBsZScgZHJpdmVyIGhhbmRsZSBB
dG1lbCB0aGVuID8NCj4gV2hhdCBpZiBmdXR1cmUncyBTb0NzIHN0YXJ0IHByb3ZpZGluZyB0aG9z
ZSAnYWR2YW5jZScgZmVhdHVyZXMgbGlrZQ0KPiBBdG1lbCdzID8NCj4gDQpUaGUgcHdtIGNvcmUg
ZHJpdmVyIGlzIHRoZSBpbnRlcnNlY3Rpb24gb2YgYWxsIHB3bSBkcml2ZXJzIGFuZCBub3QgdW5p
b24NCm9mIGFsbCBwd20gZHJpdmVyLiBJIHJlZmVyIHRoaXMgYXMgc2ltcGxlIHB3bSBjb3JlIGRy
aXZlciAvIGZyYW1ld29yay4NCkF0bWVsIHB3bSBpcyBvZiBhIHNlcGFyYXRlIGNsYXNzaWZpY2F0
aW9uLg0KSXQgaW5jbHVkZXMgR1BJTyBhbHNvLiBUaG91Z2gsIEF0bWVsIGNhbiB1c2UgdGhlIHB3
bSBjb3JlIGRyaXZlciBmcmFtZXdvcmsNCmZvciBmdW5jdGlvbmFsaXRpZXMgbGlrZSBwd21fZW5h
YmxlLCBwd21fZGlzYWJsZSwgcHdtX2NvbmZpZywgZXRjIGFuZCByZW1haW5pbmcNCmZ1bmN0aW9u
YWxpdGllcyBzcGVjaWZpYyB0byBBdG1lbCB3aWxsIGJlIGhhbmRsZWQgaW4gQXRsbWVsIHB3bSBk
cml2ZXIgYW5kDQp3aWxsIG5vdCBiZSBleHBvc2VkIHRvIHRoZSBlbnRpcmUga2VybmVsLg0KSXRz
IHRoYXQgdGhlIHByZXNlbnQgZGF5IHB3bSBkZXZpY2UgdGhhdCBoYXMgYmVlbiBtYWRlIGVhc3kg
dGhvdWdoLCBieSBwcm92aWRpbmcNCnRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkuDQoNCj4gPiBJIG1l
YW4gbm90IHRoZSBmdW5jdGlvbnMgYnV0IHRoZSBmdW5jdGlvbmFsaXR5Lg0KPiA+IFBXTSBpcyBh
IHNpbXBsZSBkZXZpY2UgYW5kIG1vc3Qgb2YgaXRzIGNsaWVudHMgYXJlIGNvbnRyb2xsaW5nDQo+
IGludGVuc2l0eQ0KPiA+IG9mIGJhY2tsaWdodCwgbGVkcywgdmlicmF0b3IgZXRjLg0KPiA+IEkg
ZG9uJ3QgdGhpbmsgdGhlc2UgY29tcGxleCBmdW5jdGlvbmFsaXR5IGFyZSByZXF1aXJlZC4NCj4g
b2ggZGVhciAhDQpIZXJlIEkgbWVhbiB3aHkgc2hvdWxkIGFsbCB0aG9zZSBmdW5jdGlvbiBiZSBl
eHBvc2VkIHRvIHRoZSBlbnRpcmUga2VybmVsLA0KYXMgbW9zdCBvZiB0aGUgcHdtIGRldmljZXMg
ZG8gbm90IHVzZSB0aGVtLg0KDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpBcnVuIFIgTXVydGh5DQot
LS0tLS0tLS0tLS0NCg==
