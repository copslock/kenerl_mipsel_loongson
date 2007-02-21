Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 03:40:54 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:30738 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20039019AbXBUDku (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 03:40:50 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.0)); Tue, 20 Feb 2007 19:40:11 -0800
X-Server-Uuid: 9206F490-5C8F-4575-BE70-2AAA8A3D4853
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 E801D2AF; Tue, 20 Feb 2007 19:40:10 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id D4E632AE for
 <linux-mips@linux-mips.org>; Tue, 20 Feb 2007 19:40:10 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EYO27472; Tue, 20 Feb 2007 19:40:10 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 7FD4820501 for <linux-mips@linux-mips.org>; Tue, 20 Feb 2007 19:40:10
 -0800 (PST)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 20 Feb 2007 19:40:10 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] update sb1250 defconfig
Date:	Tue, 20 Feb 2007 19:40:09 -0800
Message-ID: <710F16C36810444CA2F5821E5EAB7F231C84F3@NT-SJCA-0752.brcm.ad.broadcom.com>
X-MS-Has-Attach: yes
Thread-Topic: [PATCH] update sb1250 defconfig
Thread-Index: AcdVafxg7QwoBARRQNO4mkDuOSmVBA==
From:	"Manoj Ekbote" <manoj.ekbote@broadcom.com>
To:	linux-mips@linux-mips.org
X-OriginalArrivalTime: 21 Feb 2007 03:40:10.0323 (UTC)
 FILETIME=[FCB89230:01C75569]
X-WSS-ID: 69C560913Y825789163-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C75569.FCA61828"
Return-Path: <manoj.ekbote@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoj.ekbote@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75569.FCA61828
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

The last email got messed up. The patch is attached here.



------_=_NextPart_001_01C75569.FCA61828
Content-Type: text/plain;
 name=patch-defconfig.txt
Content-Transfer-Encoding: base64
Content-Description: patch-defconfig.txt
Content-Disposition: attachment;
 filename=patch-defconfig.txt

VGhpcyBwYXRjaCB1cGRhdGVzIHNiMTI1MC1zd2FybS1kZWZjb25maWcgZmlsZSB0byBkZWZhdWx0
IHRvIFNpYnl0ZSBCbiBzaWxpY29uIGFzIHRoZSBQQVNTXzEgcHJvY2Vzc29ycyBhcmUgdmVyeSBv
bGQuCgpTaWduZWQtb2ZmLWJ5OiBNYW5vaiBFa2JvdGUgPG1hbm9qZUBicm9hZGNvbS5jb20+CgoK
ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9jb25maWdzL3NiMTI1MC1zd2FybV9kZWZjb25maWcgYi9h
cmNoL21pcHMvY29uZmlncy9zYjEyNTAtc3dhcm1fZGVmY29uZmlnCmluZGV4IDUzM2RmNmYuLjQ1
YjY4ZGUgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9jb25maWdzL3NiMTI1MC1zd2FybV9kZWZjb25m
aWcKKysrIGIvYXJjaC9taXBzL2NvbmZpZ3Mvc2IxMjUwLXN3YXJtX2RlZmNvbmZpZwpAQCAtNjUs
OSArNjUsOSBAQCBDT05GSUdfU0lCWVRFX1NXQVJNPXkKICMgQ09ORklHX1RPU0hJQkFfUkJUWDQ5
MzggaXMgbm90IHNldAogQ09ORklHX1NJQllURV9TQjEyNTA9eQogQ09ORklHX1NJQllURV9TQjF4
eHhfU09DPXkKLUNPTkZJR19DUFVfU0IxX1BBU1NfMT15CisjIENPTkZJR19DUFVfU0IxX1BBU1Nf
MSBpcyBub3Qgc2V0CiAjIENPTkZJR19DUFVfU0IxX1BBU1NfMl8xMjUwIGlzIG5vdCBzZXQKLSMg
Q09ORklHX0NQVV9TQjFfUEFTU18yXzIgaXMgbm90IHNldAorQ09ORklHX0NQVV9TQjFfUEFTU18y
XzI9eQogIyBDT05GSUdfQ1BVX1NCMV9QQVNTXzQgaXMgbm90IHNldAogIyBDT05GSUdfQ1BVX1NC
MV9QQVNTXzJfMTEyeCBpcyBub3Qgc2V0CiAjIENPTkZJR19DUFVfU0IxX1BBU1NfMyBpcyBub3Qg
c2V0CkBAIC0xNDIsNyArMTQyLDcgQEAgQ09ORklHX01JUFNfTVRfRElTQUJMRUQ9eQogIyBDT05G
SUdfTUlQU19NVF9TTVAgaXMgbm90IHNldAogIyBDT05GSUdfTUlQU19NVF9TTVRDIGlzIG5vdCBz
ZXQKICMgQ09ORklHX01JUFNfVlBFX0xPQURFUiBpcyBub3Qgc2V0Ci1DT05GSUdfU0IxX1BBU1Nf
MV9XT1JLQVJPVU5EUz15CitDT05GSUdfU0IxX1BBU1NfMl9XT1JLQVJPVU5EUz15CiBDT05GSUdf
Q1BVX0hBU19MTFNDPXkKIENPTkZJR19DUFVfSEFTX1NZTkM9eQogQ09ORklHX0dFTkVSSUNfSEFS
RElSUVM9eQo=

------_=_NextPart_001_01C75569.FCA61828--
