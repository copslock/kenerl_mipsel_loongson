Received:  by oss.sgi.com id <S42281AbQEXK3C>;
	Wed, 24 May 2000 03:29:02 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:21081 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42277AbQEXK2u>; Wed, 24 May 2000 03:28:50 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA06650; Wed, 24 May 2000 03:33:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA83793; Wed, 24 May 2000 03:28:19 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA36745
	for linux-list;
	Wed, 24 May 2000 03:19:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA78500
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 03:19:01 -0700 (PDT)
	mail_from (gw@sers.s-sers.mb.edus.si)
Received: from sers.s-sers.mb.edus.si (sers.s-sers.mb.edus.si [194.249.197.119]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA08561
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 03:18:59 -0700 (PDT)
	mail_from (gw@sers.s-sers.mb.edus.si)
Received: from localhost (gw@localhost)
	by sers.s-sers.mb.edus.si (8.8.5/8.8.5) with SMTP id MAA07780
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 12:31:50 +0200
Date:   Wed, 24 May 2000 12:31:49 +0200 (MET DST)
From:   Mitja Bezget <gw@sers.s-sers.mb.edus.si>
Reply-To: Mitja Bezget <gw@sers.s-sers.mb.edus.si>
To:     linux@cthulhu.engr.sgi.com
Subject: newport driver for XFree
Message-ID: <Pine.LNX.3.95.1000524093350.6454A-200000@sers.s-sers.mb.edus.si>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-104661563-546218378-959164244=:6454"
Content-ID: <Pine.LNX.3.95.1000524123109.6454C@sers.s-sers.mb.edus.si>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---104661563-546218378-959164244=:6454
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.95.1000524123109.6454D@sers.s-sers.mb.edus.si>

hi!

I'm having problems running xfree on an old Indy
so i tought i should report&ask for help..

First I applyed the patch (is it recent??):

# tar -xzvf X400src.tgz
# cd xc
# patch -p0 <newport_000514.diff
(files are from a webpage previously posted)

and it didn't create drivers/newport/ directory.. (it exited
cleanly!)
should i have done something else before that?
Anyway.. i created the missing files by hand..
afterwards it failed again while making World

newport.c:136: `MGA' undeclared (first use of this function)
newport.c:774: `caddr_t' undeclared (first use of this function)
+ some other errors originating from here..

i fixed the caddr_t (missing #include <sys/types.h>)
i changed  MDA to NEWPORT and it compiled ok!  and i was happy!

But now it just wont run.. error message is attached..
I think it has something to do with socketbits.h and declaration
of enum __socket_type.. Namely i added this enum because i couldn't
find #define for socket types in any of system installed header
files.. (The very first reason server didn't compile) 

i'm running glibc-2.0.6-4 (+devel) and egcs-1.0.2-9..

Thank you!

cya 
Mitja
	
ps. for Guido (or who coded that part):
i went thru newport_regs.h and i noticed your comment in line 153
/* This causes a warning. Why??? */
I believe it was just a simple innocent typo.. you pressed
the semi-colon twice. ;)) 

 

---104661563-546218378-959164244=:6454
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="xfree.log"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1000524123044.6454B@sers.s-sers.mb.edus.si>
Content-Description: 

X1hTRVJWVHJhbnNTb2NrZXRDcmVhdGVMaXN0ZW5lcjogbGlzdGVuKCkgZmFp
bGVkDQpfWFNFUlZUcmFuc1NvY2tldElORVRDcmVhdGVMaXN0ZW5lcjogLi4u
U29ja2V0Q3JlYXRlTGlzdGVuZXIoKSBmYWlsZWQNCl9YU0VSVlRyYW5zTWFr
ZUFsbENPVFNTZXJ2ZXJMaXN0ZW5lcnM6IGZhaWxlZCB0byBjcmVhdGUgbGlz
dGVuZXIgZm9yIHRjcA0KX1hTRVJWVHJhbnNTb2NrZXRDcmVhdGVMaXN0ZW5l
cjogbGlzdGVuKCkgZmFpbGVkDQpfWFNFUlZUcmFuc1NvY2tldFVOSVhDcmVh
dGVMaXN0ZW5lcjogLi4uU29ja2V0Q3JlYXRlTGlzdGVuZXIoKSBmYWlsZWQN
Cl9YU0VSVlRyYW5zTWFrZUFsbENPVFNTZXJ2ZXJMaXN0ZW5lcnM6IGZhaWxl
ZCB0byBjcmVhdGUgbGlzdGVuZXIgZm9yIGxvY2FsDQoNCkZhdGFsIHNlcnZl
ciBlcnJvcjoNCkNhbm5vdCBlc3RhYmxpc2ggYW55IGxpc3RlbmluZyBzb2Nr
ZXRzIC0gTWFrZSBzdXJlIGFuIFggc2VydmVyIGlzbid0IGFscmVhZHkgcnVu
bmluZw0KDQpXaGVuIHJlcG9ydGluZyBhIHByb2JsZW0gcmVsYXRlZCB0byBh
IHNlcnZlciBjcmFzaCwgcGxlYXNlIHNlbmQNCnRoZSBmdWxsIHNlcnZlciBv
dXRwdXQsIG5vdCBqdXN0IHRoZSBsYXN0IG1lc3NhZ2VzLg0KVGhpcyBjYW4g
YmUgZm91bmQgaW4gdGhlIGxvZyBmaWxlICIvdmFyL2xvZy9YRnJlZTg2LjAu
bG9nIi4NCg0K
---104661563-546218378-959164244=:6454--
