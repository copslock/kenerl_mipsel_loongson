Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 19:16:17 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.181]:49555 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024137AbXJ3TQJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 19:16:09 +0000
Received: by py-out-1112.google.com with SMTP id p76so4026675pyb
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2007 12:15:58 -0700 (PDT)
Received: by 10.65.100.14 with SMTP id c14mr16038573qbm.1193771757282;
        Tue, 30 Oct 2007 12:15:57 -0700 (PDT)
Received: by 10.65.123.7 with HTTP; Tue, 30 Oct 2007 12:15:57 -0700 (PDT)
Message-ID: <dd7dc2bc0710301215m1a5b8d7at85c9afc7976dc21d@mail.gmail.com>
Date:	Wed, 31 Oct 2007 04:15:57 +0900
From:	"Hyon Lim" <alex@alexlab.net>
To:	linux-mips@linux-mips.org
Subject: implementation of software suspend on MIPS. (system log)
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_305_24652951.1193771757280"
Return-Path: <alex@alexlab.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alexlab.net
Precedence: bulk
X-list: linux-mips

------=_Part_305_24652951.1193771757280
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: base64
Content-Disposition: inline

W0RFQlVHXSBTd3N1c3Bfd3JpdGUoKSBAIGtlcm5lbC9wb3dlci9zd3N1c3AuYyw4NzQKW0RFQlVH
XSB3cml0ZV9zdXNwZW5kX2ltYWdlKCksIGtlcm5lbC9wb3dlci9zd3N1c3AuYyw0MDcKW0RFQlVH
XSBpbml0X2hlYWRlcigpLCBrZXJuZWwvcG93ZXIvc3dzdXNwLmMsMzM3CltERUJVR10gZHVtcF9p
bmZvKCksIGtlcm5lbC9wb3dlci9zd3N1c3AuYywzMjEKIHN3c3VzcDogVmVyc2lvbjogMTMyNjE4
CiBzd3N1c3A6IE51bSBQYWdlczogODE5Mgogc3dzdXNwOiBVVFMgU3lzOiBMaW51eAogc3dzdXNw
OiBVVFMgTm9kZTogKG5vbmUpCiBzd3N1c3A6IFVUUyBSZWxlYXNlOiAyLjYuMTBfU0VMUF9NSVBT
CiBzd3N1c3A6IFVUUyBWZXJzaW9uOiAjOTUgV2VkIE9jdCAzMCAwMzo0NjozNSBLU1QgMjAwNwog
c3dzdXNwOiBVVFMgTWFjaGluZTogbWlwcwogc3dzdXNwOiBVVFMgRG9tYWluOiAobm9uZSkKIHN3
c3VzcDogQ1BVczogMQogc3dzdXNwOiBJbWFnZTogMTg5NiBQYWdlcwogc3dzdXNwOiBQYWdlZGly
OiAwIFBhZ2VzCltERUJVR10gZGF0YV93cml0ZSgpLCBrZXJuZWwvcG93ZXIvc3dzdXNwLmMsMzAz
CldyaXRpbmcgZGF0YSB0byBzd2FwICgxODk2IHBhZ2VzKS4uLiBkb25lCldyaXRpbmcgcGFnZWRp
ciAoOCBwYWdlcykKU3wKUG93ZXJpbmcgb2ZmIHN5c3RlbQpDb2xkIHJlc2V0CgpUaGlzIGlzIHN5
c3RlbSBsb2cgb2YgbXkgaW1wbGVtZW50YXRpb24uCgotLSAKSHlvbiBMaW0gKMDTx/YpCk1vYmls
ZS4gMDEwLTgyMTItMTI0MCAoSW50bCcgQ2FsbCA6ICs4Mi0xMC04MjEyLTEyNDApCkZheC4gMDMy
LTIzMi0wNTc4IChJbnRsJyBBdmFpbGFibGUpCkhvbWVwYWdlIDogaHR0cDovL3d3dy5hbGV4bGFi
Lm5ldApCbG9nIDogaHR0cDovL3d3dy5hbGV4bGFiLm5ldC9ibG9nCg==
------=_Part_305_24652951.1193771757280
Content-Type: text/html; charset=EUC-KR
Content-Transfer-Encoding: base64
Content-Disposition: inline

PGRpdj5bREVCVUddIFN3c3VzcF93cml0ZSgpIEAga2VybmVsL3Bvd2VyL3N3c3VzcC5jLDg3NDxi
cj5bREVCVUddIHdyaXRlX3N1c3BlbmRfaW1hZ2UoKSwga2VybmVsL3Bvd2VyL3N3c3VzcC5jLDQw
Nzxicj5bREVCVUddIGluaXRfaGVhZGVyKCksIGtlcm5lbC9wb3dlci9zd3N1c3AuYywzMzc8YnI+
W0RFQlVHXSBkdW1wX2luZm8oKSwga2VybmVsL3Bvd2VyL3N3c3VzcC5jLDMyMTxicj4mbmJzcDtz
d3N1c3A6IFZlcnNpb246IDEzMjYxOAo8YnI+Jm5ic3A7c3dzdXNwOiBOdW0gUGFnZXM6IDgxOTI8
YnI+Jm5ic3A7c3dzdXNwOiBVVFMgU3lzOiBMaW51eDxicj4mbmJzcDtzd3N1c3A6IFVUUyBOb2Rl
OiAobm9uZSk8YnI+Jm5ic3A7c3dzdXNwOiBVVFMgUmVsZWFzZTogMi42LjEwX1NFTFBfTUlQUzxi
cj4mbmJzcDtzd3N1c3A6IFVUUyBWZXJzaW9uOiAjOTUgV2VkIE9jdCAzMCAwMzo0NjozNSBLU1Qg
MjAwNzxicj4mbmJzcDtzd3N1c3A6IFVUUyBNYWNoaW5lOiBtaXBzPGJyPiZuYnNwO3N3c3VzcDog
VVRTIERvbWFpbjogKG5vbmUpCjxicj4mbmJzcDtzd3N1c3A6IENQVXM6IDE8YnI+Jm5ic3A7c3dz
dXNwOiBJbWFnZTogMTg5NiBQYWdlczxicj4mbmJzcDtzd3N1c3A6IFBhZ2VkaXI6IDAgUGFnZXM8
YnI+W0RFQlVHXSBkYXRhX3dyaXRlKCksIGtlcm5lbC9wb3dlci9zd3N1c3AuYywzMDM8YnI+V3Jp
dGluZyBkYXRhIHRvIHN3YXAgKDE4OTYgcGFnZXMpLi4uIGRvbmU8YnI+V3JpdGluZyBwYWdlZGly
ICg4IHBhZ2VzKTxicj5TfDxicj5Qb3dlcmluZyBvZmYgc3lzdGVtCjxicj5Db2xkIHJlc2V0PC9k
aXY+CjxkaXY+Jm5ic3A7PC9kaXY+CjxkaXY+VGhpcyBpcyBzeXN0ZW0gbG9nIG9mIG15IGltcGxl
bWVudGF0aW9uLjxiciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPkh5b24gTGltICjA08f2KTxicj5N
b2JpbGUuIDAxMC04MjEyLTEyNDAgKEludGwmIzM5OyBDYWxsIDogKzgyLTEwLTgyMTItMTI0MCk8
YnI+RmF4LiAwMzItMjMyLTA1NzggKEludGwmIzM5OyBBdmFpbGFibGUpPGJyPkhvbWVwYWdlIDog
PGEgaHJlZj0iaHR0cDovL3d3dy5hbGV4bGFiLm5ldCI+Cmh0dHA6Ly93d3cuYWxleGxhYi5uZXQ8
L2E+PGJyPkJsb2cgOiA8YSBocmVmPSJodHRwOi8vd3d3LmFsZXhsYWIubmV0L2Jsb2ciPmh0dHA6
Ly93d3cuYWxleGxhYi5uZXQvYmxvZzwvYT4gPC9kaXY+Cg==
------=_Part_305_24652951.1193771757280--
