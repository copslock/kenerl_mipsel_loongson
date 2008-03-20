Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2008 19:57:50 +0000 (GMT)
Received: from hs-out-0708.google.com ([64.233.178.248]:24876 "EHLO
	hs-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S28575344AbYCTT5r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Mar 2008 19:57:47 +0000
Received: by hs-out-0708.google.com with SMTP id x43so1044653hsb.0
        for <linux-mips@linux-mips.org>; Thu, 20 Mar 2008 12:57:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=2zlo7VDJuQSuZAJKItAB20nMq9mh7RyRyGhHQROQzFI=;
        b=cKPFvDFRqXNlq5pZbZAZIbwxMOmMK/Ph+M0+UhktJReYfXF9q3MHc6zuNJ/Js2l4F4oopbC6hnCLh2tEofyjZSE/B5exaRY0nDdbP/Sc4QxdOgwI+OYWcdxvybmdgNi4DIAqvdfQIvqHeAA9QMXAp14fKOijrFDKEOAUOBFW3Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=Ha83ltRSaah9VQuasm8kMtijvJYTWbhVTEHhEQwFc3EtHuBDt3AwmUahaxq7IiXF49PokBDCqvII2QODAirLCRxUW2isvsU+FPEtiiBoZaB/9k/jL/eo5NaRfQDUAVKD/Am7yct2mseKs57Wb8kc98Q4XoIYgVYIdWq0WAGFG3s=
Received: by 10.100.14.2 with SMTP id 2mr6575889ann.16.1206043055196;
        Thu, 20 Mar 2008 12:57:35 -0700 (PDT)
Received: by 10.100.198.15 with HTTP; Thu, 20 Mar 2008 12:57:34 -0700 (PDT)
Message-ID: <1feaefbd0803201257s88d88b8qcfae52bceeb43a54@mail.gmail.com>
Date:	Thu, 20 Mar 2008 20:57:34 +0100
From:	"Benoit Istin" <beistin@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [Patch] cpmac ethernet fix for linux 2.6.24.2
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2026_1938395.1206043055068"
Return-Path: <beistin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: beistin@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_2026_1938395.1206043055068
Content-Type: multipart/alternative; 
	boundary="----=_Part_2027_24085917.1206043055069"

------=_Part_2027_24085917.1206043055069
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I tried a recent snapshot of openWrt project and it happened that the
ethernet card was not initialised on my DSL624T (AR7 based modem/router).

According to what I could find in the news, there is a conflict during
registration of the driver, so I tried to fix it.
And here it comes the patch that allowed me to have my cpmac eth0 up and
running.
As I am not an experiment kernel hacker, this may be not the good way to do
it, but a least, it look more like what  other drivers do :)

Could someone apply this patch to the kernel tree?
Best regards
B.I.

------=_Part_2027_24085917.1206043055069
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I tried a recent snapshot of openWrt project and it happened that the ethernet card was not initialised on my DSL624T (AR7 based modem/router).<br><br>According to what I could find in the news, there is a conflict during registration of the driver, so I tried to fix it.<br>
And here it comes the patch that allowed me to have my cpmac eth0 up and running.<br>As I am not an experiment kernel hacker, this may be not the good way to do it, but a least, it look more like what&nbsp; other drivers do :)<br>
<br>Could someone apply this patch to the kernel tree?<br>Best regards<br>B.I.<br><br>

------=_Part_2027_24085917.1206043055069--

------=_Part_2026_1938395.1206043055068
Content-Type: text/x-patch; name=cpmac_eth_fix.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fe1qm121
Content-Disposition: attachment; filename=cpmac_eth_fix.patch

ZGlmZiAtcHJ1TiBsaW51eC0yLjYuMjQuMi5vbGQvZHJpdmVycy9uZXQvY3BtYWMuYyBsaW51eC0y
LjYuMjQuMi9kcml2ZXJzL25ldC9jcG1hYy5jCi0tLSBsaW51eC0yLjYuMjQuMi5vbGQvZHJpdmVy
cy9uZXQvY3BtYWMuYwkyMDA4LTAzLTIwIDIwOjMzOjAxLjAwMDAwMDAwMCArMDEwMAorKysgbGlu
dXgtMi42LjI0LjIvZHJpdmVycy9uZXQvY3BtYWMuYwkyMDA4LTAzLTIwIDIwOjQ3OjMxLjAwMDAw
MDAwMCArMDEwMApAQCAtMTExMiw3ICsxMTEyLDggQEAgc3RhdGljIGludCBleHRlcm5hbF9zd2l0
Y2g7CiAKIHN0YXRpYyBpbnQgX19kZXZpbml0IGNwbWFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCiB7Ci0JaW50IHJjLCBwaHlfaWQsIGk7CisJaW50IHJjLCBpOworCWludCBw
aHlfaWQ7CiAJaW50IG1kaW9fYnVzX2lkID0gY3BtYWNfbWlpLmlkOwogCXN0cnVjdCByZXNvdXJj
ZSAqbWVtOwogCXN0cnVjdCBjcG1hY19wcml2ICpwcml2OwpAQCAtMTEzMiw3ICsxMTMzLDcgQEAg
c3RhdGljIGludCBfX2RldmluaXQgY3BtYWNfcHJvYmUoc3RydWN0IAogCiAJaWYgKHBoeV9pZCA9
PSBQSFlfTUFYX0FERFIpIHsKIAkJaWYgKGV4dGVybmFsX3N3aXRjaCB8fCBkdW1iX3N3aXRjaCkg
ewotCQkJbWRpb19idXNfaWQgPSAwOyAvKiBmaXhlZCBwaHlzIGJ1cyAqLworCQkJbWRpb19idXNf
aWQgPSAwOyAKIAkJCXBoeV9pZCA9IHBkZXYtPmlkOwogCQl9IGVsc2UgewogCQkJZGV2X2Vycigm
cGRldi0+ZGV2LCAibm8gUEhZIHByZXNlbnRcbiIpOwpAQCAtMTE3OCw5ICsxMTc5LDcgQEAgc3Rh
dGljIGludCBfX2RldmluaXQgY3BtYWNfcHJvYmUoc3RydWN0IAogCXByaXYtPm1zZ19lbmFibGUg
PSBuZXRpZl9tc2dfaW5pdChkZWJ1Z19sZXZlbCwgMHhmZik7CiAJbWVtY3B5KGRldi0+ZGV2X2Fk
ZHIsIHBkYXRhLT5kZXZfYWRkciwgc2l6ZW9mKGRldi0+ZGV2X2FkZHIpKTsKIAotCXNucHJpbnRm
KHByaXYtPnBoeV9uYW1lLCBCVVNfSURfU0laRSwgUEhZX0lEX0ZNVCwgbWRpb19idXNfaWQsIHBo
eV9pZCk7Ci0KLQlwcml2LT5waHkgPSBwaHlfY29ubmVjdChkZXYsIHByaXYtPnBoeV9uYW1lLCAm
Y3BtYWNfYWRqdXN0X2xpbmssIDAsCisJcHJpdi0+cGh5ID0gcGh5X2Nvbm5lY3QoZGV2LCBjcG1h
Y19taWkucGh5X21hcFtwaHlfaWRdLT5kZXYuYnVzX2lkLCAmY3BtYWNfYWRqdXN0X2xpbmssIDAs
CiAJCQkJUEhZX0lOVEVSRkFDRV9NT0RFX01JSSk7CiAJaWYgKElTX0VSUihwcml2LT5waHkpKSB7
CiAJCWlmIChuZXRpZl9tc2dfZHJ2KHByaXYpKQpAQCAtMTIyMiwxMyArMTIyMSwxMyBAQCBzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjcG1hY19kcml2CiAJLnJlbW92ZSA9IF9fZGV2ZXhp
dF9wKGNwbWFjX3JlbW92ZSksCiB9OwogCi1pbnQgX19kZXZpbml0IGNwbWFjX2luaXQodm9pZCkK
K2ludCBfX2RldmluaXQgY3BtYWNfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwbGRldiwg
bG9uZyBsb25nIGJhc2UpCiB7CiAJdTMyIG1hc2s7CiAJaW50IGksIHJlczsKIAorCWNwbWFjX21p
aS5pZD1wbGRldi0+aWQ7CiAJY3BtYWNfbWlpLnByaXYgPSBpb3JlbWFwKEFSN19SRUdTX01ESU8s
IDI1Nik7Ci0KIAlpZiAoIWNwbWFjX21paS5wcml2KSB7CiAJCXByaW50ayhLRVJOX0VSUiAiQ2Fu
J3QgaW9yZW1hcCBtZGlvIHJlZ2lzdGVyc1xuIik7CiAJCXJldHVybiAtRU5YSU87Cg==
------=_Part_2026_1938395.1206043055068--
