Return-Path: <SRS0=GeJD=PU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF5C43387
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 08:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00A2205F4
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 08:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfALICr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:02:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58752 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALICr (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 12 Jan 2019 03:02:47 -0500
Received: by ajax-webmail-mail (Coremail) ; Sat, 12 Jan 2019 16:02:40 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [10.20.4.210]
Date:   Sat, 12 Jan 2019 16:02:40 +0800 (GMT+08:00)
From:   =?UTF-8?B?5b6Q5oiQ5Y2O?= <xuchenghua@loongson.cn>
To:     "Paul Burton" <paul.burton@mips.com>
Cc:     "Yunqiang Su" <ysu@wavecomp.com>,
        "Paul Burton" <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?UTF-8?B?6buE5rKb?= <huangpei@loongson.cn>
Subject: Re: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of
 branch between llsc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <20190111190049.pba3243a5ln5fw56@pburton-laptop>
References: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
 <20190111190049.pba3243a5ln5fw56@pburton-laptop>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: KRU4MmZvb3Rlcl90eHQ9MjgyNTo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <63891c52.59c1.16841159520.Coremail.xuchenghua@loongson.cn>
X-CM-TRANSID: QMiowPDxVuQhnzlcN9ttAA--.5952W
X-CM-SenderInfo: x0xfxv5qjk3to6or00hjvr0hdfq/
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWDJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

PiA+IEZvciBMb29uZ3NvbiAzQTEwMDAgYW5kIDNBMzAwMCwgd2hlbiBhIG1lbW9yeSBhY2Nlc3Mg
aW5zdHJ1Y3Rpb24NCj4gPiAobG9hZCwgc3RvcmUsIG9yIHByZWZldGNoKSdzIGV4ZWN1dGluZyBv
Y2N1cnMgYmV0d2VlbiB0aGUgZXhlY3V0aW9uIG9mDQo+ID4gTEwgYW5kIFNDLCB0aGUgc3VjY2Vz
cyBvciBmYWlsdXJlIG9mIFNDIGlzIG5vdCBwcmVkaWN0YWJsZS4gIEFsdGhvdWdoDQo+ID4gcHJv
Z3JhbW1lciB3b3VsZCBub3QgaW5zZXJ0IG1lbW9yeSBhY2Nlc3MgaW5zdHJ1Y3Rpb25zIGJldHdl
ZW4gTEwgYW5kDQo+ID4gU0MsIHRoZSBtZW1vcnkgaW5zdHJ1Y3Rpb25zIGJlZm9yZSBMTCBpbiBw
cm9ncmFtLW9yZGVyLCBtYXkNCj4gPiBkeW5hbWljYWxseSBleGVjdXRlZCBiZXR3ZWVuIHRoZSBl
eGVjdXRpb24gb2YgTEwvU0MsIHNvIGEgbWVtb3J5DQo+ID4gZmVuY2UoU1lOQykgaXMgbmVlZGVk
IGJlZm9yZSBMTC9MTEQgdG8gYXZvaWQgdGhpcyBzaXR1YXRpb24uDQo+ID4gDQo+ID4gU2luY2Ug
M0EzMDAwLCB3ZSBpbXByb3ZlZCBvdXIgaGFyZHdhcmUgZGVzaWduIHRvIGhhbmRsZSB0aGlzIGNh
c2UuDQo+ID4gQnV0IHdlIGxhdGVyIGRlZHVjZSBhIHJhcmVseSBjaXJjdW1zdGFuY2UgdGhhdCBz
b21lIHNwZWN1bGF0aXZlbHkNCj4gPiBleGVjdXRlZCBtZW1vcnkgaW5zdHJ1Y3Rpb25zIGR1ZSB0
byBicmFuY2ggbWlzcHJlZGljdGlvbiBiZXR3ZWVuIExML1NDDQo+ID4gc3RpbGwgZmFsbCBpbnRv
IHRoZSBhYm92ZSBjYXNlLCBzbyBhIG1lbW9yeSBmZW5jZShTWU5DKSBhdA0KPiA+IGJyYW5jaC10
YXJnZXQoaWYgaXRzIHRhcmdldCBpcyBub3QgYmV0d2VlbiBMTC9TQykgaXMgbmVlZGVkIGZvciAz
QTEwMDANCj4gPiBhbmQgM0EzMDAwLg0KPiANCj4gVGhhbmsgeW91IC0gdGhhdCBkZXNjcmlwdGlv
biBpcyByZWFsbHkgaGVscGZ1bC4NCj4gDQo+IEkgaGF2ZSBhIGZldyBmb2xsb3ctdXAgcXVlc3Rp
b25zIGlmIHlvdSBkb24ndCBtaW5kOg0KPiANCj4gIDEpIElzIGl0IGNvcnJlY3QgdG8gc2F5IHRo
YXQgdGhlIG9ubHkgY29uc2VxdWVuY2Ugb2YgdGhlIGJ1ZyBpcyB0aGF0IGFuDQo+ICAgICBTQyBt
aWdodCBmYWlsIHdoZW4gaXQgb3VnaHQgdG8gaGF2ZSBzdWNjZWVkZWQ/DQoNClVuZm9ydHVuYXRl
bHksIHRoZSBTQyBzdWNjZWVkZWQgd2hlbiBpdCBzaG91bGQgZmFpbCB0aGF0IGNhdXNlIGEgZnVu
Y3Rpb25hbCBlcnJvci4NCiANCj4gIDIpIERvZXMgdGhhdCBtZWFuIHBsYWNpbmcgYSBzeW5jIGJl
Zm9yZSB0aGUgTEwgaXMgcHVyZWx5IGEgcGVyZm9ybWFuY2UNCj4gICAgIG9wdGltaXphdGlvbj8g
aWUuIGlmIHdlIGRvbid0IGhhdmUgdGhlIHN5bmMgJiB0aGUgU0MgZmFpbHMgdGhlbg0KPiAgICAg
d2UnbGwgcmV0cnkgdGhlIExML1NDIGFueXdheSwgYW5kIHRoaXMgdGltZSBub3QgaGF2ZSB0aGUg
cmVvcmRlcmVkDQo+ICAgICBpbnN0cnVjdGlvbiBmcm9tIGJlZm9yZSB0aGUgTEwgdG8gY2F1c2Ug
YSBwcm9ibGVtLg0KDQpJdCdzIGZ1bmN0aW9uYWwgYnVnIG5vdCBwZXJmb3JtYW5jZSBidWcuDQoN
Cj4gIDMpIEluIHRoZSBzcGVjdWxhdGl2ZSBleGVjdXRpb24gY2FzZSB3b3VsZCBpdCBhbHNvIHdv
cmsgdG8gcGxhY2UgYSBzeW5jDQo+ICAgICBiZWZvcmUgdGhlIGJyYW5jaCBpbnN0cnVjdGlvbiwg
aW5zdGVhZCBvZiBhdCB0aGUgYnJhbmNoIHRhcmdldD8gSW4NCj4gICAgIHNvbWUgY2FzZXMgdGhp
cyBtaWdodCBiZSBuaWNlciBzaW5jZSB0aGUgd29ya2Fyb3VuZCB3b3VsZCBiZQ0KPiAgICAgY29u
dGFpbmVkIHdpdGhpbiB0aGUgTEwvU0MgbG9vcCwgYnV0IEkgZ3Vlc3MgaXQgY291bGQgcG90ZW50
aWFsbHkNCj4gICAgIGFkZCBtb3JlIG92ZXJoZWFkIGlmIHRoZSBicmFuY2ggaXMgY29uZGl0aW9u
YWwgJiBub3QgdGFrZW4uDQoNClllcywgaXQgbW9yZSBvdmVyaGVhZCBzbyB3ZSBkb24ndCB1c2Ug
dGhhdC4NCg0KPiAgNCkgV2hlbiB3ZSB0YWxrIGFib3V0IGJyYW5jaGVzIGhlcmUsIGlzIGl0IHJl
YWxseSBqdXN0IGJyYW5jaA0KPiAgICAgaW5zdHJ1Y3Rpb25zIHRoYXQgYXJlIGFmZmVjdGVkIG9y
IHdpbGwgdGhlIENQVSBzcGVjdWxhdGUgcGFzdCBqdW1wDQo+ICAgICBpbnN0cnVjdGlvbnMgdG9v
Pw0KIA0KTm8sIGJ1ZyBvbmx5IGV4cG9zZSB3aGVuIHJlYWwgcHJvZ3JhbS1vcmRlciBpcyBzdGls
bCBsbC9zYywgdW5jb25kaXRpb25hbCBicmFuY2ggb3IganVtcA0KaXMgbm90IHJlYWxseSBsbC9z
Yywgc28gaXQgbm90IGFmZmVjdGVkLg0KDQo+IEkganVzdCB3YW50IHRvIGJlIHN1cmUgdGhhdCB3
ZSB3b3JrIGFyb3VuZCB0aGlzIHByb3Blcmx5LCBhbmQgZG9jdW1lbnQNCj4gaXQgaW4gdGhlIGtl
cm5lbCBzbyB0aGF0IGl0J3MgY2xlYXIgdG8gZGV2ZWxvcGVycyB3aHkgdGhlIHdvcmthcm91bmQN
Cj4gZXhpc3RzICYgaG93IHRvIGF2b2lkIGludHJvZHVjaW5nIGJ1Z3MgZm9yIHRoZXNlIENQVXMg
aW4gZnV0dXJlLg0KPiANCj4gPiBPdXIgcHJvY2Vzc29yIGlzIGNvbnRpbnVhbGx5IGV2b2x2aW5n
IGFuZCB3ZSBhaW0gdG8gdG8gcmVtb3ZlIGFsbA0KPiA+IHRoZXNlIHdvcmthcm91bmQtU1lOQ3Mg
YXJvdW5kIExML1NDIGZvciBuZXctY29tZSBwcm9jZXNzb3IuIA0KPiANCj4gSSdtIHZlcnkgZ2xh
ZCB0byBoZWFyIHRoYXQgOikNCj4gDQo+IEkgaG9wZSBvbmUgZGF5IEkgY2FuIGdldCBteSBoYW5k
cyBvbiBhIG5pY2UgTG9vbmdzb24gbGFwdG9wIHRvIHRlc3QNCj4gd2l0aC4NCg0KV2UgY2FuIHNo
aXAgb25lIHRvIHlvdSBhcyBhIGdpZnQgd2hlbiB0aGUgbGFwdG9wIGlzIHN0YWJsZS4NCg0KPiBU
aGFua3MsDQo+ICAgICBQYXVsDQoNCg0KLS0NCg0KDQoNCg0K5YyX5Lqs5biC5rW35reA5Yy65Lit
5YWz5p2R546v5L+d56eR5oqA56S66IyD5Zut6b6Z6Iqv5Lqn5Lia5ZutMuWPt+alvCAxMDAwOTXn
lLXor506ICs4NiAoMTApIDYyNTQ2NjY45Lyg55yfOiArODYgKDEwKSA2MjYwMDgyNnd3dy5sb29u
Z3Nvbi5jbuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reenkeaKgOacr+aciemZ
kOWFrOWPuOeahOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWc
sOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7
peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqCDliIbl
nLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3nmoTk
v6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbp
gq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIgDQoNClRoaXMgZW1haWwg
YW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9t
IExvb25nc29uDQpUZWNobm9sb2d5IENvcnBvcmF0aW9uIExpbWl0ZWQsIHdoaWNoIGlzIGludGVu
ZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5DQp3aG9zZSBhZGRyZXNzIGlzIGxpc3Rl
ZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbg0K
YW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwg
ZGlzY2xvc3VyZSwNCnJlcHJvZHVjdGlvbiBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90
aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKQ0KaXMgcHJvaGliaXRlZC4gSWYgeW91
IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5
DQpwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0LiA=
