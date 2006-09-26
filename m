Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 23:06:25 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:13177 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20038972AbWIZWGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 23:06:23 +0100
Received: by py-out-1112.google.com with SMTP id i49so2654259pyi
        for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 15:06:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type;
        b=E/CatyHixH32LvVWsb4qqj79r6fHiniipkBT+a4EZqGWzGjdiJ3SM/YCgZh060GNLqHGiYLWcrIy9pY8RMmSuCEfONbTTk3d0RcmNx6LoeusBxKvcvcroRi+EFi13jreaE5xP7brjiRfy6TeZWJDK/K2dZGc+bjgbjqBqkrWZaQ=
Received: by 10.35.101.1 with SMTP id d1mr1692928pym;
        Tue, 26 Sep 2006 15:06:21 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id w66sm4259665pyw.2006.09.26.15.06.18;
        Tue, 26 Sep 2006 15:06:20 -0700 (PDT)
User-Agent: Microsoft-Entourage/11.2.1.051004
Date:	Wed, 27 Sep 2006 07:06:10 +0900
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	girish <girishvg@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	girish <girishvg@gmail.com>
Message-ID: <C13FD364.7334%girishvg@gmail.com>
Thread-Topic: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
Thread-Index: Acbht/kIN7Jphk2rEdulewATIGIqNA==
In-Reply-To: <20060927.013553.48803581.anemo@mba.ocn.ne.jp>
Mime-version: 1.0
Content-type: multipart/mixed;
	boundary="B_3242185576_6409718"
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3242185576_6409718
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit


>> But, then again treating all addresses as above PAGE_OFFSET is also wrong :)
> 
> It would be a design not a bug :-)
> 
>> I looked at it just as a work around. These macros are called from so many
>> other places that if an access is made at say 4000_0000 the kernel will oops
>> telling it was C000_0000 access error. Now that confused me a lot! With this
>> change now kernel oops on 4000_0000 :)
> 
> Yes, 4000_0000, which is wrong too.  And it _hides_ wrong usage of
> vaddr/paddr.  Bad side effect :)
> 
>> Anyway, you may ignore __pa/__va macros.
>> 
>> Could you please look into other changes I proposed?
> 
> __pa() returns "unsigned long" and __va() returns "void *" so some
> casts are also redundant.

After removing some of the redundant casts, re-submitting the patch.
Attached the patch in a text file.
 
In the meantime, I couldn't find the changes suggested for SPARSEMEM support
in the main source tree. Especially the ones reviewed during month of August
([PATCH] do not count pages in holes with sparsemem ...). Could you please
resend the consolidated patch to the list? Thanks.

BTW, I have couple of more changes in mind.
.1a Currently only one PCI DMA window is supported. We need to extend that,
if the PCI controller has multiple windows. Example implementation is in
arch/powerpc.
.1b During HIGHMEM support the PCI windows are not honored correctly. A
kmap() based mapping could be provided during PCI sync. Example
implementation, again arch/powerpc. Has anybody looked into this?
.2 Has anybody tested /dev/mem and/or /dev/kmem devices on MIPS platform?


--B_3242185576_6409718
Content-type: application/octet-stream; name="patch-basicfix-20060927"
Content-disposition: attachment;
	filename="patch-basicfix-20060927"
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
KyBsaW51eC9hcmNoL21pcHMvbW0vaW5pdC5jCTIwMDYtMDktMjUgMjI6NTg6MTUuMDAwMDAw
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
L2lvLmgJMjAwNi0wOS0yNyAwNjo0NToxNS4wMDAwMDAwMDAgKzA5MDAKQEAgLTExNiw3ICsx
MTYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2V0X2lvX3BvcnRfYmFzZSh1bnNpCiAgKi8K
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyB2aXJ0X3RvX3BoeXModm9sYXRpbGUgdm9p
ZCAqIGFkZHJlc3MpCiB7Ci0JcmV0dXJuICh1bnNpZ25lZCBsb25nKWFkZHJlc3MgLSBQQUdF
X09GRlNFVDsKKwlyZXR1cm4gX19wYShhZGRyZXNzKTsKIH0KIAogLyoKQEAgLTEzMyw3ICsx
MzMsNyBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgdmlydF90b19waHlzCiAgKi8K
IHN0YXRpYyBpbmxpbmUgdm9pZCAqIHBoeXNfdG9fdmlydCh1bnNpZ25lZCBsb25nIGFkZHJl
c3MpCiB7Ci0JcmV0dXJuICh2b2lkICopKGFkZHJlc3MgKyBQQUdFX09GRlNFVCk7CisJcmV0
dXJuIF9fdmEoYWRkcmVzcyk7CiB9CiAKIC8qCkBAIC0xNDEsMTIgKzE0MSwxMiBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgKiBwaHlzX3RvX3ZpcnQodW5zaWduCiAgKi8KIHN0YXRpYyBpbmxp
bmUgdW5zaWduZWQgbG9uZyBpc2FfdmlydF90b19idXModm9sYXRpbGUgdm9pZCAqIGFkZHJl
c3MpCiB7Ci0JcmV0dXJuICh1bnNpZ25lZCBsb25nKWFkZHJlc3MgLSBQQUdFX09GRlNFVDsK
KwlyZXR1cm4gX19wYShhZGRyZXNzKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkICogaXNh
X2J1c190b192aXJ0KHVuc2lnbmVkIGxvbmcgYWRkcmVzcykKIHsKLQlyZXR1cm4gKHZvaWQg
KikoYWRkcmVzcyArIFBBR0VfT0ZGU0VUKTsKKwlyZXR1cm4gX192YShhZGRyZXNzKTsKIH0K
IAogI2RlZmluZSBpc2FfcGFnZV90b19idXMgcGFnZV90b19waHlzCmRpZmYgLXVwck4gLVgg
bGludXgtdmFuaWxsYS9Eb2N1bWVudGF0aW9uL2RvbnRkaWZmIGxpbnV4LXZhbmlsbGEvaW5j
bHVkZS9hc20tbWlwcy9wYWdlLmggbGludXgvaW5jbHVkZS9hc20tbWlwcy9wYWdlLmgKLS0t
IGxpbnV4LXZhbmlsbGEvaW5jbHVkZS9hc20tbWlwcy9wYWdlLmgJMjAwNi0wOS0yNCAxMjoy
MzozNC4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4L2luY2x1ZGUvYXNtLW1pcHMvcGFnZS5o
CTIwMDYtMDktMjcgMDY6NDY6MjQuMDAwMDAwMDAwICswOTAwCkBAIC0xMzQsOCArMTM0LDE3
IEBAIHR5cGVkZWYgc3RydWN0IHsgdW5zaWduZWQgbG9uZyBwZ3Byb3Q7IH0KIC8qIHRvIGFs
aWduIHRoZSBwb2ludGVyIHRvIHRoZSAobmV4dCkgcGFnZSBib3VuZGFyeSAqLwogI2RlZmlu
ZSBQQUdFX0FMSUdOKGFkZHIpCSgoKGFkZHIpICsgUEFHRV9TSVpFIC0gMSkgJiBQQUdFX01B
U0spCiAKLSNkZWZpbmUgX19wYSh4KQkJCSgodW5zaWduZWQgbG9uZykgKHgpIC0gUEFHRV9P
RkZTRVQpCi0jZGVmaW5lIF9fdmEoeCkJCQkoKHZvaWQgKikoKHVuc2lnbmVkIGxvbmcpICh4
KSArIFBBR0VfT0ZGU0VUKSkKKyNpZmRlZiBDT05GSUdfMzJCSVQKKyNkZWZpbmUgSVNNQVBQ
RUQoeCkJKEtTRUdYKCh4KSkgPj0gSElHSE1FTV9TVEFSVCAmJiBLU0VHWCgoeCkpIDwgS1NF
RzApCisjZWxzZQorI2RlZmluZSBJU01BUFBFRCh4KQkoMCkKKyNlbmRpZgorCisjZGVmaW5l
IF9fX3BhKHgpCSgodW5zaWduZWQgbG9uZykgKHgpIC0gUEFHRV9PRkZTRVQpCisjZGVmaW5l
IF9fcGEoeCkJCShJU01BUFBFRCh4KSA/ICh1bnNpZ25lZCBsb25nKSh4KSA6IF9fX3BhKHgp
KQorCisjZGVmaW5lIF9fX3ZhKHgpCSgodm9pZCAqKSgodW5zaWduZWQgbG9uZykgKHgpICsg
UEFHRV9PRkZTRVQpKQorI2RlZmluZSBfX3ZhKHgpCQkoSVNNQVBQRUQoeCkgPyAodm9pZCop
KHgpIDogX19fdmEoeCkpCiAKICNkZWZpbmUgcGZuX3RvX2thZGRyKHBmbikJX192YSgocGZu
KSA8PCBQQUdFX1NISUZUKQogCg==

--B_3242185576_6409718--
