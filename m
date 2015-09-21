Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 04:16:21 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:40545 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006916AbbIUCQTTFbU7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 04:16:19 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id t8L2GAwM026080
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 20 Sep 2015 19:16:10 -0700 (PDT)
Received: from [128.224.162.234] (128.224.162.234) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.235.1; Sun, 20 Sep 2015
 19:16:09 -0700
Message-ID: <55FF6876.7080908@windriver.com>
Date:   Mon, 21 Sep 2015 10:16:22 +0800
From:   yjin <yanjiang.jin@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     <ralf@linux-mips.org>
CC:     <akpm@linux-foundation.org>, <mhuang@redhat.com>,
        <kexec@lists.infradead.org>, <chaowang@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jinyanjiang@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: vmcore: forced convert 'hdr' in elf_check_arch()
References: <1442562171-21307-1-git-send-email-yanjiang.jin@windriver.com> <1442562171-21307-2-git-send-email-yanjiang.jin@windriver.com>
In-Reply-To: <1442562171-21307-2-git-send-email-yanjiang.jin@windriver.com>
Content-Type: multipart/mixed;
        boundary="------------050305060608040500080803"
Return-Path: <Yanjiang.Jin@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanjiang.jin@windriver.com
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

--------------050305060608040500080803
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

The new version patch only modifies mips/elf.h, so add Ralf Baechle and 
cc linux-mips@linux-mips.org.
This is a V2 patch, attach the V1 patch for reference.

Thanks!
Yanjiang

On 2015年09月18日 15:42, yanjiang.jin@windriver.com wrote:
> From: Yanjiang Jin <yanjiang.jin@windriver.com>
>
> elf_check_arch() will be called both in parse_crash_elf64_headers()
> and parse_crash_elf32_headers(). But in these two functions, the type of
> the parameter ehdr is different: Elf32_Ehdr and Elf64_Ehdr.
>
> Function parse_crash_elf_headers() reads e_ident[EI_CLASS] then decides to
> call parse_crash_elf64_headers() or parse_crash_elf32_headers().
> This happens in run time, not compile time. So compiler will report
> the below warning:
>
> In file included from include/linux/elf.h:4:0,
>                   from fs/proc/vmcore.c:13:
> fs/proc/vmcore.c: In function 'parse_crash_elf32_headers':
> arch/mips/include/asm/elf.h:258:23: warning: initializatio
> n from incompatible pointer type
>    struct elfhdr *__h = (hdr);     \
>                         ^
> fs/proc/vmcore.c:1071:4: note: in expansion of macro 'elf_
> check_arch'
>     !elf_check_arch(&ehdr) ||
>      ^
>
> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> ---
>   arch/mips/include/asm/elf.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index f19e890..ece490d 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
> @@ -224,7 +224,7 @@ struct mips_elf_abiflags_v0 {
>   #define elf_check_arch(hdr)						\
>   ({									\
>   	int __res = 1;							\
> -	struct elfhdr *__h = (hdr);					\
> +	struct elfhdr *__h = (struct elfhdr *)(hdr);			\
>   									\
>   	if (__h->e_machine != EM_MIPS)					\
>   		__res = 0;						\
> @@ -255,7 +255,7 @@ struct mips_elf_abiflags_v0 {
>   #define elf_check_arch(hdr)						\
>   ({									\
>   	int __res = 1;							\
> -	struct elfhdr *__h = (hdr);					\
> +	struct elfhdr *__h = (struct elfhdr *)(hdr);			\
>   									\
>   	if (__h->e_machine != EM_MIPS)					\
>   		__res = 0;						\


--------------050305060608040500080803
Content-Type: application/x-extension-eml;
	name="Re: [PATCH] vmcore: replace Elf64_Ehdr_Elf32_Ehdr with elfhdr.eml"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="Re: [PATCH] vmcore: replace Elf64_Ehdr_Elf32_Ehdr with elfhd";
	filename*1="r.eml"

UmVjZWl2ZWQ6IGZyb20gbWFpbC53aW5kcml2ZXIuY29tICgxNDcuMTEuMS4xMSkgYnkgQUxB
LUhDQS5jb3JwLmFkLndycy5jb20NCiAoMTQ3LjExLjE4OS41MCkgd2l0aCBNaWNyb3NvZnQg
U01UUCBTZXJ2ZXIgKFRMUykgaWQgMTQuMy4yMzUuMTsgVGh1LCAxNyBTZXANCiAyMDE1IDIy
OjQ4OjQwIC0wNzAwDQpSZWNlaXZlZDogZnJvbSBtcjEud2luZHJpdmVyLmNvbSAobXIxIFsx
OTIuMTI0LjEyNy4yNV0pCWJ5IG1haWwud2luZHJpdmVyLmNvbQ0KICg4LjE1LjIvOC4xNS4x
KSB3aXRoIEVTTVRQUyBpZCB0OEk1bWRSdzAyNzkwOQkodmVyc2lvbj1UTFN2MS4xDQogY2lw
aGVyPURIRS1SU0EtQUVTMjU2LVNIQSBiaXRzPTI1NiB2ZXJpZnk9T0spCWZvcg0KIDx5YW5q
aWFuZy5qaW5Ad2luZHJpdmVyLmNvbT47IFRodSwgMTcgU2VwIDIwMTUgMjI6NDg6NDAgLTA3
MDAgKFBEVCkNClJlY2VpdmVkOiBmcm9tIGVzYTQuZWRveHMxLmlwaG14LmNvbSAoZXNhNC5l
ZG94czEuaXBobXguY29tIFs2OC4yMzIuMTM3LjE4NF0pDQoJYnkgbXIxLndpbmRyaXZlci5j
b20gKDguMTUuMi84LjE1LjEpIHdpdGggRVNNVFBTIGlkIHQ4STVtZHJnMDIzNjI2DQoJKHZl
cnNpb249VExTdjEgY2lwaGVyPURIRS1SU0EtQ0FNRUxMSUEyNTYtU0hBIGJpdHM9MjU2IHZl
cmlmeT1GQUlMKQlmb3INCiA8eWFuamlhbmcuamluQHdpbmRyaXZlci5jb20+OyBUaHUsIDE3
IFNlcCAyMDE1IDIyOjQ4OjM5IC0wNzAwDQpYLUlyb25Qb3J0LUFudGktU3BhbS1GaWx0ZXJl
ZDogdHJ1ZQ0KWC1Jcm9uUG9ydC1BbnRpLVNwYW0tUmVzdWx0OiBBMENQQUFBb3BmdFZuQnkz
aE5GZEdRRUJBWU5iYWIxQ0FRMkJVQjhLaFhrQ2dVYzRGQUVCQVFFQkFRRVJBUUVCQVFFR0RR
a0pJUzZFSXdFQkFRRUNBUUVCQVNBUEFUc0xCUXNMRlFNQ0FnVWhBZ0lQQlJNQk5ST0lKZ2dO
dG1PVU1nRUJBUUVCQVFRQkFRRUJBUUVCRzRFaWhWR0VmWVVOQjRKcEw0RVVCWTF4aDNHRkVZ
VVRnbCtCVVVhRGI0TWhoVm1EWklSTWcyMGZBUUdDVXh5QllURXppVzBCQVFFDQpYLUlQQVMt
UmVzdWx0OiBBMENQQUFBb3BmdFZuQnkzaE5GZEdRRUJBWU5iYWIxQ0FRMkJVQjhLaFhrQ2dV
YzRGQUVCQVFFQkFRRVJBUUVCQVFFR0RRa0pJUzZFSXdFQkFRRUNBUUVCQVNBUEFUc0xCUXNM
RlFNQ0FnVWhBZ0lQQlJNQk5ST0lKZ2dOdG1PVU1nRUJBUUVCQVFRQkFRRUJBUUVCRzRFaWhW
R0VmWVVOQjRKcEw0RVVCWTF4aDNHRkVZVVRnbCtCVVVhRGI0TWhoVm1EWklSTWcyMGZBUUdD
VXh5QllURXppVzBCQVFFDQpYLUlyb25Qb3J0LUFWOiBFPVNvcGhvcztpPSI1LjE3LDU1MCwx
NDM3NDYyMDAwIjsgDQogICBkPSJzY2FuJzIwOCI7YT0iNDAzOTQ2MTciDQpSZWNlaXZlZDog
ZnJvbSBteDEucmVkaGF0LmNvbSAoWzIwOS4xMzIuMTgzLjI4XSkgIGJ5IGVzYTQuZWRveHMx
LmlwaG14LmNvbQ0KIHdpdGggRVNNVFAvVExTL0RIRS1SU0EtQUVTMjU2LVNIQTsgMTcgU2Vw
IDIwMTUgMjI6NDg6MzMgLTA3MDANClJlY2VpdmVkOiBmcm9tIGludC1teDE0LmludG1haWwu
cHJvZC5pbnQucGh4Mi5yZWRoYXQuY29tDQogKGludC1teDE0LmludG1haWwucHJvZC5pbnQu
cGh4Mi5yZWRoYXQuY29tIFsxMC41LjExLjI3XSkJYnkgbXgxLnJlZGhhdC5jb20NCiAoUG9z
dGZpeCkgd2l0aCBFU01UUFMgaWQgMzFGRUUzQjNDNzsJRnJpLCAxOCBTZXAgMjAxNSAwNTo0
ODozMyArMDAwMCAoVVRDKQ0KUmVjZWl2ZWQ6IGZyb20gbG9jYWxob3N0ICh1bnVzZWQgWzEw
LjY2LjEyOC4yNV0gKG1heSBiZSBmb3JnZWQpKQlieQ0KIGludC1teDE0LmludG1haWwucHJv
ZC5pbnQucGh4Mi5yZWRoYXQuY29tICg4LjE0LjQvOC4xNC40KSB3aXRoIEVTTVRQIGlkDQog
dDhJNW1WZVkwMjY0NDM7CUZyaSwgMTggU2VwIDIwMTUgMDE6NDg6MzIgLTA0MDANCkRhdGU6
IEZyaSwgMTggU2VwIDIwMTUgMTM6NDk6MDcgKzA4MDANCkZyb206IE1pbmZlaSBIdWFuZyA8
bWh1YW5nQHJlZGhhdC5jb20+DQpUbzogeWppbiA8eWFuamlhbmcuamluQHdpbmRyaXZlci5j
b20+DQpDQzogPGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc+LCA8YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4sDQoJPGppbnlhbmppYW5nQGdtYWlsLmNvbT4sIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPiwNCgk8Y2hhb3dhbmdAcmVkaGF0LmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHZtY29yZTogcmVwbGFjZSBFbGY2NF9FaGRyL0VsZjMyX0VoZHIgd2l0aCBl
bGZoZHINCk1lc3NhZ2UtSUQ6IDwyMDE1MDkxODA1NDkwNy5HQTYzNDlAZGhjcC0xMjgtMjUu
bmF5LnJlZGhhdC5jb20+DQpSZWZlcmVuY2VzOiA8MTQ0MjM3MjMyMS0xNjMzNC0xLWdpdC1z
ZW5kLWVtYWlsLXlhbmppYW5nLmppbkB3aW5kcml2ZXIuY29tPg0KIDwxNDQyMzcyMzIxLTE2
MzM0LTItZ2l0LXNlbmQtZW1haWwteWFuamlhbmcuamluQHdpbmRyaXZlci5jb20+DQogPDIw
MTUwOTE2MTAzOTE3LkdBMzIxODlAZGhjcC0xMjgtMjUubmF5LnJlZGhhdC5jb20+DQogPDU1
RkE4OEJELjMwNTAzMDNAd2luZHJpdmVyLmNvbT4NCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFp
bjsgY2hhcnNldD0idXRmLTgiDQpDb250ZW50LURpc3Bvc2l0aW9uOiBpbmxpbmUNCkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCkluLVJlcGx5LVRvOiA8NTVGQTg4QkQuMzA1
MDMwM0B3aW5kcml2ZXIuY29tPg0KVXNlci1BZ2VudDogTXV0dC8xLjUuMjEgKDIwMTAtMDkt
MTUpDQpYLVNjYW5uZWQtQnk6IE1JTUVEZWZhbmcgMi42OCBvbiAxMC41LjExLjI3DQpSZXR1
cm4tUGF0aDogbWh1YW5nQHJlZGhhdC5jb20NClgtTVMtRXhjaGFuZ2UtT3JnYW5pemF0aW9u
LUF1dGhTb3VyY2U6IEFMQS1IQ0EuY29ycC5hZC53cnMuY29tDQpYLU1TLUV4Y2hhbmdlLU9y
Z2FuaXphdGlvbi1BdXRoQXM6IEFub255bW91cw0KTUlNRS1WZXJzaW9uOiAxLjANCg0KT24g
MDkvMTcvMTUgYXQgMDU6MzJwbSwgeWppbiB3cm90ZToNCj4gDQo+IE9uIDIwMTXlubQwOeac
iDE25pelIDE4OjM5LCBNaW5mZWkgSHVhbmcgd3JvdGU6DQo+ID5PbiAwOS8xNi8xNSBhdCAx
MDo1OGFtLCB5YW5qaWFuZy5qaW5Ad2luZHJpdmVyLmNvbSB3cm90ZToNCj4gPj5Gcm9tOiBZ
YW5qaWFuZyBKaW4gPHlhbmppYW5nLmppbkB3aW5kcml2ZXIuY29tPg0KPiA+Pg0KPiA+PkZ1
bmN0aW9uIHBhcnNlX2NyYXNoX2VsZl9oZWFkZXJzKCkgcmVhZHMgZV9pZGVudFtFSV9DTEFT
U10gdGhlbiBkZWNpZGVzIHRvDQo+ID4+Y2FsbCBwYXJzZV9jcmFzaF9lbGY2NF9oZWFkZXJz
KCkgb3IgcGFyc2VfY3Jhc2hfZWxmMzJfaGVhZGVycygpLg0KPiA+PkJ1dCB0aGlzIGhhcHBl
bnMgaW4gcnVuIHRpbWUsIG5vdCBjb21waWxlIHRpbWUuIFNvIGNvbXBpbGVyIHdpbGwgcmVw
b3J0DQo+ID4+dGhlIGJlbG93IHdhcm5pbmc6DQo+ID4+DQo+ID4+SW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGluY2x1ZGUvbGludXgvZWxmLmg6NDowLA0KPiA+PiAgICAgICAgICAgICAgICAg
IGZyb20gZnMvcHJvYy92bWNvcmUuYzoxMzoNCj4gPj5mcy9wcm9jL3ZtY29yZS5jOiBJbiBm
dW5jdGlvbiAncGFyc2VfY3Jhc2hfZWxmMzJfaGVhZGVycyc6DQo+ID4+YXJjaC9taXBzL2lu
Y2x1ZGUvYXNtL2VsZi5oOjI1ODoyMzogd2FybmluZzogaW5pdGlhbGl6YXRpbw0KPiA+Pm4g
ZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlDQo+ID4+ICAgc3RydWN0IGVsZmhkciAq
X19oID0gKGhkcik7ICAgICBcDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+
SG93IGFib3V0IGNvbnZlcnRpbmcgdGhlIGhkciB0byB0eXBlIGVsZmhkciBpbiBhYm92ZSBz
ZW50ZW5jZSwgbGlrZQ0KPiA+Zm9sbG93aW5nLg0KPiA+DQo+ID5zdHJ1Y3QgZWxmaGRyICpf
X2ggPSAoc3RydWN0IGVsZmhkciAqKShoZHIpOw0KPiANCj4gWWVzLCB0aGlzIGlzIGEgcmVw
bGFjZW1lbnQsIGFuZCBpdCBzZWVtcyBtb3JlIHNhZmUgYmVjYXVzZSBpdCBqdXN0DQo+IGFm
ZmVjdHMgTUlQUyBhcmNoLg0KPiBCdXQgSSBhbHNvIGNhbid0IHNlZSBhbnkgb2J2aW91cyBp
bXBhY3QgaWYgbW9kaWZ5aW5nIGNvbW1vbiB2bWNvcmUuYzotKQ0KDQpXaXRob3V0IHRoZSBN
YXJvIGRlZmluZSwgZWxmaGRyIGlzIG5vdCB0aGUgc3RydWN0IGluIHRoZSBjb2RlIHNvdXJj
ZS4NClRodXMgdGhlcmUgaXMgc29tZSB1bmNvbnZlbmllbmNlIGZvciBwZW9wbGUgdG8gcmVh
ZCB0aGUgY29kZSwgaWYgdGhlcmUNCmlzIGFub3RoZXIgdGhvdWdodCB0byBmaXggdGhpcyBp
c3N1ZS4gDQoNClBsZWFzZSBkbyB0aGUgY29udmVydGluZyBpbiB0aGUgTWFybywgYW5kIHJl
cG9zdCB0aGUgbmV3IHZlcnNpb24uDQoNClRoYW5rcw0KTWluZmVpDQoNCj4gQW55d2F5LCBp
ZiB5b3Ugc3RpY2sgdG8geW91ciBvcGluaW9uLCBJIGNhbiBzZW5kIGEgVjIgcGF0Y2ggdG8N
Cj4gdXBkYXRlIG1pcHMnIGVsZi5oIHJhdGhlciB0aGFuIHZtY29yZS5jLg0KPiANCj4gVGhh
bmtzIQ0KPiBZYW5qaWFuZw0KPiA+DQo+ID5UaGFua3MNCj4gPk1pbmZlaQ0KPiA+DQo+ID4+
ZnMvcHJvYy92bWNvcmUuYzoxMDcxOjQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAn
ZWxmXw0KPiA+PmNoZWNrX2FyY2gnDQo+ID4+ICAgICFlbGZfY2hlY2tfYXJjaCgmZWhkcikg
fHwNCj4gPj4gICAgIF4NCj4gPj4NCj4gPj5TaWduZWQtb2ZmLWJ5OiBZYW5qaWFuZyBKaW4g
PHlhbmppYW5nLmppbkB3aW5kcml2ZXIuY29tPg0KPiA+Pi0tLQ0KPiA+PiAgZnMvcHJvYy92
bWNvcmUuYyB8IDQgKystLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj5kaWZmIC0tZ2l0IGEvZnMvcHJvYy92bWNv
cmUuYyBiL2ZzL3Byb2Mvdm1jb3JlLmMNCj4gPj5pbmRleCA0ZTYxMzg4Li41NzZiYjI2IDEw
MDY0NA0KPiA+Pi0tLSBhL2ZzL3Byb2Mvdm1jb3JlLmMNCj4gPj4rKysgYi9mcy9wcm9jL3Zt
Y29yZS5jDQo+ID4+QEAgLTk5OSw3ICs5OTksNyBAQCBzdGF0aWMgdm9pZCBmcmVlX2VsZmNv
cmVidWYodm9pZCkNCj4gPj4gIHN0YXRpYyBpbnQgX19pbml0IHBhcnNlX2NyYXNoX2VsZjY0
X2hlYWRlcnModm9pZCkNCj4gPj4gIHsNCj4gPj4gIAlpbnQgcmM9MDsNCj4gPj4tCUVsZjY0
X0VoZHIgZWhkcjsNCj4gPj4rCXN0cnVjdCBlbGZoZHIgZWhkcjsNCj4gPj4gIAl1NjQgYWRk
cjsNCj4gPj4gIAlhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KPiA+PkBAIC0xMDU1LDcgKzEw
NTUsNyBAQCBmYWlsOg0KPiA+PiAgc3RhdGljIGludCBfX2luaXQgcGFyc2VfY3Jhc2hfZWxm
MzJfaGVhZGVycyh2b2lkKQ0KPiA+PiAgew0KPiA+PiAgCWludCByYz0wOw0KPiA+Pi0JRWxm
MzJfRWhkciBlaGRyOw0KPiA+PisJc3RydWN0IGVsZmhkciBlaGRyOw0KPiA+PiAgCXU2NCBh
ZGRyOw0KPiA+PiAgCWFkZHIgPSBlbGZjb3JlaGRyX2FkZHI7DQo+IA0KPiANCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4ga2V4ZWMgbWFp
bGluZyBsaXN0DQo+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYw0K
--------------050305060608040500080803--
