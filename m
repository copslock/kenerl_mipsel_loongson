Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 05:38:35 +0200 (CEST)
Received: from smtpbg202.qq.com ([184.105.206.29]:46451 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025557AbcDTDidRDzl4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 05:38:33 +0200
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: NFrDoElZbUVBZmIhv4OelnpL1rGwMF3frTkJgWkHgQzvp+OqH2jsZuBd+6EI4
        5f4vp2N6uYGQas438Sa3s7YQ9ATelq8CRYFp4Kwr1sfxZn3r+H5jPSr8Ueo4jYaxxDxYM/k
        iJQ5QtxL6EdgmWsofCSM5fP1heFpKVLQCOUz/BgK1RH9DuceJZDuWD8U4NmLxYtTPNyWx+q
        M/FBevTsj5nxcbNobshc3ibZM7PCDWD36FofmQ6fFmhBG9PRaYMM5wfkAxaC0eViySYbrX/
        zao6lnY9CeiP6H
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailvip38t1461123477t66723
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?R3VlbnRlciBSb2Vjaw==?=" <linux@roeck-us.net>
Cc:     "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?bGludXgtbmV4dA==?=" <linux-next@vger.kernel.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re:next: fuloong2e qemu boot failure due to 'MIPS: Loongson: AddLoongson-3A R2 basic support'
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 20 Apr 2016 11:37:57 +0800
X-Priority: 3
Message-ID: <tencent_5BBD94596E55516D1B4FED5F@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20160420025454.GA17200@roeck-us.net>
In-Reply-To: <20160420025454.GA17200@roeck-us.net>
X-QQ-ReplyHash: 3908547184
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

SGksDQoNCkNvdWxkIHlvdSBwbGVhc2UgcmVtb3ZlIHRoZSBsaW5lICIjZGVmaW5lIGNwdV9o
d3JlbmFfaW1wbF9iaXRzICAgIDB4YzAwMDAwMDAiIGluIGFyY2gvbWlwcy9pbmNsdWRlL2Fz
bS9tYWNoLWxvb25nc29uNjQvY3B1LWZlYXR1cmUtb3ZlcnJpZGVzLmggYW5kIHRyeSBhZ2Fp
bj9UaGFua3MuDQoNCkh1YWNhaQ0KIA0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0t
LS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogICJHdWVudGVyIFJvZWNrIjxsaW51eEByb2Vjay11
cy5uZXQ+Ow0KRGF0ZTogIFdlZCwgQXByIDIwLCAyMDE2IDEwOjU0IEFNDQpUbzogICJIdWFj
YWkgQ2hlbiI8Y2hlbmhjQGxlbW90ZS5jb20+Ow0KQ2M6ICAiUmFsZiBCYWVjaGxlIjxyYWxm
QGxpbnV4LW1pcHMub3JnPjsgImxpbnV4LW1pcHMiPGxpbnV4LW1pcHNAbGludXgtbWlwcy5v
cmc+OyAibGludXgtbmV4dCI8bGludXgtbmV4dEB2Z2VyLmtlcm5lbC5vcmc+OyAibGludXgt
a2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNClN1YmplY3Q6ICBuZXh0
OiBmdWxvb25nMmUgcWVtdSBib290IGZhaWx1cmUgZHVlIHRvICdNSVBTOiBMb29uZ3Nvbjog
QWRkTG9vbmdzb24tM0EgUjIgYmFzaWMgc3VwcG9ydCcNCiANCkhpLA0KDQpxZW11IGZhaWxz
IHRvIGJvb3QgaW4gLW5leHQgZm9yIG1hY2hpbmUgZnVsb25nMmUgd2l0aCBjb25maWd1cmF0
aW9uDQpmdWxvb25nMmVfZGVmY29uZmlnLiBCaXNlY3QgcG9pbnRzIHRvIGNvbW1pdCAnTUlQ
UzogTG9vbmdzb246IEFkZA0KTG9vbmdzb24tM0EgUjIgYmFzaWMgc3VwcG9ydCcuIHFlbXUg
aGFuZ3MgaW4gYm9vdCwgYWZ0ZXIgZGlzcGxheWluZyANCiJJbm9kZS1jYWNoZSBoYXNoIHRh
YmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogMywgMTMxMDcyIGJ5dGVzKSIuDQoNCkJpc2Vj
dCBsb2cgaXMgYXR0YWNoZWQuDQoNCkd1ZW50ZXINCg0KLS0tDQojIGJhZDogWzFiZDdhMjA4
MWQyYzdiMDk2Zjc1YWE5MzQ2NThlNDA0Y2NhYmE1ZmRdIEFkZCBsaW51eC1uZXh0IHNwZWNp
ZmljIGZpbGVzIGZvciAyMDE2MDQxOA0KIyBnb29kOiBbYmYxNjIwMDY4OTExOGQxOWRlMWI4
ZDJhM2MzMTRmYzIxZjVkYzdiYl0gTGludXggNC42LXJjMw0KZ2l0IGJpc2VjdCBzdGFydCAn
SEVBRCcgJ3Y0LjYtcmMzJw0KIyBiYWQ6IFs0OTNhYzkyZmY2NWVjNGM0Y2Q0YzQzODcwZTc3
ODc2MGEwMTI5NTFkXSBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdpcHZzLW5leHQv
bWFzdGVyJw0KZ2l0IGJpc2VjdCBiYWQgNDkzYWM5MmZmNjVlYzRjNGNkNGM0Mzg3MGU3Nzg3
NjBhMDEyOTUxZA0KIyBiYWQ6IFsyMGNhM2FlOWM1MTdlZWU5YjJmMWJkMGZiMmEwNmUyZDE0
MTUzNzkyXSBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdidHJmcy1rZGF2ZS9mb3It
bmV4dCcNCmdpdCBiaXNlY3QgYmFkIDIwY2EzYWU5YzUxN2VlZTliMmYxYmQwZmIyYTA2ZTJk
MTQxNTM3OTINCiMgZ29vZDogW2M0NTRlNjVmYjlhZGUxMWQwZjg0NzE4ZDA2YTY4ODhlMmM5
MjgwNGRdIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ29tYXAvZm9yLW5leHQnDQpn
aXQgYmlzZWN0IGdvb2QgYzQ1NGU2NWZiOWFkZTExZDBmODQ3MThkMDZhNjg4OGUyYzkyODA0
ZA0KIyBnb29kOiBbNmY1YzcwZmI5YjRmYzA1MzQxNTdiZmE0MGNlYTliNDAyZTZmMjUwNl0g
TWVyZ2UgcmVtb3RlLXRyYWNraW5nIGJyYW5jaCAnbWljcm9ibGF6ZS9uZXh0Jw0KZ2l0IGJp
c2VjdCBnb29kIDZmNWM3MGZiOWI0ZmMwNTM0MTU3YmZhNDBjZWE5YjQwMmU2ZjI1MDYNCiMg
YmFkOiBbN2YwNTNjZDY4ZmQxNDI0M2M4ZjIwMmI0MDg2ZDdkZDc1YzQwOWU2Zl0gTUlQUzog
TG9vbmdzb24tMzogSW50cm9kdWNlIENPTkZJR19MT09OR1NPTjNfRU5IQU5DRU1FTlQNCmdp
dCBiaXNlY3QgYmFkIDdmMDUzY2Q2OGZkMTQyNDNjOGYyMDJiNDA4NmQ3ZGQ3NWM0MDllNmYN
CiMgZ29vZDogW2U5YWFjZGQ3ZjBiNjZjNGFjZTE3ZTU5NTBjNDhlN2NjNjFhMjUzYzhdIE1J
UFM6IEFsbG93IFJJWEkgdG8gYmUgdXNlZCBvbiBub24tUjIgb3IgUjYgY29yZXMNCmdpdCBi
aXNlY3QgZ29vZCBlOWFhY2RkN2YwYjY2YzRhY2UxN2U1OTUwYzQ4ZTdjYzYxYTI1M2M4DQoj
IGdvb2Q6IFtkMWU4YjlhOGRjNmM3ZmE5YWRkNWRmYTcwODNlMDM1Y2UwMzdlNTZkXSBNQUlO
VEFJTkVSUzogYWRkIExvb25nc29uMSBhcmNoaXRlY3R1cmUgZW50cnkNCmdpdCBiaXNlY3Qg
Z29vZCBkMWU4YjlhOGRjNmM3ZmE5YWRkNWRmYTcwODNlMDM1Y2UwMzdlNTZkDQojIGdvb2Q6
IFsxM2ZmNjI3NWJiMzg5YzM2NjkwODJkM2VmODQ4MzU5MmEzMWViMGVhXSBNSVBTOiBGaXgg
c2lnaW5mby5oIHRvIHVzZSBzdHJpY3QgcG9zaXggdHlwZXMNCmdpdCBiaXNlY3QgZ29vZCAx
M2ZmNjI3NWJiMzg5YzM2NjkwODJkM2VmODQ4MzU5MmEzMWViMGVhDQojIGdvb2Q6IFs2NmU3
NGJkZDUxZTYxNzAyM2ZhMmU3OWE4MDdiNzA0ZmIzZWVkOGFhXSBNSVBTOiBFbmFibGUgcHRy
YWNlIGh3IHdhdGNocG9pbnRzIG9uIE1JUFMgUjYNCmdpdCBiaXNlY3QgZ29vZCA2NmU3NGJk
ZDUxZTYxNzAyM2ZhMmU3OWE4MDdiNzA0ZmIzZWVkOGFhDQojIGdvb2Q6IFtmN2NhYmMyZGFj
OGFkZjU5ODZkYmM3MDA1ODRiYzNiOGZlNDkzZDRkXSBNSVBTOiBMb29uZ3Nvbi0zOiBBZGp1
c3QgaXJxIGRpc3BhdGNoIHRvIHNwZWVkdXAgcHJvY2Vzc2luZw0KZ2l0IGJpc2VjdCBnb29k
IGY3Y2FiYzJkYWM4YWRmNTk4NmRiYzcwMDU4NGJjM2I4ZmU0OTNkNGQNCiMgYmFkOiBbNDk3
OGM4NDc3ZTk2ZmI5ZTlkODcwZDhmNDIzMjhkY2FiZjFhNjVlOV0gTUlQUzogTG9vbmdzb24t
MzogU2V0IGNhY2hlIGZsdXNoIGhhbmRsZXJzIHRvIGNhY2hlX25vb3ANCmdpdCBiaXNlY3Qg
YmFkIDQ5NzhjODQ3N2U5NmZiOWU5ZDg3MGQ4ZjQyMzI4ZGNhYmYxYTY1ZTkNCiMgYmFkOiBb
MDRhMzU5MjJjMWRhYzFiNDg2NGI4YjM2NmEzNzQ3NGU5ZTUxZDhjMF0gTUlQUzogTG9vbmdz
b246IEFkZCBMb29uZ3Nvbi0zQSBSMiBiYXNpYyBzdXBwb3J0DQpnaXQgYmlzZWN0IGJhZCAw
NGEzNTkyMmMxZGFjMWI0ODY0YjhiMzY2YTM3NDc0ZTllNTFkOGMwDQojIGZpcnN0IGJhZCBj
b21taXQ6IFswNGEzNTkyMmMxZGFjMWI0ODY0YjhiMzY2YTM3NDc0ZTllNTFkOGMwXSBNSVBT
OiBMb29uZ3NvbjogQWRkIExvb25nc29uLTNBIFIyIGJhc2ljIHN1cHBvcnQ=
