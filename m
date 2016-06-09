Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 02:00:57 +0200 (CEST)
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36509 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033772AbcFIAAyaZ930 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 02:00:54 +0200
Received: by mail-vk0-f68.google.com with SMTP id x7so3869496vkf.3
        for <linux-mips@linux-mips.org>; Wed, 08 Jun 2016 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wmvDU1LtFWJWiuucwj2eNRASPxKcH+PlkW8uS28I+5U=;
        b=JJGMt3+CCVl6066hT53Cf5V8fTnxynVHfLyikFxDzmCdJDj3Akx0nZDSrlauBEqeG1
         0mF3IAxas/nAqdjDYDjHEkVGaVr/5V1jyDgWlgzCDc9VMYiKefH7PIVdZhWJ0iZFg0Kt
         rFx6f7js7wnR0yUwCI7CQNuhC6v1DnShjz4n3WPCAbhvcxPmHj0hSLRboG9Hj//az3YK
         Lxl94L+egyR1UBW9R8zAvUIa53/aveq5n6zVr4Un8yTFDY5DjRrBkVJESVnG5Iw9jnuI
         d1p1DwznRILT210flnvJm2itJOHLjZ8oZUNcS18gisrRbDHmIW5NNG7yQEia1hDbzqjB
         KmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wmvDU1LtFWJWiuucwj2eNRASPxKcH+PlkW8uS28I+5U=;
        b=TzzhAOwUCBo/RN+FNDtaobIV/f4NcWRLdWX2rXnt5EJsi8YfgH6sh8dOoSApCqu5K5
         bFnhPafOYDO7k/gL60nYZbsRt8LZiKM6EojNF4pc4bOuap+BO30Dp2R2YAZJma4wXxvp
         GrXYhQ0qidN7GbHdXcy5y7HI2VaPF4kLnmYdH7CVfvkB0ynSxx0gs34kDcVUdHQ/Z3Sk
         eN0KFJaSmRE0ZR9sKYTemv8OjRsqqUSGy7MsR8yJBvtOW0VssgCUungUy0UYbvo5pi1h
         H9C6fV+Me7IREOjscgTPLVut79RD2FvgsE49BJP5rISDN12Agiq7fTVcELlm9qtFUhxq
         +Bqw==
X-Gm-Message-State: ALyK8tK0XmwoQWb9HiTeS3aF1Zv4p1w/KpBglR6fB9A/aBwOfP5ZVbivm5V0OfVDWX7urnuG99lHXEfY/2QEEQ==
X-Received: by 10.176.3.72 with SMTP id 66mr3425821uat.146.1465430448568; Wed,
 08 Jun 2016 17:00:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.81.11 with HTTP; Wed, 8 Jun 2016 17:00:47 -0700 (PDT)
In-Reply-To: <CAE9FiQXPmG6UYYGHG52_i8vaBJ5yPm6Z4Zfx_BhQxVhyWC5fnw@mail.gmail.com>
References: <20160604000642.28162-1-yinghai@kernel.org> <20160604000642.28162-2-yinghai@kernel.org>
 <20160608210322.GA4248@localhost> <CAE9FiQXPmG6UYYGHG52_i8vaBJ5yPm6Z4Zfx_BhQxVhyWC5fnw@mail.gmail.com>
From:   Yinghai Lu <yinghai@kernel.org>
Date:   Wed, 8 Jun 2016 17:00:47 -0700
X-Google-Sender-Auth: z1Fi83VDkSmDYQsnrl48WM2oheg
Message-ID: <CAE9FiQWw0pUB=1iDrX_1qyMFAUGQidSaV7CPc0aNb2CzPB-fZw@mail.gmail.com>
Subject: Re: [PATCH v12 01/15] PCI: Let pci_mmap_page_range() take extra
 resource pointer
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-cris-kernel@axis.com,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: multipart/mixed; boundary=001a113f269454a1b90534cd1d05
Return-Path: <yhlu.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yinghai@kernel.org
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

--001a113f269454a1b90534cd1d05
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 8, 2016 at 3:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:

> At the same time, can you kill __pci_mmap_set_pgprot() for powerpc.

Can you please put your two patches and this attached one into to pci/next?

Then I could send updated PCI: Let pci_mmap_page_range() take resource address.

Thanks

Yinghai

--001a113f269454a1b90534cd1d05
Content-Type: text/x-patch; charset=US-ASCII; name="remove_powerpc_pci_prot.patch"
Content-Disposition: attachment; filename="remove_powerpc_pci_prot.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ip7jeokf0

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KU3ViamVjdDogW1BBVENI
XSBwb3dlcnBjL1BDSTogUmVtb3ZlIF9fcGNpX21tYXBfc2V0X3BncHJvdCgpCgogIFBDSTogSWdu
b3JlIHdyaXRlLWNvbWJpbmluZyB3aGVuIG1hcHBpbmcgSS9PIHBvcnQgc3BhY2UKYWxyZWFkeSBo
YW5kbGUgdGhlIGlvIHBvcnQgbW1hcCBwYXRoLgoKRm9yIG1taW8gbW1hcCBwYXRoLCBjYWxsZXIg
c2hvdWxkIHN0YXRlIHRoYXQgY29ycmVjdGx5IGlmIHdyaXRlX2NvbWJpbmUKaXMgcmVhbGx5IG5l
ZWRlZC4KCnZpYSBwcm9jIHBhdGggaXQgc2hvdWxkIGxvb2sgbGlrZToKICBtbWFwKGZkLCAuLi4p
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBkZWZhdWx0IGlzIEkvTywgbm9uLWNvbWJpbmlu
ZwogIGlvY3RsKGZkLCBQQ0lJT0NfV1JJVEVfQ09NQklORSwgMSk7ICAgICAjIHJlcXVlc3Qgd3Jp
dGUtY29tYmluaW5nCiAgaW9jdGwoZmQsIFBDSUlPQ19NTUFQX0lTX01FTSk7ICAgICAgICAgICMg
cmVxdWVzdCBtZW1vcnkgc3BhY2UKICBtbWFwKGZkLCAuLi4pCgpzeXNmcyBwYXRoLCBpdCBzaG91
bGQgdXNlIHJlc291cmNlXT9dX3djLgoKU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8Ymhl
bGdhYXNAZ29vZ2xlLmNvbT4KCi0tLQogYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9uLmMg
fCAgIDM3ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9h
cmNoL3Bvd2VycGMva2VybmVsL3BjaS1jb21tb24uYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYu
b3JpZy9hcmNoL3Bvd2VycGMva2VybmVsL3BjaS1jb21tb24uYworKysgbGludXgtMi42L2FyY2gv
cG93ZXJwYy9rZXJuZWwvcGNpLWNvbW1vbi5jCkBAIC0zNTYsMzYgKzM1Niw2IEBAIHN0YXRpYyBz
dHJ1Y3QgcmVzb3VyY2UgKl9fcGNpX21tYXBfbWFrZV8KIH0KIAogLyoKLSAqIFNldCB2bV9wYWdl
X3Byb3Qgb2YgVk1BLCBhcyBhcHByb3ByaWF0ZSBmb3IgdGhpcyBhcmNoaXRlY3R1cmUsIGZvciBh
IHBjaQotICogZGV2aWNlIG1hcHBpbmcuCi0gKi8KLXN0YXRpYyBwZ3Byb3RfdCBfX3BjaV9tbWFw
X3NldF9wZ3Byb3Qoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IHJlc291cmNlICpycCwKLQkJ
CQkgICAgICBwZ3Byb3RfdCBwcm90ZWN0aW9uLAotCQkJCSAgICAgIGVudW0gcGNpX21tYXBfc3Rh
dGUgbW1hcF9zdGF0ZSwKLQkJCQkgICAgICBpbnQgd3JpdGVfY29tYmluZSkKLXsKLQotCS8qIFdy
aXRlIGNvbWJpbmUgaXMgYWx3YXlzIDAgb24gbm9uLW1lbW9yeSBzcGFjZSBtYXBwaW5ncy4gT24K
LQkgKiBtZW1vcnkgc3BhY2UsIGlmIHRoZSB1c2VyIGRpZG4ndCBwYXNzIDEsIHdlIGNoZWNrIGZv
ciBhCi0JICogInByZWZldGNoYWJsZSIgcmVzb3VyY2UuIFRoaXMgaXMgYSBiaXQgaGFja2lzaCwg
YnV0IHdlIHVzZQotCSAqIHRoaXMgdG8gd29ya2Fyb3VuZCB0aGUgaW5hYmlsaXR5IG9mIC9zeXNm
cyB0byBwcm92aWRlIGEgd3JpdGUKLQkgKiBjb21iaW5lIGJpdAotCSAqLwotCWlmIChtbWFwX3N0
YXRlICE9IHBjaV9tbWFwX21lbSkKLQkJd3JpdGVfY29tYmluZSA9IDA7Ci0JZWxzZSBpZiAod3Jp
dGVfY29tYmluZSA9PSAwKSB7Ci0JCWlmIChycC0+ZmxhZ3MgJiBJT1JFU09VUkNFX1BSRUZFVENI
KQotCQkJd3JpdGVfY29tYmluZSA9IDE7Ci0JfQotCi0JLyogWFhYIHdvdWxkIGJlIG5pY2UgdG8g
aGF2ZSBhIHdheSB0byBhc2sgZm9yIHdyaXRlLXRocm91Z2ggKi8KLQlpZiAod3JpdGVfY29tYmlu
ZSkKLQkJcmV0dXJuIHBncHJvdF9ub25jYWNoZWRfd2MocHJvdGVjdGlvbik7Ci0JZWxzZQotCQly
ZXR1cm4gcGdwcm90X25vbmNhY2hlZChwcm90ZWN0aW9uKTsKLX0KLQotLyoKICAqIFRoaXMgb25l
IGlzIHVzZWQgYnkgL2Rldi9tZW0gYW5kIGZiZGV2IHdobyBoYXZlIG5vIGNsdWUgYWJvdXQgdGhl
CiAgKiBQQ0kgZGV2aWNlLCBpdCB0cmllcyB0byBmaW5kIHRoZSBQQ0kgZGV2aWNlIGZpcnN0IGFu
ZCBjYWxscyB0aGUKICAqIGFib3ZlIHJvdXRpbmUKQEAgLTQ1OCw5ICs0MjgsMTAgQEAgaW50IHBj
aV9tbWFwX3BhZ2VfcmFuZ2Uoc3RydWN0IHBjaV9kZXYgKgogCQlyZXR1cm4gLUVJTlZBTDsKIAog
CXZtYS0+dm1fcGdvZmYgPSBvZmZzZXQgPj4gUEFHRV9TSElGVDsKLQl2bWEtPnZtX3BhZ2VfcHJv
dCA9IF9fcGNpX21tYXBfc2V0X3BncHJvdChkZXYsIHJwLAotCQkJCQkJICB2bWEtPnZtX3BhZ2Vf
cHJvdCwKLQkJCQkJCSAgbW1hcF9zdGF0ZSwgd3JpdGVfY29tYmluZSk7CisJaWYgKHdyaXRlX2Nv
bWJpbmUpCisJCXZtYS0+dm1fcGFnZV9wcm90ID0gcGdwcm90X25vbmNhY2hlZF93Yyh2bWEtPnZt
X3BhZ2VfcHJvdCk7CisJZWxzZQorCQl2bWEtPnZtX3BhZ2VfcHJvdCA9IHBncHJvdF9ub25jYWNo
ZWQodm1hLT52bV9wYWdlX3Byb3QpOwogCiAJcmV0ID0gcmVtYXBfcGZuX3JhbmdlKHZtYSwgdm1h
LT52bV9zdGFydCwgdm1hLT52bV9wZ29mZiwKIAkJCSAgICAgICB2bWEtPnZtX2VuZCAtIHZtYS0+
dm1fc3RhcnQsIHZtYS0+dm1fcGFnZV9wcm90KTsK
--001a113f269454a1b90534cd1d05--
