Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA667957 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Dec 1997 18:55:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA14862 for linux-list; Wed, 24 Dec 1997 18:46:16 -0800
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [192.26.72.25]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA14858 for <linux@cthulhu.engr.sgi.com>; Wed, 24 Dec 1997 18:46:15 -0800
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id SAA01273 for <linux@cthulhu>; Wed, 24 Dec 1997 18:46:14 -0800 (PST)
Date: Wed, 24 Dec 1997 18:46:14 -0800 (PST)
From: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: problems with crossdev env .. (fwd)
Message-ID: <Pine.SGI.3.94.971224184601.1224D-300000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1072019431-1385156519-883017932=:1224"
Content-ID: <Pine.SGI.3.94.971224184601.1224E@tantrik.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1072019431-1385156519-883017932=:1224
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SGI.3.94.971224184601.1224F@tantrik.engr.sgi.com>


Ralf,

I tried to follow the instructions on the linux.sgi.com page .. first off,
the binutils and gcc tarballs did not have the configure scripts in them ,
so that part of the instructions were not possible to follow ..

in trying to make the linux kernel, I ran into the following problems ..
could you please take a look, and suggest what the problems maybe 

find attached 2 attachments ..

1-> is the result of trying to do a gmake
2-> the hinv of the machine ..

please suggest what needs to be done ..

Thanx

--
--------------------------------------------------------------------------
Shrijeet Mukherjee,    			Member of Technical Staff (MTS)
					Advanced Graphics Division 
                     			Silicon Graphics Computer Systems

http://reality.sgi.com/shm_engr     	phone: 650-933-5312
email: shm@engr.sgi.com, shm@sgi.com, shm@cs.uoregon.edu
--------------------------------------------------------------------------
I am not a loser, just successfully challenged     -- shm

---1072019431-1385156519-883017932=:1224
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=logger
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SGI.3.94.971224184532.1224B@tantrik.engr.sgi.com>
Content-Description: 

ZmZ5MS91c3IvZ251L2Jpbi9iYXNoDQpiYXNoLTIuMDAjIGV4aXQNCnNhZmZ5
MWlkDQp1aWQ9MChyb290KSBnaWQ9MChzeXMpDQpzYWZmeTFleGl0DQpTY3Jp
cHQgZG9uZSwgZmlsZSBpcyB0eXBlc2NyaXB0DQpzYWZmeTFleGl0DQpTY3Jp
cHQgZG9uZSwgZmlsZSBpcyB0eXBlc2NyaXB0DQpyb290ICMgcHdkDQovdXNy
L2xpbnV4L3Vzci9zcmMvbGludXgtMi4wLjIxDQpyb290ICMgc2NyaXB0DQpT
Y3JpcHQgc3RhcnRlZCwgZmlsZSBpcyB0eXBlc2NyaXB0DQpzYWZmeTEvdXNy
L2dudS9iaW4vYmFzaA0KYmFzaC0yLjAwIyBwd2QNCi91c3IvbGludXgvdXNy
L3NyYy9saW51eA0KYmFzaC0yLjAwIyBscw0KQ09QWUlORyAgICAgICAgTWFr
ZWZpbGUgICAgICAgZHJpdmVycyAgICAgICAgaXBjICAgICAgICAgICAgbW9k
dWxlcw0KQ1JFRElUUyAgICAgICAgUkVBRE1FICAgICAgICAgZnMgICAgICAg
ICAgICAga2VybmVsICAgICAgICAgbmV0DQpEb2N1bWVudGF0aW9uICBSdWxl
cy5tYWtlICAgICBpbmNsdWRlICAgICAgICBsaWIgICAgICAgICAgICBzY3Jp
cHRzDQpNQUlOVEFJTkVSUyAgICBhcmNoICAgICAgICAgICBpbml0ICAgICAg
ICAgICBtbSAgICAgICAgICAgICB0eXBlc2NyaXB0DQpiYXNoLTIuMDAjIGV4
aXQNCnNhZmZ5MWV4aXQNClNjcmlwdCBkb25lLCBmaWxlIGlzIHR5cGVzY3Jp
cHQNCnJvb3QgIyAvdXNyL2dudS9iaW4vYmFzaA0KYmFzaC0yLjAwIyBleHBv
cnQgUEFUSD0kUEFUSDovdXNyL2dudS9iaW46L3Vzci9saW51eC91c3IvbG9j
YWwvYmluDQpiYXNoLTIuMDAjIDtzDQpiYXNoOiBzeW50YXggZXJyb3IgbmVh
ciB1bmV4cGVjdGVkIHRva2VuIGA7cycNCmJhc2gtMi4wMCMgbHMNCkNPUFlJ
TkcgICAgICAgIE1ha2VmaWxlICAgICAgIGRyaXZlcnMgICAgICAgIGlwYyAg
ICAgICAgICAgIG1vZHVsZXMNCkNSRURJVFMgICAgICAgIFJFQURNRSAgICAg
ICAgIGZzICAgICAgICAgICAgIGtlcm5lbCAgICAgICAgIG5ldA0KRG9jdW1l
bnRhdGlvbiAgUnVsZXMubWFrZSAgICAgaW5jbHVkZSAgICAgICAgbGliICAg
ICAgICAgICAgc2NyaXB0cw0KTUFJTlRBSU5FUlMgICAgYXJjaCAgICAgICAg
ICAgaW5pdCAgICAgICAgICAgbW0gICAgICAgICAgICAgdHlwZXNjcmlwdA0K
YmFzaC0yLjAwIyBnbWFrZSBDUk9TU19DT01QSUxFPW1pcHMtbGludXggQ09O
RklHX1NIRUxMPS91c3IvZ251L2Jpbi9iYXNoDQpnbWFrZVsxXTogRW50ZXJp
bmcgZGlyZWN0b3J5IGAvdXNyL2xpbnV4L3Vzci9zcmMvbGludXgtMi4wLjIx
L2FyY2gvbWlwcy9ib290Jw0KbWlwcy1saW51eGdjYyAtRF9fS0VSTkVMX18g
LUkvdXNyL2xpbnV4L3Vzci9zcmMvbGludXgvaW5jbHVkZSAtRSAtV2FsbCAt
V3N0cmljdC1wcm90b3R5cGVzIC1PMiAtZm9taXQtZnJhbWUtcG9pbnRlciAt
RyAwIC1tbm8tYWJpY2FsbHMgLWZuby1waWMgLW1jcHU9cjQ0MDAgLW1pcHMz
ICAtTSAqLltjU10gPiAuZGVwZW5kDQovYmluL3NoOiBtaXBzLWxpbnV4Z2Nj
OiAgbm90IGZvdW5kDQpnbWFrZVsxXTogKioqIFtkZXBdIEVycm9yIDEyNw0K
Z21ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdXNyL2xpbnV4L3Vzci9z
cmMvbGludXgtMi4wLjIxL2FyY2gvbWlwcy9ib290Jw0KZ21ha2U6ICoqKiBb
YXJjaGRlcF0gRXJyb3IgMg0KYmFzaC0yLjAwIyBnbWFrZSBkZXAgQ1JPU1Nf
Q09NUElMRT1taXBzLWxpbnV4IENPTkZJR19TSEVMTD0vdXNyL2dudS9iaW4v
YmFzaA0KZ21ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSBgL3Vzci9saW51
eC91c3Ivc3JjL2xpbnV4LTIuMC4yMS9hcmNoL21pcHMvYm9vdCcNCm1pcHMt
bGludXhnY2MgLURfX0tFUk5FTF9fIC1JL3Vzci9saW51eC91c3Ivc3JjL2xp
bnV4L2luY2x1ZGUgLUUgLVdhbGwgLVdzdHJpY3QtcHJvdG90eXBlcyAtTzIg
LWZvbWl0LWZyYW1lLXBvaW50ZXIgLUcgMCAtbW5vLWFiaWNhbGxzIC1mbm8t
cGljIC1tY3B1PXI0NDAwIC1taXBzMyAgLU0gKi5bY1NdID4gLmRlcGVuZA0K
L2Jpbi9zaDogbWlwcy1saW51eGdjYzogIG5vdCBmb3VuZA0KZ21ha2VbMV06
ICoqKiBbZGVwXSBFcnJvciAxMjcNCmdtYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Vzci9saW51eC91c3Ivc3JjL2xpbnV4LTIuMC4yMS9hcmNoL21p
cHMvYm9vdCcNCmdtYWtlOiAqKiogW2FyY2hkZXBdIEVycm9yIDINCmJhc2gt
Mi4wMCMgZ21ha2UgTEFOR1VBR0U9YyBDUk9TU19DT01QSUxFPW1pcHMtbGlu
dXggQ09ORklHX1NIRUxMPS91c3IvZ251L2Jpbi8NCmJhc2gNCmdtYWtlWzFd
OiBFbnRlcmluZyBkaXJlY3RvcnkgYC91c3IvbGludXgvdXNyL3NyYy9saW51
eC0yLjAuMjEvYXJjaC9taXBzL2Jvb3QnDQptaXBzLWxpbnV4Z2NjIC1EX19L
RVJORUxfXyAtSS91c3IvbGludXgvdXNyL3NyYy9saW51eC9pbmNsdWRlIC1F
IC1XYWxsIC1Xc3RyaWN0LXByb3RvdHlwZXMgLU8yIC1mb21pdC1mcmFtZS1w
b2ludGVyIC1HIDAgLW1uby1hYmljYWxscyAtZm5vLXBpYyAtbWNwdT1yNDQw
MCAtbWlwczMgIC1NICouW2NTXSA+IC5kZXBlbmQNCi9iaW4vc2g6IG1pcHMt
bGludXhnY2M6ICBub3QgZm91bmQNCmdtYWtlWzFdOiAqKiogW2RlcF0gRXJy
b3IgMTI3DQpnbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC91c3IvbGlu
dXgvdXNyL3NyYy9saW51eC0yLjAuMjEvYXJjaC9taXBzL2Jvb3QnDQpnbWFr
ZTogKioqIFthcmNoZGVwXSBFcnJvciAyDQpiYXNoLTIuMDAjIGV4aXQNCnJv
b3QgIyBsb2dvdXQNCkNvbm5lY3Rpb24gY2xvc2VkLg0KDQo=
---1072019431-1385156519-883017932=:1224
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=hinver
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SGI.3.94.971224184532.1224C@tantrik.engr.sgi.com>
Content-Description: 

Q1BVOiBNSVBTIFI0MDAwIFByb2Nlc3NvciBDaGlwIFJldmlzaW9uOiAzLjAN
CkZQVTogTUlQUyBSNDAwMCBGbG9hdGluZyBQb2ludCBDb3Byb2Nlc3NvciBS
ZXZpc2lvbjogMC4wDQoxIDEwMCBNSFogSVAyMCBQcm9jZXNzb3INCk1haW4g
bWVtb3J5IHNpemU6IDQ4IE1ieXRlcw0KU2Vjb25kYXJ5IHVuaWZpZWQgaW5z
dHJ1Y3Rpb24vZGF0YSBjYWNoZSBzaXplOiAxIE1ieXRlIG9uIFByb2Nlc3Nv
ciAwDQpJbnN0cnVjdGlvbiBjYWNoZSBzaXplOiA4IEtieXRlcw0KRGF0YSBj
YWNoZSBzaXplOiA4IEtieXRlcw0KSW50ZWdyYWwgU0NTSSBjb250cm9sbGVy
IDA6IFZlcnNpb24gV0QzM0M5M0IsIHJldmlzaW9uIEMNCiAgRGlzayBkcml2
ZTogdW5pdCAxIG9uIFNDU0kgY29udHJvbGxlciAwDQogIERpc2sgZHJpdmU6
IHVuaXQgMiBvbiBTQ1NJIGNvbnRyb2xsZXIgMA0KT24tYm9hcmQgc2VyaWFs
IHBvcnRzOiAyDQpPbi1ib2FyZCBiaS1kaXJlY3Rpb25hbCBwYXJhbGxlbCBw
b3J0DQpHcmFwaGljcyBib2FyZDogR1IyLVhTMjQgd2l0aCBaLWJ1ZmZlcg0K
SW50ZWdyYWwgRXRoZXJuZXQ6IGVjMCwgdmVyc2lvbiAxDQpJcmlzIEF1ZGlv
IFByb2Nlc3NvcjogcmV2aXNpb24gMTANCg0K
---1072019431-1385156519-883017932=:1224--
