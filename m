Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 17:58:18 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:11084 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20039001AbWI0Q6P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 17:58:15 +0100
Received: by py-out-1112.google.com with SMTP id i49so291243pyi
        for <linux-mips@linux-mips.org>; Wed, 27 Sep 2006 09:58:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type;
        b=V7BylRnJ8HUZNMlxqP/RKUaL8ErT7N6fMskLfCEMunVe/dATzjHs4+HjmKfXn/lq9Oq1O7V5Orz6HQGcmVHwpRKSxxRo1o/Bc62nx2HDn3In3hvWu5bP5RJA6li1dPxRmCaXGksFXVIXI+hUoFqNKfO8Bu/eOo9nek3FOJec9vY=
Received: by 10.35.121.12 with SMTP id y12mr1814872pym;
        Wed, 27 Sep 2006 09:58:12 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id 38sm2024689nzk.2006.09.27.09.58.10;
        Wed, 27 Sep 2006 09:58:12 -0700 (PDT)
User-Agent: Microsoft-Entourage/11.2.1.051004
Date:	Thu, 28 Sep 2006 01:58:02 +0900
Subject: PATCH] cleanup hardcoding __pa/__va macros etc. (take-4)
From:	girish <girishvg@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	girish <girishvg@gmail.com>
Message-ID: <C140DCAC.7A1C%girishvg@gmail.com>
Thread-Topic: PATCH] cleanup hardcoding __pa/__va macros etc. (take-4)
Thread-Index: AcbiVhe9Vme1VE5JEduKBgATIGIqNA==
In-Reply-To: <20060928.003542.21929658.anemo@mba.ocn.ne.jp>
Mime-version: 1.0
Content-type: multipart/mixed;
	boundary="B_3242253489_7379959"
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3242253489_7379959
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit


> Using just plain text and adding Signed-off-by line would be preferred.
> Also your patch seems against neither latest lmo nor kernel.org tree...

The kernel sources I was referring to were 2.6.17-rc6.


>> In the meantime, I couldn't find the changes suggested for SPARSEMEM support
>> in the main source tree. Especially the ones reviewed during month of August
>> ([PATCH] do not count pages in holes with sparsemem ...). Could you please
>> resend the consolidated patch to the list? Thanks.
> 
> August?  I sent the patch with that title in July and applied already.
> 
> http://www.linux-mips.org/git?p=linux.git;a=commit;h=239367b4

Again, I was referring to older sources, that is 2.6.17-rc6. I have just
upgraded reference sources to 2.6.18 as mentioned above & now I see the
changes. Thanks. In fact I am experimenting on highmem/sparsemem with
2.6.16.16 kernel sources.


Please find attached patch created from 2.6.18 (kernel.org) tree. Let me
know if this is alright.

Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>



--B_3242253489_7379959
Content-type: application/octet-stream; name="patch-pavafix-20060928"
Content-disposition: attachment;
	filename="patch-pavafix-20060928"
Content-transfer-encoding: base64

ZGlmZiAtdXByTiAtWCBsaW51eC12YW5pbGxhL0RvY3VtZW50YXRpb24vZG9udGRpZmYgbGlu
dXgtdmFuaWxsYS9hcmNoL21pcHMvbW0vZG1hLW5vbmNvaGVyZW50LmMgbGludXgvYXJjaC9t
aXBzL21tL2RtYS1ub25jb2hlcmVudC5jCi0tLSBsaW51eC12YW5pbGxhL2FyY2gvbWlwcy9t
bS9kbWEtbm9uY29oZXJlbnQuYwkyMDA2LTA5LTIwIDEyOjQyOjA2LjAwMDAwMDAwMCArMDkw
MAorKysgbGludXgvYXJjaC9taXBzL21tL2RtYS1ub25jb2hlcmVudC5jCTIwMDYtMDktMjgg
MDE6MTQ6MDEuMDAwMDAwMDAwICswOTAwCkBAIC0zMzMsNyArMzMzLDcgQEAgRVhQT1JUX1NZ
TUJPTChwY2lfZGFjX3BhZ2VfdG9fZG1hKTsKIHN0cnVjdCBwYWdlICpwY2lfZGFjX2RtYV90
b19wYWdlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogCWRtYTY0X2FkZHJfdCBkbWFfYWRkcikK
IHsKLQlyZXR1cm4gbWVtX21hcCArIChkbWFfYWRkciA+PiBQQUdFX1NISUZUKTsKKwlyZXR1
cm4gcGZuX3RvX3BhZ2UgKGRtYV9hZGRyID4+IFBBR0VfU0hJRlQpOwogfQogCiBFWFBPUlRf
U1lNQk9MKHBjaV9kYWNfZG1hX3RvX3BhZ2UpOwpkaWZmIC11cHJOIC1YIGxpbnV4LXZhbmls
bGEvRG9jdW1lbnRhdGlvbi9kb250ZGlmZiBsaW51eC12YW5pbGxhL2FyY2gvbWlwcy9tbS9p
bml0LmMgbGludXgvYXJjaC9taXBzL21tL2luaXQuYwotLS0gbGludXgtdmFuaWxsYS9hcmNo
L21pcHMvbW0vaW5pdC5jCTIwMDYtMDktMjAgMTI6NDI6MDYuMDAwMDAwMDAwICswOTAwCisr
KyBsaW51eC9hcmNoL21pcHMvbW0vaW5pdC5jCTIwMDYtMDktMjggMDE6MTY6MjAuMDAwMDAw
MDAwICswOTAwCkBAIC0xODAsMjQgKzE4MCwyMiBAQCB2b2lkIF9faW5pdCBwYWdpbmdfaW5p
dCh2b2lkKQogCWxvdyA9IG1heF9sb3dfcGZuOwogCWhpZ2ggPSBoaWdoZW5kX3BmbjsKIAot
I2lmZGVmIENPTkZJR19JU0EKLQlpZiAobG93IDwgbWF4X2RtYSkKKwlpZiAobG93IDwgbWF4
X2RtYSkgfQogCQl6b25lc19zaXplW1pPTkVfRE1BXSA9IGxvdzsKLQllbHNlIHsKKwl9IGVs
c2UgewogCQl6b25lc19zaXplW1pPTkVfRE1BXSA9IG1heF9kbWE7CiAJCXpvbmVzX3NpemVb
Wk9ORV9OT1JNQUxdID0gbG93IC0gbWF4X2RtYTsKIAl9Ci0jZWxzZQotCXpvbmVzX3NpemVb
Wk9ORV9ETUFdID0gbG93OwotI2VuZGlmCisKICNpZmRlZiBDT05GSUdfSElHSE1FTQogCWlm
IChjcHVfaGFzX2RjX2FsaWFzZXMpIHsKIAkJcHJpbnRrKEtFUk5fV0FSTklORyAiVGhpcyBw
cm9jZXNzb3IgZG9lc24ndCBzdXBwb3J0IGhpZ2htZW0uIik7CiAJCWlmIChoaWdoIC0gbG93
KQogCQkJcHJpbnRrKCIgJWxkayBoaWdobWVtIGlnbm9yZWQiLCBoaWdoIC0gbG93KTsKIAkJ
cHJpbnRrKCJcbiIpOwotCX0gZWxzZQotCQl6b25lc19zaXplW1pPTkVfSElHSE1FTV0gPSBo
aWdoIC0gbG93OworCX0gZWxzZSB7CisJCXpvbmVzX3NpemVbWk9ORV9ISUdITUVNXSA9IGhp
Z2ggLSBoaWdoc3RhcnRfcGZuOworCX0KICNlbmRpZgogCiAjaWZkZWYgQ09ORklHX0ZMQVRN
RU0KQEAgLTI0Niw3ICsyNDQsNyBAQCB2b2lkIF9faW5pdCBtZW1faW5pdCh2b2lkKQogCiAj
aWZkZWYgQ09ORklHX0hJR0hNRU0KIAlmb3IgKHRtcCA9IGhpZ2hzdGFydF9wZm47IHRtcCA8
IGhpZ2hlbmRfcGZuOyB0bXArKykgewotCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IG1lbV9tYXAg
KyB0bXA7CisJCXN0cnVjdCBwYWdlICpwYWdlID0gcGZuX3RvX3BhZ2UgKHRtcCk7CiAKIAkJ
aWYgKCFwYWdlX2lzX3JhbSh0bXApKSB7CiAJCQlTZXRQYWdlUmVzZXJ2ZWQocGFnZSk7CmRp
ZmYgLXVwck4gLVggbGludXgtdmFuaWxsYS9Eb2N1bWVudGF0aW9uL2RvbnRkaWZmIGxpbnV4
LXZhbmlsbGEvaW5jbHVkZS9hc20tbWlwcy9kbWEuaCBsaW51eC9pbmNsdWRlL2FzbS1taXBz
L2RtYS5oCi0tLSBsaW51eC12YW5pbGxhL2luY2x1ZGUvYXNtLW1pcHMvZG1hLmgJMjAwNi0w
OS0yMCAxMjo0MjowNi4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4L2luY2x1ZGUvYXNtLW1p
cHMvZG1hLmgJMjAwNi0wOS0yOCAwMToxODozMS4wMDAwMDAwMDAgKzA5MDAKQEAgLTg2LDgg
Kzg2LDEzIEBACiAvKiBIb3JyaWJsZSBoYWNrIHRvIGhhdmUgYSBjb3JyZWN0IERNQSB3aW5k
b3cgb24gSVAyMiAqLwogI2luY2x1ZGUgPGFzbS9zZ2kvbWMuaD4KICNkZWZpbmUgTUFYX0RN
QV9BRERSRVNTCQkoUEFHRV9PRkZTRVQgKyBTR0lNQ19TRUcwX0JBRERSICsgMHgwMTAwMDAw
MCkKLSNlbHNlCisjZWxpZiBkZWZpbmVkKENPTkZJR19JU0EpCiAjZGVmaW5lIE1BWF9ETUFf
QUREUkVTUwkJKFBBR0VfT0ZGU0VUICsgMHgwMTAwMDAwMCkKKyNlbHNlCisjaWZuZGVmIFBM
QVRfTUFYX0RNQV9TSVpFCisjZGVmaW5lIFBMQVRfTUFYX0RNQV9TSVpFCTB4MTAwMDAwMDAJ
LyogMjU2TUI6IHRydWUgb24gbW9zdCBvZiB0aGUgTUlQUzMyIHN5c3RlbXMgKi8KKyNlbmRp
ZgorI2RlZmluZSBNQVhfRE1BX0FERFJFU1MJCShQQUdFX09GRlNFVCArIFBMQVRfTUFYX0RN
QV9TSVpFKQogI2VuZGlmCiAKIC8qIDgyMzcgRE1BIGNvbnRyb2xsZXJzICovCmRpZmYgLXVw
ck4gLVggbGludXgtdmFuaWxsYS9Eb2N1bWVudGF0aW9uL2RvbnRkaWZmIGxpbnV4LXZhbmls
bGEvaW5jbHVkZS9hc20tbWlwcy9pby5oIGxpbnV4L2luY2x1ZGUvYXNtLW1pcHMvaW8uaAot
LS0gbGludXgtdmFuaWxsYS9pbmNsdWRlL2FzbS1taXBzL2lvLmgJMjAwNi0wOS0yMCAxMjo0
MjowNi4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4L2luY2x1ZGUvYXNtLW1pcHMvaW8uaAky
MDA2LTA5LTI4IDAxOjIwOjIyLjAwMDAwMDAwMCArMDkwMApAQCAtMTE1LDcgKzExNSw3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfaW9fcG9ydF9iYXNlKHVuc2kKICAqLwogc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBsb25nIHZpcnRfdG9fcGh5cyh2b2xhdGlsZSB2b2lkICogYWRk
cmVzcykKIHsKLQlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpYWRkcmVzcyAtIFBBR0VfT0ZGU0VU
OworCXJldHVybiBfX3BhKGFkZHJlc3MpOwogfQogCiAvKgpAQCAtMTMyLDcgKzEzMiw3IEBA
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyB2aXJ0X3RvX3BoeXMKICAqLwogc3RhdGlj
IGlubGluZSB2b2lkICogcGh5c190b192aXJ0KHVuc2lnbmVkIGxvbmcgYWRkcmVzcykKIHsK
LQlyZXR1cm4gKHZvaWQgKikoYWRkcmVzcyArIFBBR0VfT0ZGU0VUKTsKKwlyZXR1cm4gX192
YShhZGRyZXNzKTsKIH0KIAogLyoKQEAgLTE0MCwxMiArMTQwLDEyIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCAqIHBoeXNfdG9fdmlydCh1bnNpZ24KICAqLwogc3RhdGljIGlubGluZSB1bnNp
Z25lZCBsb25nIGlzYV92aXJ0X3RvX2J1cyh2b2xhdGlsZSB2b2lkICogYWRkcmVzcykKIHsK
LQlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpYWRkcmVzcyAtIFBBR0VfT0ZGU0VUOworCXJldHVy
biBfX3BhKGFkZHJlc3MpOwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgKiBpc2FfYnVzX3Rv
X3ZpcnQodW5zaWduZWQgbG9uZyBhZGRyZXNzKQogewotCXJldHVybiAodm9pZCAqKShhZGRy
ZXNzICsgUEFHRV9PRkZTRVQpOworCXJldHVybiBfX3ZhKGFkZHJlc3MpOwogfQogCiAjZGVm
aW5lIGlzYV9wYWdlX3RvX2J1cyBwYWdlX3RvX3BoeXMKZGlmZiAtdXByTiAtWCBsaW51eC12
YW5pbGxhL0RvY3VtZW50YXRpb24vZG9udGRpZmYgbGludXgtdmFuaWxsYS9pbmNsdWRlL2Fz
bS1taXBzL3BhZ2UuaCBsaW51eC9pbmNsdWRlL2FzbS1taXBzL3BhZ2UuaAotLS0gbGludXgt
dmFuaWxsYS9pbmNsdWRlL2FzbS1taXBzL3BhZ2UuaAkyMDA2LTA5LTIwIDEyOjQyOjA2LjAw
MDAwMDAwMCArMDkwMAorKysgbGludXgvaW5jbHVkZS9hc20tbWlwcy9wYWdlLmgJMjAwNi0w
OS0yOCAwMToyNjowMC4wMDAwMDAwMDAgKzA5MDAKQEAgLTEyOSw4ICsxMjksMTUgQEAgdHlw
ZWRlZiBzdHJ1Y3QgeyB1bnNpZ25lZCBsb25nIHBncHJvdDsgfQogLyogdG8gYWxpZ24gdGhl
IHBvaW50ZXIgdG8gdGhlIChuZXh0KSBwYWdlIGJvdW5kYXJ5ICovCiAjZGVmaW5lIFBBR0Vf
QUxJR04oYWRkcikJKCgoYWRkcikgKyBQQUdFX1NJWkUgLSAxKSAmIFBBR0VfTUFTSykKIAot
I2RlZmluZSBfX3BhKHgpCQkJKCh1bnNpZ25lZCBsb25nKSAoeCkgLSBQQUdFX09GRlNFVCkK
LSNkZWZpbmUgX192YSh4KQkJCSgodm9pZCAqKSgodW5zaWduZWQgbG9uZykgKHgpICsgUEFH
RV9PRkZTRVQpKQorI2lmZGVmIENPTkZJR18zMkJJVAorI2RlZmluZSBJU01BUFBFRCh4KQkJ
KEtTRUdYKCh4KSkgPj0gSElHSE1FTV9TVEFSVCAmJiBLU0VHWCgoeCkpIDwgS1NFRzApCisj
ZWxzZQorI2RlZmluZSBJU01BUFBFRCh4KQkJKDApCisjZW5kaWYKKyNkZWZpbmUgX19fcGEo
eCkJCSgodW5zaWduZWQgbG9uZykgKHgpIC0gUEFHRV9PRkZTRVQpCisjZGVmaW5lIF9fcGEo
eCkJCQkoSVNNQVBQRUQoeCkgPyAodW5zaWduZWQgbG9uZykoeCkgOiBfX19wYSh4KSkKKyNk
ZWZpbmUgX19fdmEoeCkJCSgodm9pZCAqKSgodW5zaWduZWQgbG9uZykgKHgpICsgUEFHRV9P
RkZTRVQpKQorI2RlZmluZSBfX3ZhKHgpCQkJKElTTUFQUEVEKHgpID8gKHZvaWQqKSh4KSA6
IF9fX3ZhKHgpKQogCiAjZGVmaW5lIHBmbl90b19rYWRkcihwZm4pCV9fdmEoKHBmbikgPDwg
UEFHRV9TSElGVCkKIAo=

--B_3242253489_7379959--
