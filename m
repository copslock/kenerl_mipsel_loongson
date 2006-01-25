Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 13:01:13 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:49313 "EHLO
	gw01.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S8133508AbWAYNA4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 13:00:56 +0000
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 6BE32110E8A
	for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 15:05:18 +0200 (EET)
Date:	Wed, 25 Jan 2006 15:06:53 +0200 (EET)
From:	Kaj-Michael Lang <milang@tal.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] IP32 gbefb depth change fix
Message-ID: <Pine.LNX.4.61.0601251502170.11000@tori.tal.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="281236188-966823829-1138194183=:11000"
Content-ID: <Pine.LNX.4.61.0601251503350.11000@tori.tal.org>
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--281236188-966823829-1138194183=:11000
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; format=flowed
Content-ID: <Pine.LNX.4.61.0601251503351.11000@tori.tal.org>

Hi

The gbefb driver does not update the framebuffer layers visual
setting when depth is changed with fbset, resulting in strange
colors (very dark blue in 16-bit, almost black in 24-bit).
The attached patch fixes that.

-- 
Kaj-Michael Lang
--281236188-966823829-1138194183=:11000
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="gbefb_fix_depth_change.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0601251503030.11000@tori.tal.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="gbefb_fix_depth_change.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZ2JlZmIuYyBiL2RyaXZlcnMv
dmlkZW8vZ2JlZmIuYw0KaW5kZXggZDc0NGM1MS4uMTExZWFjYiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvdmlkZW8vZ2JlZmIuYw0KKysrIGIvZHJpdmVycy92
aWRlby9nYmVmYi5jDQpAQCAtNjU2LDEyICs2NTYsMTUgQEAgc3RhdGljIGlu
dCBnYmVmYl9zZXRfcGFyKHN0cnVjdCBmYl9pbmZvIA0KIAlzd2l0Y2ggKGJ5
dGVzUGVyUGl4ZWwpIHsNCiAJY2FzZSAxOg0KIAkJU0VUX0dCRV9GSUVMRChX
SUQsIFRZUCwgdmFsLCBHQkVfQ01PREVfSTgpOw0KKwkJaW5mby0+Zml4LnZp
c3VhbCA9IEZCX1ZJU1VBTF9QU0VVRE9DT0xPUjsJDQogCQlicmVhazsNCiAJ
Y2FzZSAyOg0KIAkJU0VUX0dCRV9GSUVMRChXSUQsIFRZUCwgdmFsLCBHQkVf
Q01PREVfQVJHQjUpOw0KKwkJaW5mby0+Zml4LnZpc3VhbCA9IEZCX1ZJU1VB
TF9UUlVFQ09MT1I7DQogCQlicmVhazsNCiAJY2FzZSA0Og0KIAkJU0VUX0dC
RV9GSUVMRChXSUQsIFRZUCwgdmFsLCBHQkVfQ01PREVfUkdCOCk7DQorCQlp
bmZvLT5maXgudmlzdWFsID0gRkJfVklTVUFMX1RSVUVDT0xPUjsNCiAJCWJy
ZWFrOw0KIAl9DQogCVNFVF9HQkVfRklFTEQoV0lELCBCVUYsIHZhbCwgR0JF
X0JNT0RFX0JPVEgpOw0K

--281236188-966823829-1138194183=:11000--
