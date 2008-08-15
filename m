Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 19:18:05 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:11947 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28576180AbYHOSSB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Aug 2008 19:18:01 +0100
X-IronPort-AV: E=Sophos;i="4.32,216,1217808000"; 
   d="2'?scan'208";a="75815333"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-2.cisco.com with ESMTP; 15 Aug 2008 18:17:47 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m7FIHlXb017741;
	Fri, 15 Aug 2008 11:17:47 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m7FIHlR9018728;
	Fri, 15 Aug 2008 18:17:47 GMT
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id SAA03465; Fri, 15 Aug 2008 18:17:22 GMT
Message-ID: <48A5C831.3070002@sciatl.com>
Date:	Fri, 15 Aug 2008 11:17:21 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Dave Hansen <dave@linux.vnet.ibm.com>
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>	 <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de>	 <1218815299.23641.80.camel@nimitz> <48A5AADE.1050808@sciatl.com>	 <20080815163302.GA9846@alpha.franken.de>  <48A5B9F1.3080201@sciatl.com> <1218821875.23641.103.camel@nimitz>
In-Reply-To: <1218821875.23641.103.camel@nimitz>
Content-Type: multipart/mixed;
 boundary="------------090307020305030806030909"
Authentication-Results:	sj-dkim-1; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <Michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090307020305030806030909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dave Hansen wrote:
> On Fri, 2008-08-15 at 10:16 -0700, C Michael Sundius wrote:
>   
>> Ah, your right. thanks.  "but it's not necessar*il*y a good idea".
>> That 
>> is to say, we don't put
>> memory above 2 GiB. No need to make the mem_section[] array bigger
>> than 
>> need be.
>>
>> This gives further credence for it to be a configurable in Kconfig as
>> well.
>>     
>
> I definitely don't want it to be something that users see.  It is never
> enough overhead to really care.  On a 16TB system with 16MB sections,
> the mem_section[] array is still only 16MB!!
>
> So, I'd say to just make it as big as the arch needs in the worst case
> (smallest SECTION_SIZE_BITS and largest MAX_PHYSMEM_BITS) and leave it.
> We might even want to merge the 32 and 64-bit versions.
>
> For your 32-bit version, we now use:
> 8 bytes (2 32-bit words) for each mem_section[]
> 2GB/128MB sections = 16
> So, that's only 512 bytes.
>
> ﻿For the 64-bit version, we now use:
> 16 bytes (2 64-bit words) for each mem_section[]
> 32GB/256MB sections = 128
> So, that's only 2048 bytes.
>
> If we were to merge the 32 and 64-bit versions to:
> #define SECTION_SIZE_BITS       27
> #define MAX_PHYSMEM_BITS        35
>
> Your 32-bit version would go to 2048 bytes, and the 64-bit version would
> go to 4096 bytes.  The 32-bit version would we able to address more
> memory, and the 64-bit version would be able to handle smaller memory
> holes more efficiently. 
>
> -- Dave
>
>   
Ah, compromise :] that's why you get paid the big bux dave. thanks.



--------------090307020305030806030909
Content-Type: text/plain;
 name="mypatchfile.2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mypatchfile.2"

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc3BhcnNlbWVtLnR4dCBiL0RvY3VtZW50YXRp
b24vc3BhcnNlbWVtLnR4dApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi44
OTY1NmUzCi0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9zcGFyc2VtZW0udHh0
CkBAIC0wLDAgKzEsOTYgQEAKK1NwYXJzZW1lbSBkaXZpZGVzIHVwIHBoeXNpY2FsIG1lbW9y
eSBpbiB5b3VyIHN5c3RlbSBpbnRvIE4gc2VjdGlvbiBvZiBNCitieXRlcy4gUGFnZSBkZXNj
cmlwdG9ycyBhcmUgY3JlYXRlZCBmb3Igb25seSB0aG9zZSBzZWN0aW9ucyB0aGF0CithY3R1
YWxseSBleGlzdCAoYXMgZmFyIGFzIHRoZSBzcGFyc2VtZW0gY29kZSBpcyBjb25jZXJuZWQp
LiBUaGlzIGFsbG93cworZm9yIGhvbGVzIGluIHRoZSBwaHlzaWNhbCBtZW1vcnkgd2l0aG91
dCBoYXZpbmcgdG8gd2FzdGUgc3BhY2UgYnkKK2NyZWF0aW5nIHBhZ2UgZGlzY3JpcHRvcnMg
Zm9yIHRob3NlIHBhZ2VzIHRoYXQgZG8gbm90IGV4aXN0LgorV2hlbiBwYWdlX3RvX3Bmbigp
IG9yIHBmbl90b19wYWdlKCkgYXJlIGNhbGxlZCB0aGVyZSBpcyBhIGJpdCBvZiBvdmVyaGVh
ZCB0bworbG9vayB1cCB0aGUgcHJvcGVyIG1lbW9yeSBzZWN0aW9uIHRvIGdldCB0byB0aGUg
ZGVzY3JpcHRvcnMsIGJ1dCB0aGlzCitpcyBzbWFsbCBjb21wYXJlZCB0byB0aGUgbWVtb3J5
IHlvdSBhcmUgbGlrZWx5IHRvIHNhdmUuIFNvLCBpdCdzIG5vdCB0aGUKK2RlZmF1bHQsIGJ1
dCBzaG91bGQgYmUgdXNlZCBpZiB5b3UgaGF2ZSBiaWcgaG9sZXMgaW4gcGh5c2ljYWwgbWVt
b3J5LgorCitOb3RlIHRoYXQgZGlzY29udGlndW91cyBtZW1vcnkgaXMgbW9yZSBjbG9zZWx5
IHJlbGF0ZWQgdG8gTlVNQSBtYWNoaW5lcworYW5kIGlmIHlvdSBhcmUgYSBzaW5nbGUgQ1BV
IHN5c3RlbSB1c2Ugc3BhcnNlbWVtIGFuZCBub3QgZGlzY29udGlnLiAKK0l0J3MgbXVjaCBz
aW1wbGVyLiAKKworMSkgQ0FMTCBNRU1PUllfUFJFU0VOVCgpCitPbmNlIHRoZSBib290bWVt
IGFsbG9jYXRvciBpcyB1cCBhbmQgcnVubmluZywgeW91IHNob3VsZCBjYWxsIHRoZQorc3Bh
cnNlbWVtIGZ1bmN0aW9uICJtZW1vcnlfcHJlc2VudChub2RlLCBwZm5fc3RhcnQsIHBmbl9l
bmQpIiBmb3IgZWFjaAorYmxvY2sgb2YgbWVtb3J5IHRoYXQgZXhpc3RzIG9uIHlvdXIgc3lz
dGVtLgorCisyKSBERVRFUk1JTkUgQU5EIFNFVCBUSEUgU0laRSBPRiBTRUNUSU9OUyBBTkQg
UEhZU01FTQorVGhlIHNpemUgb2YgTiBhbmQgTSBhYm92ZSBkZXBlbmQgdXBvbiB5b3VyIGFy
Y2hpdGVjdHVyZQorYW5kIHlvdXIgcGxhdGZvcm0gYW5kIGFyZSBzcGVjaWZpZWQgaW4gdGhl
IGZpbGU6CisKKyAgICAgIGluY2x1ZGUvYXNtLTx5b3VyX2FyY2g+L3NwYXJzZW1lbS5oCisK
K2FuZCB5b3Ugc2hvdWxkIGNyZWF0ZSB0aGUgZm9sbG93aW5nIGxpbmVzIHNpbWlsYXIgdG8g
YmVsb3c6IAorCisJI2RlZmluZSBTRUNUSU9OX1NJWkVfQklUUyAgICAgICAyNwkvKiAxMjgg
TWlCICovCisJI2RlZmluZSBNQVhfUEhZU01FTV9CSVRTICAgICAgICAzMQkvKiAyIEdpQiAg
ICovCisKK2lmIHRoZXkgZG9uJ3QgYWxyZWFkeSBleGlzdCwgd2hlcmU6IAorCisgKiBTRUNU
SU9OX1NJWkVfQklUUyAgICAgICAgICAgIDJeTTogaG93IGJpZyBlYWNoIHNlY3Rpb24gd2ls
bCBiZQorICogTUFYX1BIWVNNRU1fQklUUyAgICAgICAgICAgICAyXk46IGhvdyBtdWNoIG1l
bW9yeSB3ZSBjYW4gaGF2ZSBpbiB0aGF0CisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3BhY2UKKworU2VjdGlvbiBzaXplIHNob3VsZCBiZSBlcXVhbCBvciBsZXNz
IHRoYW4gdGhlIHNtYWxsZXN0IGJsb2NrIG9mCittZW1vcnkgaW4geW91ciBzeXN0ZW0uIE1h
eCBwaHlzbWVtIHNob3VsZCBiZSBncmVhdGVyIHRoYW4gb3IgCitlcXVhbCB0byB0aGUgaGln
aGVzdCBwaHlzaWNhbCBtZW1vcnkgYWRkcmVzcyBvZiBtZW1vcnkgaW4geW91cgorc3lzdGVt
LgorCiszKSBJTklUSUFMSVpFIFNQQVJTRSBNRU1PUlkKK1lvdSBzaG91bGQgbWFrZSBzdXJl
IHRoYXQgeW91IGluaXRpYWxpemUgdGhlIHNwYXJzZSBtZW1vcnkgY29kZSBieSBjYWxsaW5n
IAorCisJYm9vdG1lbV9pbml0KCk7CisgICsJc3BhcnNlX2luaXQoKTsKKwlwYWdpbmdfaW5p
dCgpOworCitqdXN0IGJlZm9yZSB5b3UgY2FsbCBwYWdpbmdfaW5pdCgpIGFuZCBhZnRlciB0
aGUgYm9vdG1lbV9hbGxvY2F0b3IgaXMKK3R1cm5lZCBvbiBpbiB5b3VyIHNldHVwX2FyY2go
KSBjb2RlLiAgCisKKzQpIEVOQUJMRSBTUEFSU0VNRU0gSU4gS0NPTkZJRworQWRkIGEgbGlu
ZSBsaWtlIHRoaXM6CisKKwlzZWxlY3QgQVJDSF9TUEFSU0VNRU1fRU5BQkxFCisKK2ludG8g
dGhlIGNvbmZpZyBmb3IgeW91ciBwbGF0Zm9ybSBpbiBhcmNoLzx5b3VyX2FyY2g+L0tjb25m
aWcuIFRoaXMgd2lsbAorZW5zdXJlIHRoYXQgdHVybmluZyBvbiBzcGFyc2VtZW0gaXMgZW5h
YmxlZCBmb3IgeW91ciBwbGF0Zm9ybS4gCisKKzUpIENPTkZJRworUnVuIG1ha2UgbWVudWNv
bmZpZyBvciBtYWtlIGdjb25maWcsIGFzIHlvdSBsaWtlLCBhbmQgdHVybiBvbiB0aGUgc3Bh
cnNlbWVtCittZW1vcnkgbW9kZWwgdW5kZXIgdGhlICJLZXJuZWwgVHlwZSIgLS0+ICJNZW1v
cnkgTW9kZWwiIGFuZCB0aGVuIGJ1aWxkIHlvdXIKK2tlcm5lbC4KKworCis2KSBHb3RjaGFz
CisKK09uZSB0cmljayB0aGF0IEkgZW5jb3VudGVyZWQgd2hlbiBJIHdhcyB0dXJuaW5nIHRo
aXMgb24gZm9yIE1JUFMgd2FzIHRoYXQgdGhlcmUKK3dhcyBzb21lIGNvZGUgaW4gbWVtX2lu
aXQoKSB0aGF0IHNldCB0aGUgInJlc2VydmVkIiBmbGFnIGZvciBwYWdlcyB0aGF0IHdlcmUg
bm90Cit2YWxpZCBSQU0uIFRoaXMgY2F1c2VkIG15IGtlcm5lbCB0byBjcmFzaCB3aGVuIEkg
ZW5hYmxlZCBzcGFyc2VtZW0gc2luY2UgdGhvc2UKK3BhZ2VzIChhbmQgcGFnZSBkZXNjcmlw
dG9ycykgZGlkbid0IGFjdHVhbGx5IGV4aXN0LiBJIGNoYW5nZWQgbXkgY29kZSBieSBhZGRp
bmcKK2xpbmVzIGxpa2UgYmVsb3c6CisKKworCWZvciAodG1wID0gaGlnaHN0YXJ0X3Bmbjsg
dG1wIDwgaGlnaGVuZF9wZm47IHRtcCsrKSB7CisJCXN0cnVjdCBwYWdlICpwYWdlID0gcGZu
X3RvX3BhZ2UodG1wKTsKKworICAgKwkJaWYgKCFwZm5fdmFsaWQodG1wKSkKKyAgICsJCQlj
b250aW51ZTsKKyAgICsKKwkJaWYgKCFwYWdlX2lzX3JhbSh0bXApKSB7CisJCQlTZXRQYWdl
UmVzZXJ2ZWQocGFnZSk7CisJCQljb250aW51ZTsKKwkJfQorCQlDbGVhclBhZ2VSZXNlcnZl
ZChwYWdlKTsKKwkJaW5pdF9wYWdlX2NvdW50KHBhZ2UpOworCQlfX2ZyZWVfcGFnZShwYWdl
KTsKKwkJcGh5c21lbV9yZWNvcmQoUEZOX1BIWVModG1wKSwgUEFHRV9TSVpFLCBwaHlzbWVt
X2hpZ2htZW0pOworCQl0b3RhbGhpZ2hfcGFnZXMrKzsKKwl9CisKKworT25jZSBJIGdvdCB0
aGF0IHN0cmFpZ2h0LCBpdCB3b3JrZWQhISEhIEkgc2F2ZWQgMTBNaUIgb2YgbWVtb3J5LiAg
CisKKworCmRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL3NldHVwLmMgYi9hcmNoL21p
cHMva2VybmVsL3NldHVwLmMKaW5kZXggYzZhMDYzYi4uNWIxYWY4NyAxMDA2NDQKLS0tIGEv
YXJjaC9taXBzL2tlcm5lbC9zZXR1cC5jCisrKyBiL2FyY2gvbWlwcy9rZXJuZWwvc2V0dXAu
YwpAQCAtNDA4LDcgKzQwOCw2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBib290bWVtX2luaXQo
dm9pZCkKIAogCQkvKiBSZWdpc3RlciBsb3dtZW0gcmFuZ2VzICovCiAJCWZyZWVfYm9vdG1l
bShQRk5fUEhZUyhzdGFydCksIHNpemUgPDwgUEFHRV9TSElGVCk7Ci0JCW1lbW9yeV9wcmVz
ZW50KDAsIHN0YXJ0LCBlbmQpOwogCX0KIAogCS8qCkBAIC00MjAsNiArNDE5LDIzIEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBib290bWVtX2luaXQodm9pZCkKIAkgKiBSZXNlcnZlIGluaXRy
ZCBtZW1vcnkgaWYgbmVlZGVkLgogCSAqLwogCWZpbmFsaXplX2luaXRyZCgpOworCisJLyog
Y2FsbCBtZW1vcnkgcHJlc2VudCBmb3IgYWxsIHRoZSByYW0gKi8KKwlmb3IgKGkgPSAwOyBp
IDwgYm9vdF9tZW1fbWFwLm5yX21hcDsgaSsrKSB7CisJCXVuc2lnbmVkIGxvbmcgc3RhcnQs
IGVuZDsKKworCQkvKgorCQkgKiBtZW1vcnkgcHJlc2VudCBvbmx5IHVzYWJsZSBtZW1vcnku
CisJCSAqLworCQlpZiAoYm9vdF9tZW1fbWFwLm1hcFtpXS50eXBlICE9IEJPT1RfTUVNX1JB
TSkKKwkJCWNvbnRpbnVlOworCisJCXN0YXJ0ID0gUEZOX1VQKGJvb3RfbWVtX21hcC5tYXBb
aV0uYWRkcik7CisJCWVuZCAgID0gUEZOX0RPV04oYm9vdF9tZW1fbWFwLm1hcFtpXS5hZGRy
CisJCQkJICAgICsgYm9vdF9tZW1fbWFwLm1hcFtpXS5zaXplKTsKKworCQltZW1vcnlfcHJl
c2VudCgwLCBzdGFydCwgZW5kKTsKKwl9CiB9CiAKICNlbmRpZgkvKiBDT05GSUdfU0dJX0lQ
MjcgKi8KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9tbS9pbml0LmMgYi9hcmNoL21pcHMvbW0v
aW5pdC5jCmluZGV4IDEzN2MxNGIuLjMxNDk2YTEgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9t
bS9pbml0LmMKKysrIGIvYXJjaC9taXBzL21tL2luaXQuYwpAQCAtNDE0LDYgKzQxNCw5IEBA
IHZvaWQgX19pbml0IG1lbV9pbml0KHZvaWQpCiAJZm9yICh0bXAgPSBoaWdoc3RhcnRfcGZu
OyB0bXAgPCBoaWdoZW5kX3BmbjsgdG1wKyspIHsKIAkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBw
Zm5fdG9fcGFnZSh0bXApOwogCisJCWlmICghcGZuX3ZhbGlkKHRtcCkpCisJCQljb250aW51
ZTsKKwogCQlpZiAoIXBhZ2VfaXNfcmFtKHRtcCkpIHsKIAkJCVNldFBhZ2VSZXNlcnZlZChw
YWdlKTsKIAkJCWNvbnRpbnVlOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tbWlwcy9zcGFy
c2VtZW0uaCBiL2luY2x1ZGUvYXNtLW1pcHMvc3BhcnNlbWVtLmgKaW5kZXggNzk1YWM2Yy4u
NjQzNzZkYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tbWlwcy9zcGFyc2VtZW0uaAorKysg
Yi9pbmNsdWRlL2FzbS1taXBzL3NwYXJzZW1lbS5oCkBAIC02LDcgKzYsNyBAQAogICogU0VD
VElPTl9TSVpFX0JJVFMJCTJeTjogaG93IGJpZyBlYWNoIHNlY3Rpb24gd2lsbCBiZQogICog
TUFYX1BIWVNNRU1fQklUUwkJMl5OOiBob3cgbXVjaCBtZW1vcnkgd2UgY2FuIGhhdmUgaW4g
dGhhdCBzcGFjZQogICovCi0jZGVmaW5lIFNFQ1RJT05fU0laRV9CSVRTICAgICAgIDI4Cisj
ZGVmaW5lIFNFQ1RJT05fU0laRV9CSVRTICAgICAgIDI3CS8qIDEyOCBNaUIgKi8KICNkZWZp
bmUgTUFYX1BIWVNNRU1fQklUUyAgICAgICAgMzUKIAogI2VuZGlmIC8qIENPTkZJR19TUEFS
U0VNRU0gKi8K
--------------090307020305030806030909--
