Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 02:20:54 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:37533 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8133833AbVKCCUK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 02:20:10 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1EXUih-00055u-00; Wed, 02 Nov 2005 21:20:51 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19317-02; Wed, 2 Nov 2005 21:20:40 -0500 (EST)
Received: from h168.98.28.71.ip.alltel.net ([71.28.98.168] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EXUiU-00055g-00; Wed, 02 Nov 2005 21:20:38 -0500
Date:	Wed, 2 Nov 2005 21:20:35 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	David Daney <ddaney@avtrex.com>
cc:	crossgcc@sources.redhat.com,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: linux kernel building for mips malta target board
In-Reply-To: <436965B7.3000606@avtrex.com>
Message-ID: <Pine.LNX.4.61.0511022057140.3511@trantor.stuart.netsweng.com>
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com>
 <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com>
 <436965B7.3000606@avtrex.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811327-1060407037-1130984435=:3511"
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811327-1060407037-1130984435=:3511
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Wed, 2 Nov 2005, David Daney wrote:

>> __get_user() is unhappy, with tpyes that are "const". It uses __typeof()
>> to create a local variable that it wants to write to. I've intended to
>> have offer up a patch by now, but, too many unexpected thing have happened 
>> in the firs thalf of this week.

I shamed myself into sitting down and doing this. 8-)

The attached patch seems to work, or at least doesn't seem to cause
things to blow up. An o32 userspace on a 64-bit kernel comes up
multi-user and can build a kernel, and run a quick subset of LTP.

There was a comment on IRC that there was a register allocation issue which
lead to the current code. I'm not sure of the exact details, but I _think_
this change ends up being equivilent to the code it replaces.



                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
---1463811327-1060407037-1130984435=:3511
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0511022120350.3511@trantor.stuart.netsweng.com>
Content-Description: uaccess.h.patch
Content-Disposition: attachment; filename=diff

SW5kZXg6IHVhY2Nlc3MuaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IHVhY2Nlc3MuaAkocmV2aXNpb24gODQpDQorKysgdWFjY2Vzcy5oCSh3b3Jr
aW5nIGNvcHkpDQpAQCAtMjEwLDE3ICsyMTAsMzUgQEANCiANCiAjZGVmaW5l
IF9fZ2V0X3VzZXJfbm9jaGVjayh4LHB0cixzaXplKQkJCQkJXA0KICh7CQkJ
CQkJCQkJXA0KLQlfX3R5cGVvZigqKHB0cikpIF9fZ3VfdmFsID0gIChfX3R5
cGVvZigqKHB0cikpKSAwOwkJXA0KIAlsb25nIF9fZ3VfZXJyID0gMDsJCQkJ
CQlcDQogCQkJCQkJCQkJXA0KIAlzd2l0Y2ggKHNpemUpIHsJCQkJCQkJXA0K
LQljYXNlIDE6IF9fZ2V0X3VzZXJfYXNtKCJsYiIsIHB0cik7IGJyZWFrOwkJ
CVwNCi0JY2FzZSAyOiBfX2dldF91c2VyX2FzbSgibGgiLCBwdHIpOyBicmVh
azsJCQlcDQotCWNhc2UgNDogX19nZXRfdXNlcl9hc20oImx3IiwgcHRyKTsg
YnJlYWs7CQkJXA0KLQljYXNlIDg6IF9fR0VUX1VTRVJfRFcocHRyKTsgYnJl
YWs7CQkJCVwNCisJY2FzZSAxOiB7CQkJCQkJCVwNCisJCXM4IF9fZ3VfdmFs
ID0gIChzOCkgMDsJCQkJCVwNCisJCV9fZ2V0X3VzZXJfYXNtKCJsYiIsIHB0
cik7IAkJCQlcDQorCQkoeCkgPSAoX190eXBlb2ZfXygqKHB0cikpKSBfX2d1
X3ZhbDsJCQlcDQorCQlicmVhazsJCQkJCQkJXA0KKwkJfQkJCQkJCQlcDQor
CWNhc2UgMjoJewkJCQkJCQlcDQorCQlzMTYgX19ndV92YWwgPSAgKHMxNikg
MDsJCQkJXA0KKwkJX19nZXRfdXNlcl9hc20oImxoIiwgcHRyKTsJCQkJXA0K
KwkJKHgpID0gKF9fdHlwZW9mX18oKihwdHIpKSkgX19ndV92YWw7CQkJXA0K
KwkJYnJlYWs7CQkJCQkJCVwNCisJCX0JCQkJCQkJXA0KKwljYXNlIDQ6CXsJ
CQkJCQkJXA0KKwkJczMyIF9fZ3VfdmFsID0gKHMzMikgMDsJCQkJCVwNCisJ
CV9fZ2V0X3VzZXJfYXNtKCJsdyIsIHB0cik7CQkJCVwNCisJCSh4KSA9IChf
X3R5cGVvZl9fKCoocHRyKSkpIF9fZ3VfdmFsOwkJCVwNCisJCWJyZWFrOwkJ
CQkJCQlcDQorCQl9CQkJCQkJCVwNCisJY2FzZSA4Ogl7CQkJCQkJCVwNCisJ
CXM2NCBfX2d1X3ZhbCA9IChzNjQpIDA7CQkJCQlcDQorCQlfX0dFVF9VU0VS
X0RXKHB0cik7CQkJCQlcDQorCQkoeCkgPSAoX190eXBlb2ZfXygqKHB0cikp
KSBfX2d1X3ZhbDsJCQlcDQorCQlicmVhazsJCQkJCQkJXA0KKwkJfQkJCQkJ
CQlcDQogCWRlZmF1bHQ6IF9fZ2V0X3VzZXJfdW5rbm93bigpOyBicmVhazsJ
CQkJXA0KIAl9CQkJCQkJCQlcDQotCSh4KSA9IChfX3R5cGVvZl9fKCoocHRy
KSkpIF9fZ3VfdmFsOwkJCQlcDQogCV9fZ3VfZXJyOwkJCQkJCQlcDQogfSkN
CiANCg==

---1463811327-1060407037-1130984435=:3511--
