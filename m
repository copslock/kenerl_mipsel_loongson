Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 12:37:06 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.180]:39004 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20026754AbXKAMg6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 12:36:58 +0000
Received: by py-out-1112.google.com with SMTP id p76so916564pyb
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2007 05:36:46 -0700 (PDT)
Received: by 10.65.59.11 with SMTP id m11mr3684320qbk.1193920604906;
        Thu, 01 Nov 2007 05:36:44 -0700 (PDT)
Received: by 10.65.123.7 with HTTP; Thu, 1 Nov 2007 05:36:44 -0700 (PDT)
Message-ID: <dd7dc2bc0711010536l18f9f2f6gbda4e9ef1158da61@mail.gmail.com>
Date:	Thu, 1 Nov 2007 21:36:44 +0900
From:	"Hyon Lim" <alex@alexlab.net>
To:	linux-mips@linux-mips.org
Subject: MIPS assembly directives in GCC
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8411_4807151.1193920604837"
Return-Path: <alex@alexlab.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alexlab.net
Precedence: bulk
X-list: linux-mips

------=_Part_8411_4807151.1193920604837
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: base64
Content-Disposition: inline

SSBpbnZlc3RpZ2F0ZWQga2VybmVsIGFzc2VtYmx5IHNvdXJjZSBjb2RlIGluIG15IGtlcm5lbCAo
Mi42LjEwKS4KSSBmb3VuZCB0aGF0IHRoZXJlIGFyZSBhIGxvdCBvZiBhc3NlbWJseSBkaXJlY3Rp
dmVzIChlLmcuLCAuYWxpZ24sIC5zZXQKcmVvcmRlciwgLmNwbG9hZCwgLmZyYW1lIGV0Yy4pLgpJ
cyB0aGVyZSBhbnkgZG9jdW1lbnRzIHdoaWNoIGV4cGxhaW5zIHRob3NlIGRpcmVjdGl2ZXM/IChu
b3Qgb25seSBJCmRlc2NyaWJlZCBhYm92ZS4gQWxsIG9mIGRpcmVjdGl2ZXMpCgotLSAKSHlvbiBM
aW0gKMDTx/YpCk1vYmlsZS4gMDEwLTgyMTItMTI0MCAoSW50bCcgQ2FsbCA6ICs4Mi0xMC04MjEy
LTEyNDApCkZheC4gMDMyLTIzMi0wNTc4IChJbnRsJyBBdmFpbGFibGUpCkhvbWVwYWdlIDogaHR0
cDovL3d3dy5hbGV4bGFiLm5ldApCbG9nIDogaHR0cDovL3d3dy5hbGV4bGFiLm5ldC9ibG9nCg==
------=_Part_8411_4807151.1193920604837
Content-Type: text/html; charset=EUC-KR
Content-Transfer-Encoding: base64
Content-Disposition: inline

PGRpdj5JIGludmVzdGlnYXRlZCBrZXJuZWwgYXNzZW1ibHkgc291cmNlIGNvZGUgaW4gbXkga2Vy
bmVsICgyLjYuMTApLjwvZGl2Pgo8ZGl2PkkgZm91bmQgdGhhdCB0aGVyZSBhcmUgYSBsb3Qgb2Yg
YXNzZW1ibHkgZGlyZWN0aXZlcyAoZS5nLiwgLmFsaWduLCAuc2V0IHJlb3JkZXIsIC5jcGxvYWQs
IC5mcmFtZSBldGMuKS48L2Rpdj4KPGRpdj5JcyB0aGVyZSBhbnkgZG9jdW1lbnRzIHdoaWNoIGV4
cGxhaW5zIHRob3NlIGRpcmVjdGl2ZXM/IChub3Qgb25seSBJIGRlc2NyaWJlZCBhYm92ZS4gQWxs
IG9mIGRpcmVjdGl2ZXMpPGJyIGNsZWFyPSJhbGwiPjxicj4tLSA8YnI+SHlvbiBMaW0gKMDTx/Yp
PGJyPk1vYmlsZS4gMDEwLTgyMTItMTI0MCAoSW50bCYjMzk7IENhbGwgOiArODItMTAtODIxMi0x
MjQwKTxicj5GYXguIDAzMi0yMzItMDU3OCAoSW50bCYjMzk7IEF2YWlsYWJsZSkKPGJyPkhvbWVw
YWdlIDogPGEgaHJlZj0iaHR0cDovL3d3dy5hbGV4bGFiLm5ldCI+aHR0cDovL3d3dy5hbGV4bGFi
Lm5ldDwvYT48YnI+QmxvZyA6IDxhIGhyZWY9Imh0dHA6Ly93d3cuYWxleGxhYi5uZXQvYmxvZyI+
aHR0cDovL3d3dy5hbGV4bGFiLm5ldC9ibG9nPC9hPiA8L2Rpdj4K
------=_Part_8411_4807151.1193920604837--
