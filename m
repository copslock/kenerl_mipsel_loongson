Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 15:52:06 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:60990 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20038542AbWIYOwE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 15:52:04 +0100
Received: by py-out-1112.google.com with SMTP id i49so2144958pyi
        for <linux-mips@linux-mips.org>; Mon, 25 Sep 2006 07:51:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type;
        b=YtDVKWCY/1saSKGOgRWAI6WUpynP4VNpLhxZHkhvyECklxqJXqfJE3Ali1Q25LwVzbK7/5sa8Dv7ygpLyKrLtbGAd7sSlCJLMMjeybVBj+uGeh+EFHH2KbxkFrdpG/YtbFrzMMTyXLYuExKyxtAmDC1O48Sv2pbdq1y/5V/GH/I=
Received: by 10.35.123.10 with SMTP id a10mr7930121pyn;
        Mon, 25 Sep 2006 07:51:59 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id 60sm7575pyg.2006.09.25.07.51.55;
        Mon, 25 Sep 2006 07:51:59 -0700 (PDT)
User-Agent: Microsoft-Entourage/11.2.1.051004
Date:	Mon, 25 Sep 2006 23:51:46 +0900
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	girish <girishvg@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:	girish <girishvg@gmail.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Message-ID: <C13E1C13.6FDC%girishvg@gmail.com>
Thread-Topic: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
Thread-Index: Acbgsh9EXawEE0ylEdulewATIGIqNA==
In-Reply-To: <20060925.002616.126574366.anemo@mba.ocn.ne.jp>
Mime-version: 1.0
Content-type: multipart/mixed;
	boundary="B_3242073115_4886914"
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3242073115_4886914
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit


Here is the patch again, attached as a text file. I don't have idea how
these macros should be on a 64bit machine, so I just left them as it is.
Could you please verify these macros again?


On 9/25/06 12:26 AM, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp> wrote:

> On Sun, 24 Sep 2006 14:39:38 +0900, girish <girishvg@gmail.com> wrote:
>> --- linux-vanilla/include/asm-mips/page.h 2006-09-24 12:23:34.000000000 +0900
>> +++ linux/include/asm-mips/page.h 2006-09-24 14:00:53.000000000 +0900
>> @@ -134,8 +134,13 @@ typedef struct { unsigned long pgprot; }
>>  /* to align the pointer to the (next) page boundary */
>>  #define PAGE_ALIGN(addr) (((addr) + PAGE_SIZE - 1) & PAGE_MASK)
>> 
>> -#define __pa(x)   ((unsigned long) (x) - PAGE_OFFSET)
>> -#define __va(x)   ((void *)((unsigned long) (x) + PAGE_OFFSET))
>> +#define UNMAPLIMIT              (UNCAC_BASE - CAC_BASE) /*HIGHMEM_START*/
>> +#define ISMAPPED(x)             (KSEGX((x)) > UNMAPLIMIT)
>> +#define ___pa(x)  ((unsigned long) (x) - PAGE_OFFSET)
>> +#define __pa(x)          (ISMAPPED(x) ? (x) : ___pa(x))
>> +
>> +#define ___va(x)  ((void *)((unsigned long) (x) + PAGE_OFFSET))
>> +#define __va(x)   (ISMAPPED(x) ? (x) : ___va(x))
>> 
>>  #define pfn_to_kaddr(pfn) __va((pfn) << PAGE_SHIFT)
> 
> This part looks broken for 64-bit kernel.
> 
> For other parts, it would be better to keep correct indentation level.
> 
> ---
> Atsushi Nemoto


--B_3242073115_4886914
Content-type: application/octet-stream; name="patch-basicfix-20060925"
Content-disposition: attachment;
	filename="patch-basicfix-20060925"
Content-transfer-encoding: base64

ZGlmZiAtdXByTiAtWCBsaW51eC12YW5pbGxhL0RvY3VtZW50YXRpb24vZG9udGRpZmYgbGlu
dXgtdmFuaWxsYS9hcmNoL21pcHMvbW0vZG1hLW5vbmNvaGVyZW50LmMgbGludXgvYXJjaC9t
aXBzL21tL2RtYS1ub25jb2hlcmVudC5jCi0tLSBsaW51eC12YW5pbGxhL2FyY2gvbWlwcy9t
bS9kbWEtbm9uY29oZXJlbnQuYwkyMDA2LTA5LTI0IDEyOjIyOjQ2LjAwMDAwMDAwMCArMDkw
MAorKysgbGludXgvYXJjaC9taXBzL21tL2RtYS1ub25jb2hlcmVudC5jCTIwMDYtMDktMjUg
MjI6Mzg6MzguMDAwMDAwMDAwICswOTAwCkBAIC0zMzQsNyArMzM0LDcgQEAgRVhQT1JUX1NZ
TUJPTChwY2lfZGFjX3BhZ2VfdG9fZG1hKTsKIHN0cnVjdCBwYWdlICpwY2lfZGFjX2RtYV90
b19wYWdlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogCWRtYTY0X2FkZHJfdCBkbWFfYWRkcikK
IHsKLQlyZXR1cm4gbWVtX21hcCArIChkbWFfYWRkciA+PiBQQUdFX1NISUZUKTsKKwlyZXR1
cm4gcGZuX3RvX3BhZ2UgKGRtYV9hZGRyID4+IFBBR0VfU0hJRlQpOwogfQogCiBFWFBPUlRf
U1lNQk9MKHBjaV9kYWNfZG1hX3RvX3BhZ2UpOwpkaWZmIC11cHJOIC1YIGxpbnV4LXZhbmls
bGEvRG9jdW1lbnRhdGlvbi9kb250ZGlmZiBsaW51eC12YW5pbGxhL2FyY2gvbWlwcy9tbS9p
bml0LmMgbGludXgvYXJjaC9taXBzL21tL2luaXQuYwotLS0gbGludXgtdmFuaWxsYS9hcmNo
L21pcHMvbW0vaW5pdC5jCTIwMDYtMDktMjQgMTI6MjI6NDYuMDAwMDAwMDAwICswOTAwCisr
KyBsaW51eC9hcmNoL21pcHMvbW0vaW5pdC5jCTIwMDYtMDktMjUgMjI6NDM6MjIuMDAwMDAw
MDAwICswOTAwCkBAIC0xNTUsMjQgKzE1NSwyMiBAQCB2b2lkIF9faW5pdCBwYWdpbmdfaW5p
dCh2b2lkKQogCWxvdyA9IG1heF9sb3dfcGZuOwogCWhpZ2ggPSBoaWdoZW5kX3BmbjsKIAot
I2lmZGVmIENPTkZJR19JU0EKLQlpZiAobG93IDwgbWF4X2RtYSkKKwlpZiAobG93IDwgbWF4
X2RtYSkgewogCQl6b25lc19zaXplW1pPTkVfRE1BXSA9IGxvdzsKLQllbHNlIHsKKwl9IGVs
c2UgewogCQl6b25lc19zaXplW1pPTkVfRE1BXSA9IG1heF9kbWE7CiAJCXpvbmVzX3NpemVb
Wk9ORV9OT1JNQUxdID0gbG93IC0gbWF4X2RtYTsKIAl9Ci0jZWxzZQotCXpvbmVzX3NpemVb
Wk9ORV9ETUFdID0gbG93OwotI2VuZGlmCisKICNpZmRlZiBDT05GSUdfSElHSE1FTQogCWlm
IChjcHVfaGFzX2RjX2FsaWFzZXMpIHsKIAkJcHJpbnRrKEtFUk5fV0FSTklORyAiVGhpcyBw
cm9jZXNzb3IgZG9lc24ndCBzdXBwb3J0IGhpZ2htZW0uIik7CiAJCWlmIChoaWdoIC0gbG93
KQogCQkJcHJpbnRrKCIgJWxkayBoaWdobWVtIGlnbm9yZWQiLCBoaWdoIC0gbG93KTsKIAkJ
cHJpbnRrKCJcbiIpOwotCX0gZWxzZQotCQl6b25lc19zaXplW1pPTkVfSElHSE1FTV0gPSBo
aWdoIC0gbG93OworCX0gZWxzZSB7CisJCXpvbmVzX3NpemVbWk9ORV9ISUdITUVNXSA9IGhp
Z2ggLSBoaWdoc3RhcnRfcGZuOworCX0KICNlbmRpZgogCiAJZnJlZV9hcmVhX2luaXQoem9u
ZXNfc2l6ZSk7CkBAIC0yMzMsNyArMjMxLDcgQEAgdm9pZCBfX2luaXQgbWVtX2luaXQodm9p
ZCkKIAogI2lmZGVmIENPTkZJR19ISUdITUVNCiAJZm9yICh0bXAgPSBoaWdoc3RhcnRfcGZu
OyB0bXAgPCBoaWdoZW5kX3BmbjsgdG1wKyspIHsKLQkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBt
ZW1fbWFwICsgdG1wOworCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHRtcCk7
CiAKIAkJaWYgKCFwYWdlX2lzX3JhbSh0bXApKSB7CiAJCQlTZXRQYWdlUmVzZXJ2ZWQocGFn
ZSk7CmRpZmYgLXVwck4gLVggbGludXgtdmFuaWxsYS9Eb2N1bWVudGF0aW9uL2RvbnRkaWZm
IGxpbnV4LXZhbmlsbGEvaW5jbHVkZS9hc20tbWlwcy9kbWEuaCBsaW51eC9pbmNsdWRlL2Fz
bS1taXBzL2RtYS5oCi0tLSBsaW51eC12YW5pbGxhL2luY2x1ZGUvYXNtLW1pcHMvZG1hLmgJ
MjAwNi0wOS0yNCAxMjoyMzozNC4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4L2luY2x1ZGUv
YXNtLW1pcHMvZG1hLmgJMjAwNi0wOS0yNSAyMjo0NToyOC4wMDAwMDAwMDAgKzA5MDAKQEAg
LTg3LDggKzg3LDEzIEBACiAvKiBIb3JyaWJsZSBoYWNrIHRvIGhhdmUgYSBjb3JyZWN0IERN
QSB3aW5kb3cgb24gSVAyMiAqLwogI2luY2x1ZGUgPGFzbS9zZ2kvbWMuaD4KICNkZWZpbmUg
TUFYX0RNQV9BRERSRVNTCQkoUEFHRV9PRkZTRVQgKyBTR0lNQ19TRUcwX0JBRERSICsgMHgw
MTAwMDAwMCkKLSNlbHNlCisjZWxpZiBkZWZpbmVkKENPTkZJR19JU0EpCiAjZGVmaW5lIE1B
WF9ETUFfQUREUkVTUwkJKFBBR0VfT0ZGU0VUICsgMHgwMTAwMDAwMCkKKyNlbHNlCisjaWZu
ZGVmIFBMQVRfTUFYX0RNQV9TSVpFCisjZGVmaW5lIFBMQVRfTUFYX0RNQV9TSVpFCTB4MTAw
MDAwMDAJLyogMjU2TUI6IHRydWUgZm9yIG1vc3Qgb2YgdGhlIE1JUFMzMiBzeXN0ZW1zICov
CisjZW5kaWYKKyNkZWZpbmUgTUFYX0RNQV9BRERSRVNTCQkoUEFHRV9PRkZTRVQgKyBQTEFU
X01BWF9ETUFfU0laRSkKICNlbmRpZgogCiAvKiA4MjM3IERNQSBjb250cm9sbGVycyAqLwpk
aWZmIC11cHJOIC1YIGxpbnV4LXZhbmlsbGEvRG9jdW1lbnRhdGlvbi9kb250ZGlmZiBsaW51
eC12YW5pbGxhL2luY2x1ZGUvYXNtLW1pcHMvaW8uaCBsaW51eC9pbmNsdWRlL2FzbS1taXBz
L2lvLmgKLS0tIGxpbnV4LXZhbmlsbGEvaW5jbHVkZS9hc20tbWlwcy9pby5oCTIwMDYtMDkt
MjQgMTI6MjM6MzQuMDAwMDAwMDAwICswOTAwCisrKyBsaW51eC9pbmNsdWRlL2FzbS1taXBz
L2lvLmgJMjAwNi0wOS0yNSAyMjo1MTozMS4wMDAwMDAwMDAgKzA5MDAKQEAgLTExNiw3ICsx
MTYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2V0X2lvX3BvcnRfYmFzZSh1bnNpCiAgKi8K
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyB2aXJ0X3RvX3BoeXModm9sYXRpbGUgdm9p
ZCAqIGFkZHJlc3MpCiB7Ci0JcmV0dXJuICh1bnNpZ25lZCBsb25nKWFkZHJlc3MgLSBQQUdF
X09GRlNFVDsKKwlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpIF9fcGEoYWRkcmVzcyk7CiB9CiAK
IC8qCkBAIC0xMzMsNyArMTMzLDcgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHZp
cnRfdG9fcGh5cwogICovCiBzdGF0aWMgaW5saW5lIHZvaWQgKiBwaHlzX3RvX3ZpcnQodW5z
aWduZWQgbG9uZyBhZGRyZXNzKQogewotCXJldHVybiAodm9pZCAqKShhZGRyZXNzICsgUEFH
RV9PRkZTRVQpOworCXJldHVybiAodm9pZCAqKSBfX3ZhKGFkZHJlc3MpOwogfQogCiAvKgpA
QCAtMTQxLDEyICsxNDEsMTIgQEAgc3RhdGljIGlubGluZSB2b2lkICogcGh5c190b192aXJ0
KHVuc2lnbgogICovCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgaXNhX3ZpcnRfdG9f
YnVzKHZvbGF0aWxlIHZvaWQgKiBhZGRyZXNzKQogewotCXJldHVybiAodW5zaWduZWQgbG9u
ZylhZGRyZXNzIC0gUEFHRV9PRkZTRVQ7CisJcmV0dXJuICh1bnNpZ25lZCBsb25nKSBfX3Bh
KGFkZHJlc3MpOwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgKiBpc2FfYnVzX3RvX3ZpcnQo
dW5zaWduZWQgbG9uZyBhZGRyZXNzKQogewotCXJldHVybiAodm9pZCAqKShhZGRyZXNzICsg
UEFHRV9PRkZTRVQpOworCXJldHVybiAodm9pZCAqKSBfX3ZhKGFkZHJlc3MpOwogfQogCiAj
ZGVmaW5lIGlzYV9wYWdlX3RvX2J1cyBwYWdlX3RvX3BoeXMKZGlmZiAtdXByTiAtWCBsaW51
eC12YW5pbGxhL0RvY3VtZW50YXRpb24vZG9udGRpZmYgbGludXgtdmFuaWxsYS9pbmNsdWRl
L2FzbS1taXBzL3BhZ2UuaCBsaW51eC9pbmNsdWRlL2FzbS1taXBzL3BhZ2UuaAotLS0gbGlu
dXgtdmFuaWxsYS9pbmNsdWRlL2FzbS1taXBzL3BhZ2UuaAkyMDA2LTA5LTI0IDEyOjIzOjM0
LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgvaW5jbHVkZS9hc20tbWlwcy9wYWdlLmgJMjAw
Ni0wOS0yNSAyMjo1MDo0MC4wMDAwMDAwMDAgKzA5MDAKQEAgLTEzNCw4ICsxMzQsMTcgQEAg
dHlwZWRlZiBzdHJ1Y3QgeyB1bnNpZ25lZCBsb25nIHBncHJvdDsgfQogLyogdG8gYWxpZ24g
dGhlIHBvaW50ZXIgdG8gdGhlIChuZXh0KSBwYWdlIGJvdW5kYXJ5ICovCiAjZGVmaW5lIFBB
R0VfQUxJR04oYWRkcikJKCgoYWRkcikgKyBQQUdFX1NJWkUgLSAxKSAmIFBBR0VfTUFTSykK
IAotI2RlZmluZSBfX3BhKHgpCQkJKCh1bnNpZ25lZCBsb25nKSAoeCkgLSBQQUdFX09GRlNF
VCkKLSNkZWZpbmUgX192YSh4KQkJCSgodm9pZCAqKSgodW5zaWduZWQgbG9uZykgKHgpICsg
UEFHRV9PRkZTRVQpKQorI2lmZGVmIENPTkZJR18zMkJJVAorI2RlZmluZSBJU01BUFBFRCh4
KQkJKEtTRUdYKCh4KSkgPj0gSElHSE1FTV9TVEFSVCAmJiBLU0VHWCgoeCkpIDwgS1NFRzAp
CisjZWxzZQorI2RlZmluZSBJU01BUFBFRCh4KQkJKDApCisjZW5kaWYKKworI2RlZmluZSBf
X19wYSh4KQkJKCh1bnNpZ25lZCBsb25nKSAoeCkgLSBQQUdFX09GRlNFVCkKKyNkZWZpbmUg
X19wYSh4KQkJCShJU01BUFBFRCh4KSA/ICh4KSA6IF9fX3BhKHgpKQorCisjZGVmaW5lIF9f
X3ZhKHgpCQkoKHZvaWQgKikoKHVuc2lnbmVkIGxvbmcpICh4KSArIFBBR0VfT0ZGU0VUKSkK
KyNkZWZpbmUgX192YSh4KQkJCShJU01BUFBFRCh4KSA/ICh4KSA6IF9fX3ZhKHgpKQogCiAj
ZGVmaW5lIHBmbl90b19rYWRkcihwZm4pCV9fdmEoKHBmbikgPDwgUEFHRV9TSElGVCkKIAo=

--B_3242073115_4886914--
