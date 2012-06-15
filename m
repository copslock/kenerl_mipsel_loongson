Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 13:45:10 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:51250 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902267Ab2FOLo7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 13:44:59 +0200
Received: by laap9 with SMTP id p9so2055232laa.36
        for <multiple recipients>; Fri, 15 Jun 2012 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lsj06Fb4dUBtAd1JxIVUmELuKYGWCY6HdtQBD79Y+e8=;
        b=PYfaJxtEcWxIrMgAinF4yRhlPcx9qr6SxV+Nen+6SSJyfibAVjWQS+SQVYPqH7RotY
         A5C/05pztdhXNaSKy5BzFir4yfe7XX2oQw9ZVzIlUX5X12KJkd+t7+K3MRUav2P5hBSF
         7NZABqWdnmmlZI/nAlg24b7sMtkWqBpwwmF8Qruy9nIxmUve5b+IotoD21WALyrRJ+zP
         iA160DF7chQnpOJBm+lpqPpc3p5ShDzlnF5XfieBJHVR4YRImGnWv3fM2IEeg5MgYj3t
         FlECUCJOEexdQ1PvWIw8sS/LlUE4E/IhiTh6+Wky73CYM3nGYxS8xrlE4lUPhNi5+3qP
         4HPw==
MIME-Version: 1.0
Received: by 10.152.148.199 with SMTP id tu7mr5274662lab.43.1339760694200;
 Fri, 15 Jun 2012 04:44:54 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Fri, 15 Jun 2012 04:44:54 -0700 (PDT)
In-Reply-To: <87aa04x5rz.fsf@lebrac.rtp-net.org>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-8-git-send-email-chenhc@lemote.com>
        <87aa04x5rz.fsf@lebrac.rtp-net.org>
Date:   Fri, 15 Jun 2012 19:44:54 +0800
Message-ID: <CAAhV-H5gEjz1zUoWN2p+fhTgitji-aK-iwrKqaHBFx--qxtigQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] MIPS: Loongson 3: Add serial port support.
From:   huacai chen <chenhuacai@gmail.com>
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: base64
X-archive-position: 33660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

VGhhbmsgeW91LCBJJ2xsIGZvbGxvdyB5b3VyIHRpcHMuCgpPbiBGcmksIEp1biAxNSwgMjAxMiBh
dCA1OjUwIFBNLCBBcm5hdWQgUGF0YXJkCjxhcm5hdWQucGF0YXJkQHJ0cC1uZXQub3JnPiB3cm90
ZToKPiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBnbWFpbC5jb20+IHdyaXRlczoKPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBIdWFjYWkgQ2hlbiA8Y2hlbmhjQGxlbW90ZS5jb20+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEhvbmdsaWFuZyBUYW8gPHRhb2hsQGxlbW90ZS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEh1
YSBZYW4gPHlhbmhAbGVtb3RlLmNvbT4KPj4gLS0tCj4+IKBhcmNoL21pcHMvaW5jbHVkZS9hc20v
bWFjaC1sb29uZ3Nvbi9sb29uZ3Nvbi5oIHwgoCCgMyArKwo+PiCgYXJjaC9taXBzL2xvb25nc29u
L2NvbW1vbi9zZXJpYWwuYyCgIKAgoCCgIKAgoCB8IKAgMjcgKysrKysrKysrKysrKysrKysrKysr
KysrCj4+IKBhcmNoL21pcHMvbG9vbmdzb24vY29tbW9uL3VhcnRfYmFzZS5jIKAgoCCgIKAgoHwg
oCCgNSArKysrCj4+IKAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWFjaC1sb29u
Z3Nvbi9sb29uZ3Nvbi5oIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21hY2gtbG9vbmdzb24vbG9v
bmdzb24uaAo+PiBpbmRleCBmZTdkOWE2Li4xNmQwOTI0IDEwMDY0NAo+PiAtLS0gYS9hcmNoL21p
cHMvaW5jbHVkZS9hc20vbWFjaC1sb29uZ3Nvbi9sb29uZ3Nvbi5oCj4+ICsrKyBiL2FyY2gvbWlw
cy9pbmNsdWRlL2FzbS9tYWNoLWxvb25nc29uL2xvb25nc29uLmgKPj4gQEAgLTEyNSw2ICsxMjUs
OSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZG9fcGVyZmNudF9JUlEodm9pZCkKPj4goCNkZWZpbmUg
TE9PTkdTT05fUENJQ09ORklHQkFTRSCgIKAgoCAweDAwCj4+IKAjZGVmaW5lIExPT05HU09OX1JF
R0JBU0UgoCCgIDB4MTAwCj4+Cj4+ICsvKiBMb29uZ3Nvbi0zQSBjcHUgdWFydCAqLwo+PiArI2Rl
ZmluZSBMT09OR1NPTl9VQVJUX0JBU0UgMHgxZmUwMDFlMAo+Cj4gaG0uIGlmIGl0J3MgbG9vbmdz
b24zIHNwZWNpZmlxdWUsIHdoeSBpcyBpdCBjYWxsZWQgbGlrZSB0aGlzIGFuZCBub3QKPiBMT09O
R1NPTjNfVUFSVF9CQVNFID8KPiBNb3Jlb3ZlciwgZnJvbSBhIHF1aWNrIGxvb2ssIHdoeSBkb24n
dCB5b3UgZGVmaW5lIGl0IGxhdGVyIGluIHRoZSBmaWxlCj4gd2l0aCB0aGUgcHJvcGVyIG1hY3Jv
cywgc2F5Ogo+Cj4gI2RlZmluZSBMT09OR1NPTjNfVUFSVF9CQVNFIKAgoCBMT09OR1NPTl9SRUco
TE9PTkdTT05fUkVHQkFTRSArIDB4ZTApCj4KPgo+PiArCj4+IKAvKiBQQ0kgQ29uZmlndXJhdGlv
biBSZWdpc3RlcnMgKi8KPj4KPj4goCNkZWZpbmUgTE9PTkdTT05fUENJX1JFRyh4KSCgTE9PTkdT
T05fUkVHKExPT05HU09OX1BDSUNPTkZJR0JBU0UgKyAoeCkpCj4+IGRpZmYgLS1naXQgYS9hcmNo
L21pcHMvbG9vbmdzb24vY29tbW9uL3NlcmlhbC5jIGIvYXJjaC9taXBzL2xvb25nc29uL2NvbW1v
bi9zZXJpYWwuYwo+PiBpbmRleCA3NTgwODczLi42YmZlOWRkIDEwMDY0NAo+PiAtLS0gYS9hcmNo
L21pcHMvbG9vbmdzb24vY29tbW9uL3NlcmlhbC5jCj4+ICsrKyBiL2FyY2gvbWlwcy9sb29uZ3Nv
bi9jb21tb24vc2VyaWFsLmMKPj4gQEAgLTQ3LDYgKzQ3LDMzIEBAIHN0YXRpYyBzdHJ1Y3QgcGxh
dF9zZXJpYWw4MjUwX3BvcnQgdWFydDgyNTBfZGF0YVtdWzJdID0gewo+PiCgIKAgoCBbTUFDSF9E
RVhYT05fR0RJVU0yRjEwXSCgIKAgoCCgIHtQT1JUX00oMyksIHt9IH0sCj4+IKAgoCCgIFtNQUNI
X0xFTU9URV9OQVNdIKAgoCCgIKAgoCCgIKAge1BPUlRfTSgzKSwge30gfSwKPj4goCCgIKAgW01B
Q0hfTEVNT1RFX0xMMkZdIKAgoCCgIKAgoCCgIKB7UE9SVCgzKSwge30gfSwKPj4gKyCgIKAgW01B
Q0hfTEVNT1RFX0ExMDA0XSCgIKAgoCCgIKAgoCB7Cj4+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB7Cj4+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIC5pcnEgoCCgIKAgoCCgIKA9IE1JUFNfQ1BVX0lSUV9C
QVNFICsgMiwKPj4gKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgLnVhcnRjbGsgoCCgIKAgoD0gMzMxNzc2MDAsCj4+ICsgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIC5pb3R5cGUgoCCgIKAgoCA9IFVQ
SU9fTUVNLAo+PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCAuZmxhZ3MgoCCgIKAgoCCgPSBVUEZfQk9PVF9BVVRPQ09ORiB8IFVQRl9TS0lQX1RF
U1QsCj4+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB9LAo+
PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAge30KPj4gKyCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB9LAo+PiArIKAgoCBbTUFDSF9MRU1P
VEVfQTExMDFdIKAgoCCgIKAgoCCgIHsKPj4gKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIHsKPj4gKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgLmlycSCgIKAgoCCgIKAgoD0gTUlQU19DUFVfSVJRX0JBU0UgKyAy
LAo+PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCAudWFydGNsayCgIKAgoCCgPSAyNTAwMDAwMCwKPj4gKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgLmlvdHlwZSCgIKAgoCCgID0gVVBJT19NRU0s
Cj4+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IC5mbGFncyCgIKAgoCCgIKA9IFVQRl9CT09UX0FVVE9DT05GIHwgVVBGX1NLSVBfVEVTVCwKPj4g
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIH0sCj4+ICsgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB7fQo+PiArIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIH0sCj4+ICsgoCCgIFtNQUNIX0xFTU9URV9BMTIw
NV0goCCgIKAgoCCgIKAgewo+PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgewo+PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCAuaXJxIKAgoCCgIKAgoCCgPSBNSVBTX0NQVV9JUlFfQkFTRSArIDIsCj4+ICsg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIC51YXJ0
Y2xrIKAgoCCgIKA9IDI1MDAwMDAwLAo+PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAuaW90eXBlIKAgoCCgIKAgPSBVUElPX01FTSwKPj4gKyCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgLmZsYWdz
IKAgoCCgIKAgoD0gVVBGX0JPT1RfQVVUT0NPTkYgfCBVUEZfU0tJUF9URVNULAo+PiArIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgfSwKPj4gKyCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHt9Cj4+ICsgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgfSwKPj4goCCgIKAgW01BQ0hfTE9PTkdTT05fRU5EXSCgIKAg
oCCgIKAgoCB7fSwKPgo+IFdoYXQgYWJvdXQgbW9kaWZ5aW5nIFBPUlRfTSB0byBtYWtlcyB0aGlu
Z3MgY2xlYXJlciA/Cj4KPiBBcm5hdWQK
