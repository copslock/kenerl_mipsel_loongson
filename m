Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 08:43:07 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:53129 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491007Ab1F3GnD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 08:43:03 +0200
Received: by pvg20 with SMTP id 20so1643203pvg.36
        for <linux-mips@linux-mips.org>; Wed, 29 Jun 2011 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5BR/9Ztckt4XuS37wCsb1PHxTn7g2+m1a/Z17iJQFqw=;
        b=UHPkH+j3N30D4MVHq6BkdLFOczvAYUKqNjxm3n+krQU1whU6oXBBuyWDpPtvaIW5/P
         Jlqf7WiWCu3kX7jqkuUtcrQu/tuvfUKyj9B5FbJ3goyuLsTEaevum1vonDalLqZXV+dr
         Voj3uCSGnjsK92m5Yd9au4R/hiAR4yo1pDXXw=
MIME-Version: 1.0
Received: by 10.68.52.4 with SMTP id p4mr2119208pbo.127.1309416176320; Wed, 29
 Jun 2011 23:42:56 -0700 (PDT)
Received: by 10.68.46.194 with HTTP; Wed, 29 Jun 2011 23:42:56 -0700 (PDT)
In-Reply-To: <1309385518-12097-4-git-send-email-hauke@hauke-m.de>
References: <1309385518-12097-1-git-send-email-hauke@hauke-m.de>
        <1309385518-12097-4-git-send-email-hauke@hauke-m.de>
Date:   Thu, 30 Jun 2011 08:42:56 +0200
Message-ID: <BANLkTimAE-xphUYeMMzzz6B531tedo6Vkw@mail.gmail.com>
Subject: Re: [RFC v3 03/13] bcma: add functions to scan cores needed on SoCs
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-archive-position: 30557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24631

MjAxMS82LzMwIEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPjoKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGNvcmUtPmNvcmVfaW5kZXggPSBjb3JlX251bSsrOwo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgYnVzLT5ucl9jb3JlcysrOwo+ICsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHByX2luZm8oIkNvcmUgJWQgZm91bmQ6ICVzICIKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCIobWFudWYgMHglMDNYLCBpZCAweCUwM1gsIHJldiAweCUwMlgsIGNsYXNzIDB4
JVgpXG4iLAo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnVzLT5ucl9jb3Jl
cywgYmNtYV9kZXZpY2VfbmFtZSgmY29yZS0+aWQpLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgY29yZS0+Y29yZV9pbmRleCwgYmNtYV9kZXZpY2VfbmFtZSgmY29yZS0+aWQp
LAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29yZS0+aWQubWFudWYsIGNv
cmUtPmlkLmlkLCBjb3JlLT5pZC5yZXYsCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjb3JlLT5pZC5jbGFzcyk7Cj4KPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvcmUtPmNv
cmVfaW5kZXggPSBidXMtPm5yX2NvcmVzKys7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsaXN0
X2FkZCgmY29yZS0+bGlzdCwgJmJ1cy0+Y29yZXMpOwoKRGlkbid0IHlvdSBqdXN0IGNoYW5nZSBj
b3JlIGluZGV4ZXMgKDAsIDEsIC4uLikgdG8gbnVtYmVycyAoMSwgMiwKLi4uKT8gSXQgd291bGQg
YnJlYWsgZW5hYmxpbmcgSVJRcyBvbiBQQ0kuCgpEaWRuJ3QgdGVzdCBpdCBob3dldmVyIHlldCwg
SSdsbCBoYXZlIGFjY2VzcyB0byBteSBtYWNoaW5lcyB0b21vcnJvdy4KCi0tIApSYWZhxYIK
