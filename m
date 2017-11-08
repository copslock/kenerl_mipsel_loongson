Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:58:22 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:58707 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993929AbdKHUxoDu9cC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Nov 2017 21:53:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174423; x=1541710423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UTW4u3L4kzH4LZ86KJ0t+rBAknMYdPg19xuZD8x9YDo=;
  b=CC/SfoOBCYqSb4FQ2c/X0MsGnk8J/eJ/F676WYGnKj+1HdBODah/CPzl
   td/hwj87pXg3kXLwDjBsPVSVMDCqJJcqdGSVmFUYPfBfa33UVrRO//81F
   dr2LopupgFB8jHqAr3Or3PPoaboER0bLKM/NMm6vVSEK5OBYGTqJ1+hRX
   I=;
Received: from unknown (HELO fldsmtpi03.verizon.com) ([166.68.71.145])
  by fldsmtpe03.verizon.com with ESMTP; 08 Nov 2017 20:53:40 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi03.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174346; x=1541710346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UTW4u3L4kzH4LZ86KJ0t+rBAknMYdPg19xuZD8x9YDo=;
  b=t0hY8NIiERV13cq+xGfgEtjd3f4hODoq504ETNtNDcrRmCcDgdOCcj/y
   C+LpnbfUswvGIzuK7qH9JrSU4+qEXSI4ehFJS7Tb741EFZigvVTQntuSt
   Gd5MwUlhrC4Rkh9rmKNNs3HCk9tDQrHRrXyy7sapw69L952KXmimfl2o2
   s=;
Received: from endeavour.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.163])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174343; x=1541710343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UTW4u3L4kzH4LZ86KJ0t+rBAknMYdPg19xuZD8x9YDo=;
  b=QInEfKg0e/F3T9sR0UgQOM1UTdMhMuwyD3mB65dujiOIgu6bw8wEMX2u
   RD/06w/VS6YmlxTrk2Dmfi3sEnRuxdHWo0E82xVEuadgzGepgd7TzeIMh
   4jFQbgFHJOx4ZUB8CU71u+1fYaL4ovAEi54JBL94A0NKNRNtu7MbfrP7L
   I=;
X-Host: endeavour.tdc.vzwcorp.com
Received: from ohtwi1exh002.uswin.ad.vzwcorp.com ([10.144.218.44])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:52:23 +0000
Received: from tbwexch03apd.uswin.ad.vzwcorp.com (153.114.162.27) by
 OHTWI1EXH002.uswin.ad.vzwcorp.com (10.144.218.44) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:52:23 -0500
Received: from OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) by
 tbwexch03apd.uswin.ad.vzwcorp.com (153.114.162.27) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:52:22 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:52:21 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:52:21 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.4 38/39] MIPS: Netlogic: Exclude
 netlogic,xlp-pic code from XLR builds
Thread-Topic: [PATCH AUTOSEL for-4.4 38/39] MIPS: Netlogic: Exclude
 netlogic,xlp-pic code from XLR builds
Thread-Index: AQHTWNM+pi2viY20KkiMj9aoN0DKJA==
Date:   Wed, 8 Nov 2017 20:50:43 +0000
Message-ID: <20171108205027.27525-38-alexander.levin@verizon.com>
References: <20171108205027.27525-1-alexander.levin@verizon.com>
In-Reply-To: <20171108205027.27525-1-alexander.levin@verizon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70F14C3CD84974CA8DB1931A123F7B6@vzwcorp.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <alexander.levin@one.verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@one.verizon.com
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

RnJvbTogUGF1bCBCdXJ0b24gPHBhdWwuYnVydG9uQGltZ3RlYy5jb20+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IDk3OTkyNzBhZmZjNTM0MTRkYTk2ZTc3ZTQ1NGE1NjE2YjM5Y2RhYjAgXQ0KDQpDb2Rl
IGluIGFyY2gvbWlwcy9uZXRsb2dpYy9jb21tb24vaXJxLmMgd2hpY2ggaGFuZGxlcyB0aGUgWExQ
IFBJQyBmYWlscw0KdG8gYnVpbGQgaW4gWExSIGNvbmZpZ3VyYXRpb25zIGR1ZSB0byBjcHVfaXNf
eGxwOXh4IG5vdCBiZWluZyBkZWZpbmVkLA0KbGVhZGluZyB0byB0aGUgZm9sbG93aW5nIGJ1aWxk
IGZhaWx1cmU6DQoNCiAgICBhcmNoL21pcHMvbmV0bG9naWMvY29tbW9uL2lycS5jOiBJbiBmdW5j
dGlvbiDigJh4bHBfb2ZfcGljX2luaXTigJk6DQogICAgYXJjaC9taXBzL25ldGxvZ2ljL2NvbW1v
bi9pcnEuYzoyOTg6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uDQogICAgb2YgZnVuY3Rp
b24g4oCYY3B1X2lzX3hscDl4eOKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJh
dGlvbl0NCiAgICAgIGlmIChjcHVfaXNfeGxwOXh4KCkpIHsNCiAgICAgIF4NCg0KQWx0aG91Z2gg
dGhlIGNvZGUgd2FzIGNvbmRpdGlvbmFsIHVwb24gQ09ORklHX09GIHdoaWNoIGlzIGluZGlyZWN0
bHkNCnNlbGVjdGVkIGJ5IENPTkZJR19OTE1fWExQX0JPQVJEIGJ1dCBub3QgQ09ORklHX05MTV9Y
TFJfQk9BUkQsIHRoZQ0KZmFpbGluZyBYTFIgd2l0aCBDT05GSUdfT0YgY29uZmlndXJhdGlvbiBj
YW4gYmUgY29uZmlndXJlZCBtYW51YWxseSBvcg0KYnkgcmFuZGNvbmZpZy4NCg0KRml4IHRoZSBi
dWlsZCBmYWlsdXJlIGJ5IG1ha2luZyB0aGUgYWZmZWN0ZWQgWExQIFBJQyBjb2RlIGNvbmRpdGlv
bmFsDQp1cG9uIENPTkZJR19DUFVfWExQIHdoaWNoIGlzIHVzZWQgdG8gZ3VhcmQgdGhlIGluY2x1
c2lvbiBvZg0KYXNtL25ldGxvZ2ljL3hscC1oYWwveGxwLmggdGhhdCBwcm92aWRlcyB0aGUgcmVx
dWlyZWQgY3B1X2lzX3hscDl4eA0KZnVuY3Rpb24uDQoNCltyYWxmQGxpbnV4LW1pcHMub3JnOiBG
aXhlZCB1cCBhcyBwZXIgSmF5YWNoYW5kcmFuJ3Mgc3VnZ2VzdGlvbi5dDQoNClNpZ25lZC1vZmYt
Ynk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBpbWd0ZWMuY29tPg0KQ2M6IEpheWFjaGFuZHJh
biBDIDxqY2hhbmRyYUBicm9hZGNvbS5jb20+DQpDYzogbGludXgtbWlwc0BsaW51eC1taXBzLm9y
Zw0KUGF0Y2h3b3JrOiBodHRwczovL3BhdGNod29yay5saW51eC1taXBzLm9yZy9wYXRjaC8xNDUy
NC8NClNpZ25lZC1vZmYtYnk6IFJhbGYgQmFlY2hsZSA8cmFsZkBsaW51eC1taXBzLm9yZz4NClNp
Z25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AdmVyaXpvbi5jb20+DQot
LS0NCiBhcmNoL21pcHMvbmV0bG9naWMvY29tbW9uL2lycS5jIHwgNCArKy0tDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gvbWlwcy9uZXRsb2dpYy9jb21tb24vaXJxLmMgYi9hcmNoL21pcHMvbmV0bG9naWMvY29tbW9u
L2lycS5jDQppbmRleCAzNjYwZGM2N2Q1NDQuLmY0OTYxYmM5YTYxZCAxMDA2NDQNCi0tLSBhL2Fy
Y2gvbWlwcy9uZXRsb2dpYy9jb21tb24vaXJxLmMNCisrKyBiL2FyY2gvbWlwcy9uZXRsb2dpYy9j
b21tb24vaXJxLmMNCkBAIC0yNzUsNyArMjc1LDcgQEAgYXNtbGlua2FnZSB2b2lkIHBsYXRfaXJx
X2Rpc3BhdGNoKHZvaWQpDQogCWRvX0lSUShubG1faXJxX3RvX3hpcnEobm9kZSwgaSkpOw0KIH0N
CiANCi0jaWZkZWYgQ09ORklHX09GDQorI2lmZGVmIENPTkZJR19DUFVfWExQDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBpcnFfZG9tYWluX29wcyB4bHBfcGljX2lycV9kb21haW5fb3BzID0gew0KIAku
eGxhdGUgPSBpcnFfZG9tYWluX3hsYXRlX29uZXR3b2NlbGwsDQogfTsNCkBAIC0zNDgsNyArMzQ4
LDcgQEAgdm9pZCBfX2luaXQgYXJjaF9pbml0X2lycSh2b2lkKQ0KICNpZiBkZWZpbmVkKENPTkZJ
R19DUFVfWExSKQ0KIAlubG1fc2V0dXBfZm1uX2lycSgpOw0KICNlbmRpZg0KLSNpZiBkZWZpbmVk
KENPTkZJR19PRikNCisjaWZkZWYgQ09ORklHX0NQVV9YTFANCiAJb2ZfaXJxX2luaXQoeGxwX3Bp
Y19pcnFfaWRzKTsNCiAjZW5kaWYNCiB9DQotLSANCjIuMTEuMA0K
