Return-Path: <SRS0=IGt2=VV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C65BC76186
	for <linux-mips@archiver.kernel.org>; Wed, 24 Jul 2019 18:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF82D21841
	for <linux-mips@archiver.kernel.org>; Wed, 24 Jul 2019 18:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGXSw2 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:52:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGXSw2 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 24 Jul 2019 14:52:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 62B341540A488;
        Wed, 24 Jul 2019 11:52:27 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:52:26 -0700 (PDT)
Message-Id: <20190724.115226.478045379512899769.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     richardcochran@gmail.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next v3 8/8] net: mscc: PTP Hardware Clock (PHC)
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190724081715.29159-9-antoine.tenart@bootlin.com>
References: <20190724081715.29159-1-antoine.tenart@bootlin.com>
        <20190724081715.29159-9-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 11:52:27 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

RnJvbTogQW50b2luZSBUZW5hcnQgPGFudG9pbmUudGVuYXJ0QGJvb3RsaW4uY29tPg0KRGF0ZTog
V2VkLCAyNCBKdWwgMjAxOSAxMDoxNzoxNSArMDIwMA0KDQo+ICtzdGF0aWMgaW50IG9jZWxvdF9w
dHBfYWRqZmluZShzdHJ1Y3QgcHRwX2Nsb2NrX2luZm8gKnB0cCwgbG9uZyBzY2FsZWRfcHBtKQ0K
PiArew0KPiArCXN0cnVjdCBvY2Vsb3QgKm9jZWxvdCA9IGNvbnRhaW5lcl9vZihwdHAsIHN0cnVj
dCBvY2Vsb3QsIHB0cF9pbmZvKTsNCj4gKwl1MzIgdW5pdCA9IDAsIGRpcmVjdGlvbiA9IDA7DQo+
ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAgICAgICAgICAgICAgICAgICAgICBeXl5eDQo+ICsJ
dTY0IGFkaiA9IDA7DQo+ICsNCj4gKwlpZiAoIXNjYWxlZF9wcG0pDQo+ICsJCWdvdG8gZGlzYWJs
ZV9hZGo7DQogLi4uDQo+ICtkaXNhYmxlX2FkajoNCj4gKwlvY2Vsb3Rfd3JpdGUob2NlbG90LCAw
LCBQVFBfQ0xLX0NGR19BREpfQ0ZHKTsNCj4gKw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
Jm9jZWxvdC0+cHRwX2Nsb2NrX2xvY2ssIGZsYWdzKTsNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl4NCg0KDQpEaWQgR0NDIHJlYWxs
eSBub3Qgd2FybiBhYm91dCB0aGlzIGluIHlvdXIgYnVpbGQgbGlrZSBpdCBkaWQgaW1tZWRpYXRl
bHkNCm9uIG1pbmU/DQoNCmRyaXZlcnMvbmV0L2V0aGVybmV0L21zY2Mvb2NlbG90LmM6IEluIGZ1
bmN0aW9uIKFvY2Vsb3RfcHRwX2FkamZpbmWiOg0KLi9pbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6
Mjg4OjM6IHdhcm5pbmc6IKFmbGFnc6IgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlz
IGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQogICBfcmF3X3NwaW5fdW5sb2NrX2ly
cXJlc3RvcmUobG9jaywgZmxhZ3MpOyBcDQogICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cg0KUGxlYXNlIGZpeCB0aGlzIGFuZCB3aGVuIHlvdSByZXNwaW4gcGxlYXNlIGp1c3QgZWxpZGUg
dGhlIE1JUFMgdHJlZQ0KcGF0Y2hlcyBhbmQganVzdCBrZWVwIGFsbCB0aGUgb25lcyB0aGF0IEkg
c2hvdWxkIGFwcGx5IHRvIG5ldC1uZXh0Lg0KDQpUaGFuayB5b3UuDQo=
