Return-Path: <SRS0=rYMR=PT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E2C43387
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 12:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A720874
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 12:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfAKMvr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:51:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46310 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbfAKMvr (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 11 Jan 2019 07:51:47 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 07:51:46 EST
Received: by ajax-webmail-mail (Coremail) ; Fri, 11 Jan 2019 20:45:09 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [10.20.4.210]
Date:   Fri, 11 Jan 2019 20:45:09 +0800 (GMT+08:00)
From:   huangpei@loongson.cn
To:     =?UTF-8?B?5b6Q5oiQ5Y2O?= <xuchenghua@loongson.cn>
Cc:     paul.burton@mips.com, ysu@wavecomp.com, pburton@wavecomp.com,
        linux-mips@vger.kernel.org, chenhc@lemote.com, zhangfx@lemote.com,
        wuzhangjin@gmail.com, linux-mips@linux-mips.org
Subject: Re: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of
 branch between llsc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
References: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: ecxvhGZvb3Rlcl90eHQ9MjIzMzo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4bd9b801.598a.1683cf1dab1.Coremail.huangpei@loongson.cn>
X-CM-TRANSID: QMiowPDx77_Vjzhc9whtAA--.2514W
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/1tbiAQAHAVEBqdJFnQAFsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGkgYWxsLCANCg0KICAgIEkgd2lsbCBzdWJtaXQgYSBuZXcgdmVyc2lvbiBwYXRjaCwgIHdoaWNo
IGZpeCB0aGlzIGJ1ZyAqc3VmZmljaWVudGx5IGFuZCBleGFjdGx5Ki4NCg0KPiAtLS0tLeWOn+Wn
i+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIuW+kOaIkOWNjiIgPHh1Y2hlbmdodWFAbG9vbmdz
b24uY24+DQo+IOWPkemAgeaXtumXtDogMjAxOS0wMS0xMSAyMDo0MDo0OSAo5pif5pyf5LqUKQ0K
PiDmlLbku7bkuro6IHBhdWwuYnVydG9uQG1pcHMuY29tDQo+IOaKhOmAgTogeXN1QHdhdmVjb21w
LmNvbSwgcGJ1cnRvbkB3YXZlY29tcC5jb20sIGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnLCBj
aGVuaGNAbGVtb3RlLmNvbSwgemhhbmdmeEBsZW1vdGUuY29tLCB3dXpoYW5namluQGdtYWlsLmNv
bSwgbGludXgtbWlwc0BsaW51eC1taXBzLm9yZywgIum7hOaymyIgPGh1YW5ncGVpQGxvb25nc29u
LmNuPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggMS8yXSBNSVBTOiBMb29uZ3NvbiwgYWRkIHN5bmMg
YmVmb3JlIHRhcmdldCBvZiBicmFuY2ggYmV0d2VlbiBsbHNjDQo+IA0KPiBIaSBQYXVsIEJ1cnRv
biwNCj4gDQo+IEZvciBMb29uZ3NvbiAzQTEwMDAgYW5kIDNBMzAwMCwgd2hlbiBhIG1lbW9yeSBh
Y2Nlc3MgaW5zdHJ1Y3Rpb24gKGxvYWQsIHN0b3JlLCBvciBwcmVmZXRjaCkncyBleGVjdXRpbmcg
b2NjdXJzIGJldHdlZW4gdGhlIGV4ZWN1dGlvbiBvZiBMTCBhbmQgU0MsIHRoZSBzdWNjZXNzIG9y
IGZhaWx1cmUgb2YgU0MgaXMgbm90IHByZWRpY3RhYmxlLiAgQWx0aG91Z2ggcHJvZ3JhbW1lciB3
b3VsZCBub3QgaW5zZXJ0IG1lbW9yeSBhY2Nlc3MgaW5zdHJ1Y3Rpb25zIGJldHdlZW4gTEwgYW5k
IFNDLCB0aGUgbWVtb3J5IGluc3RydWN0aW9ucyBiZWZvcmUgTEwgaW4gcHJvZ3JhbS1vcmRlciwg
bWF5IGR5bmFtaWNhbGx5IGV4ZWN1dGVkIGJldHdlZW4gdGhlIGV4ZWN1dGlvbiBvZiBMTC9TQywg
c28gYSBtZW1vcnkgZmVuY2UoU1lOQykgaXMgbmVlZGVkIGJlZm9yZSBMTC9MTEQgdG8gYXZvaWQg
dGhpcyBzaXR1YXRpb24uDQo+IA0KPiBTaW5jZSAzQTMwMDAsIHdlIGltcHJvdmVkIG91ciBoYXJk
d2FyZSBkZXNpZ24gdG8gaGFuZGxlIHRoaXMgY2FzZS4gIEJ1dCB3ZSBsYXRlciBkZWR1Y2UgYSBy
YXJlbHkgY2lyY3Vtc3RhbmNlIHRoYXQgc29tZSBzcGVjdWxhdGl2ZWx5IGV4ZWN1dGVkIG1lbW9y
eSBpbnN0cnVjdGlvbnMgZHVlIHRvIGJyYW5jaCBtaXNwcmVkaWN0aW9uIGJldHdlZW4gTEwvU0Mg
c3RpbGwgZmFsbCBpbnRvIHRoZSBhYm92ZSBjYXNlLCBzbyBhIG1lbW9yeSBmZW5jZShTWU5DKSBh
dCBicmFuY2gtdGFyZ2V0KGlmIGl0cyB0YXJnZXQgaXMgbm90IGJldHdlZW4gTEwvU0MpIGlzIG5l
ZWRlZCBmb3IgM0ExMDAwIGFuZCAzQTMwMDAuDQo+IA0KPiBPdXIgcHJvY2Vzc29yIGlzIGNvbnRp
bnVhbGx5IGV2b2x2aW5nIGFuZCB3ZSBhaW0gdG8gdG8gcmVtb3ZlIGFsbCB0aGVzZSB3b3JrYXJv
dW5kLVNZTkNzIGFyb3VuZCBMTC9TQyBmb3IgbmV3LWNvbWUgcHJvY2Vzc29yLiANCj4gDQo+IOWM
l+S6rOW4gua1t+a3gOWMuuS4reWFs+adkeeOr+S/neenkeaKgOekuuiMg+Wbrem+meiKr+S6p+S4
muWbrTLlj7fmpbwgMTAwMDk155S16K+dOiArODYgKDEwKSA2MjU0NjY2OOS8oOecnzogKzg2ICgx
MCkgNjI2MDA4MjZ3d3cubG9vbmdzb24uY27mnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpno
iq/kuK3np5HmioDmnK/mnInpmZDlhazlj7jnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDk
uo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHm
raLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDk
uo7lhajpg6jmiJbpg6gg5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu2
5Y+K5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+3
5oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu2
44CCIA0KPiANCj4gVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlk
ZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9vbmdzb24NCj4gVGVjaG5vbG9neSBDb3Jwb3JhdGlv
biBMaW1pdGVkLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0
eQ0KPiB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBpbg0KPiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3Qg
bGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLA0KPiByZXByb2R1Y3Rpb24g
b3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNp
cGllbnQocykNCj4gaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBl
cnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5DQo+IHBob25lIG9yIGVtYWlsIGltbWVk
aWF0ZWx5IGFuZCBkZWxldGUgaXQuIA0KDQoNCuWMl+S6rOW4gua1t+a3gOWMuuS4reWFs+adkeeO
r+S/neenkeaKgOekuuiMg+Wbrem+meiKr+S6p+S4muWbrTLlj7fmpbwgMTAwMDk155S16K+dOiAr
ODYgKDEwKSA2MjU0NjY2OOS8oOecnzogKzg2ICgxMCkgNjI2MDA4MjZ3d3cubG9vbmdzb24uY27m
nKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpnoiq/kuK3np5HmioDmnK/mnInpmZDlhazlj7jn
moTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3l
iJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXl
vaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6gg5YiG5Zyw5rOE6Zyy
44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC
5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa
55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CCIA0KDQpUaGlzIGVtYWlsIGFuZCBpdHMg
YXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBMb29uZ3Nv
bg0KVGVjaG5vbG9neSBDb3Jwb3JhdGlvbiBMaW1pdGVkLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eQ0Kd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUu
IEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4NCmFueSB3YXkg
KGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1
cmUsDQpyZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFu
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykNCmlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZl
IHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieQ0KcGhvbmUg
b3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdC4g
