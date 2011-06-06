Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 00:50:11 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:44196 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab1FFWuI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 00:50:08 +0200
Received: by qyk32 with SMTP id 32so1220935qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NOpL3XBkd9eFylF6C9pQ2DSfi05L5RhiVrAJRh++va4=;
        b=ryGwZjAn3oW9PXAAp23e3ERYI82avF4iVTfttJb6lUNOQi8dhCKIIv2UKS+6uSkct8
         QdTziPR4yd69P3WnHS45rcHHpney4iyY9PAt9stKYdW0u0wRqrNd5b47r+0OeLhQ6UhT
         h4FVK/pM/NN3gcc3SA7WYuqDSJ6l4K3BYh0WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qG0Ds1Da1L3olrLoKlA6UWATUBfbKEjo8D4kDkbpuBXszaOWOY3npTmC/alC5GTatP
         2ZMFpenrpau1hjUmG3aeHs9r6QuVzF2qj1HNwacUu/cZi7AU8H5aamph5Ky15Lf9JFad
         DEMnwhgPYRmf3mghNzNpUXdE/40xG3Avh5z9s=
MIME-Version: 1.0
Received: by 10.229.35.1 with SMTP id n1mr3987988qcd.84.1307400602716; Mon, 06
 Jun 2011 15:50:02 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 15:50:02 -0700 (PDT)
In-Reply-To: <4DED4F6C.5030902@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-5-git-send-email-hauke@hauke-m.de>
        <BANLkTim_TtNVmmyH5J3G0pK-vrWNL1+24A@mail.gmail.com>
        <4DED4F6C.5030902@hauke-m.de>
Date:   Tue, 7 Jun 2011 00:50:02 +0200
Message-ID: <BANLkTi=OAvaLei6v+qG4u=CDQznetiKsrA@mail.gmail.com>
Subject: Re: [RFC][PATCH 04/10] bcma: add mips driver
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-archive-position: 30276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5047

VyBkbml1IDcgY3plcndjYSAyMDExIDAwOjA2IHXFvHl0a293bmlrIEhhdWtlIE1laHJ0ZW5zCjxo
YXVrZUBoYXVrZS1tLmRlPiBuYXBpc2HFgjoKPiBPbiAwNi8wNi8yMDExIDAxOjIzIFBNLCBSYWZh
xYIgTWnFgmVja2kgd3JvdGU6Cj4+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGZvciAoaSA9IDA7IGkgPCBidXMtPm5yX2NvcmVzOyBpKyspCj4+PiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICgoMSA8PCBiY21hX2NvcmVfbWlwc19p
cnFmbGFnKCZidXMtPmNvcmVzW2ldKSkgPT0gb2xkaXJxZmxhZykgewo+Pj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBiY21hX2NvcmVf
bWlwc19zZXRfaXJxKCZidXMtPmNvcmVzW2ldLCAwKTsKPj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7Cj4+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPj4KPj4gQnJhY2VzIGZv
ciAiZm9yIi4KPiBJcyB0aGlzIG5lZWRlZCBhZnRlciB0aGUgY29kaW5nIGd1aWxkbGluZXM/IFNo
b3VsZG4ndCB0aGV5IGJlIHJlbW92ZWQgaWYKPiB0aGV5IGFyZSBub3QgbmVlZGVkPwoKV2hvb3Bz
LCBhZnRlciByZS1jaGVja2luZyBjb2Rpbmcgc3R5bGUgaXQgc2VlbXMgSSB3YXMgd3JvbmcuCgot
LSAKUmFmYcWCCg==
