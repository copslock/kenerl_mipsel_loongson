Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:55:16 +0100 (CET)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:5573 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdKHUxGpZjmC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Nov 2017 21:53:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174386; x=1541710386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B8L3gNzRmoNYQv5LYbpcy8i/2A16VQ/wC0jG9tlrBv0=;
  b=DGdULO8Lf/a9wkcG1DZg80qjy7NKqo2JBMndxjyiZbKzbnLJQWr6PAHM
   xr1Gt3vLpyc8q2BQ/J8hTU66d3otnZLPDPtbPzBJrPfKreWCaDmVCxODt
   wGT4ZQLga61E/CtlSydaFT/AFVLleNQSCO7sVpOcUMp5V2QXh5KYyxc/c
   g=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 08 Nov 2017 20:52:54 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:52:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174360; x=1541710360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B8L3gNzRmoNYQv5LYbpcy8i/2A16VQ/wC0jG9tlrBv0=;
  b=rZK3biemJ3a/TSaBUwY+H6BAlg+TBkjcUPFuVe1h9G5IzKMWf118CG4C
   ArWz3lMcJdIym6bfk9+CX0TGa3qAWEVw88KVqqf5D01nI2rZOmzqMRcof
   /XJKqEFt64eqqYmcIBammQN2bLmIcbn+tTMv79sbJp65fX96ccGb9JOXI
   k=;
Received: from endeavour.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.163])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174360; x=1541710360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B8L3gNzRmoNYQv5LYbpcy8i/2A16VQ/wC0jG9tlrBv0=;
  b=rZK3biemJ3a/TSaBUwY+H6BAlg+TBkjcUPFuVe1h9G5IzKMWf118CG4C
   ArWz3lMcJdIym6bfk9+CX0TGa3qAWEVw88KVqqf5D01nI2rZOmzqMRcof
   /XJKqEFt64eqqYmcIBammQN2bLmIcbn+tTMv79sbJp65fX96ccGb9JOXI
   k=;
X-Host: endeavour.tdc.vzwcorp.com
Received: from ohtwi1exh001.uswin.ad.vzwcorp.com ([10.144.218.43])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:52:40 +0000
Received: from tbwexch11apd.uswin.ad.vzwcorp.com (153.114.162.35) by
 OHTWI1EXH001.uswin.ad.vzwcorp.com (10.144.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:52:40 -0500
Received: from OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) by
 tbwexch11apd.uswin.ad.vzwcorp.com (153.114.162.35) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:52:39 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:52:38 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:52:38 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-3.18 26/27] MIPS: Netlogic: Exclude
 netlogic,xlp-pic code from XLR builds
Thread-Topic: [PATCH AUTOSEL for-3.18 26/27] MIPS: Netlogic: Exclude
 netlogic,xlp-pic code from XLR builds
Thread-Index: AQHTWNNJ4fCa78PBvUC/zSbzQB6o7A==
Date:   Wed, 8 Nov 2017 20:51:01 +0000
Message-ID: <20171108205049.27612-26-alexander.levin@verizon.com>
References: <20171108205049.27612-1-alexander.levin@verizon.com>
In-Reply-To: <20171108205049.27612-1-alexander.levin@verizon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1494C7EA293D754388B6A86B0E0AF0FF@vzwcorp.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <alexander.levin@one.verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60767
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
L2lycS5jDQppbmRleCBjMTAwYjlhZmEwYWIuLjQ4YjQzZWUwZDE5OSAxMDA2NDQNCi0tLSBhL2Fy
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
