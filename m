Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBBAbOS13068
	for linux-mips-outgoing; Tue, 11 Dec 2001 02:37:24 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBBAbFo13065
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 02:37:15 -0800
Received: from gate.mgnet.de (pD957B530.dip.t-dialin.net [217.87.181.48])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id KAA17975
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 10:37:11 +0100 (MET)
Received: (qmail 25211 invoked from network); 11 Dec 2001 09:36:01 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by gate.mgnet.de with SMTP; 11 Dec 2001 09:36:01 -0000
Date: Tue, 11 Dec 2001 10:37:11 +0100 (CET)
From: Klaus Naumann <spock@mgnet.de>
To: Guido Guenther <agx@sigxcpu.org>
cc: Linux/MIPS list <linux-mips@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   klaus@mgnet.de
Subject: Re: [PATCH] sgiwd93.c fix for multiple disks
In-Reply-To: <20011211095759.A5689@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.LNX.4.21.0112111034340.2714-300000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811071-388443371-1008063431=:2714"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811071-388443371-1008063431=:2714
Content-Type: TEXT/PLAIN; charset=US-ASCII


> > I am unsure if we should put this into CVS as it brings us correctness
> > for the price of some performance penalty.
> Can you very roughly estimate the performance hit - let's say the slow
> down when copying the whole kernel-tree once?
>  -- Guido

Hi all,

I've done some bonnie++ tests and everything looks good IMHO.
See attachments (new_speed is with lolo's patch and old_speed without).
I vote for commit. Cool work !

	Cya, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt

---1463811071-388443371-1008063431=:2714
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=old_speed
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0112111037110.2714@spock.mgnet.de>
Content-Description: 
Content-Disposition: attachment; filename=old_speed

VmVyc2lvbiAgMS4wMiAgICAgICAtLS0tLS1TZXF1ZW50aWFsIE91dHB1dC0t
LS0tLSAtLVNlcXVlbnRpYWwgSW5wdXQtIC0tUmFuZG9tLQ0KICAgICAgICAg
ICAgICAgICAgICAtUGVyIENoci0gLS1CbG9jay0tIC1SZXdyaXRlLSAtUGVy
IENoci0gLS1CbG9jay0tIC0tU2Vla3MtLQ0KTWFjaGluZSAgICAgICAgU2l6
ZSBLL3NlYyAlQ1AgSy9zZWMgJUNQIEsvc2VjICVDUCBLL3NlYyAlQ1AgSy9z
ZWMgJUNQICAvc2VjICVDUA0KaXZ5ICAgICAgICAgICAgMzY4TSAgMTQxNSAg
OTUgIDI0MzcgICA3ICAxMDAzICAgNCAgMTIwOCAgODEgIDIyOTggICA2ICA5
MC43ICAgMg0KICAgICAgICAgICAgICAgICAgICAtLS0tLS1TZXF1ZW50aWFs
IENyZWF0ZS0tLS0tLSAtLS0tLS0tLVJhbmRvbSBDcmVhdGUtLS0tLS0tLQ0K
ICAgICAgICAgICAgICAgICAgICAtQ3JlYXRlLS0gLS1SZWFkLS0tIC1EZWxl
dGUtLSAtQ3JlYXRlLS0gLS1SZWFkLS0tIC1EZWxldGUtLQ0KICAgICAgICAg
ICAgICBmaWxlcyAgL3NlYyAlQ1AgIC9zZWMgJUNQICAvc2VjICVDUCAgL3Nl
YyAlQ1AgIC9zZWMgJUNQICAvc2VjICVDUA0KICAgICAgICAgICAgICAgICAx
NiAgIDIzNSAgOTkgKysrKysgKysrIDEzODcxICA5OCAgIDI0MiAgOTkgKysr
KysgKysrICAgODk4ICA5OQ0KaXZ5LDM2OE0sMTQxNSw5NSwyNDM3LDcsMTAw
Myw0LDEyMDgsODEsMjI5OCw2LDkwLjcsMiwxNiwyMzUsOTksKysrKyssKysr
LDEzODcxLDk4LDI0Miw5OSwrKysrKywrKyssODk4LDk5DQo=
---1463811071-388443371-1008063431=:2714
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=new_speed
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0112111037111.2714@spock.mgnet.de>
Content-Description: 
Content-Disposition: attachment; filename=new_speed

VmVyc2lvbiAgMS4wMiAgICAgICAtLS0tLS1TZXF1ZW50aWFsIE91dHB1dC0t
LS0tLSAtLVNlcXVlbnRpYWwgSW5wdXQtIC0tUmFuZG9tLQ0KICAgICAgICAg
ICAgICAgICAgICAtUGVyIENoci0gLS1CbG9jay0tIC1SZXdyaXRlLSAtUGVy
IENoci0gLS1CbG9jay0tIC0tU2Vla3MtLQ0KTWFjaGluZSAgICAgICAgU2l6
ZSBLL3NlYyAlQ1AgSy9zZWMgJUNQIEsvc2VjICVDUCBLL3NlYyAlQ1AgSy9z
ZWMgJUNQICAvc2VjICVDUA0KaXZ5ICAgICAgICAgICAgMzY4TSAgMTM0OCAg
OTEgIDI0NjggICA3ICAgODM2ICAgMyAgMTI5NyAgODcgIDIxNzggICA1ICA5
MS4wICAgMg0KICAgICAgICAgICAgICAgICAgICAtLS0tLS1TZXF1ZW50aWFs
IENyZWF0ZS0tLS0tLSAtLS0tLS0tLVJhbmRvbSBDcmVhdGUtLS0tLS0tLQ0K
ICAgICAgICAgICAgICAgICAgICAtQ3JlYXRlLS0gLS1SZWFkLS0tIC1EZWxl
dGUtLSAtQ3JlYXRlLS0gLS1SZWFkLS0tIC1EZWxldGUtLQ0KICAgICAgICAg
ICAgICBmaWxlcyAgL3NlYyAlQ1AgIC9zZWMgJUNQICAvc2VjICVDUCAgL3Nl
YyAlQ1AgIC9zZWMgJUNQICAvc2VjICVDUA0KICAgICAgICAgICAgICAgICAx
NiAgIDIyMCAgOTkgKysrKysgKysrIDEzNDQwICA5OCAgIDIzMiAgOTkgKysr
KysgKysrICAgNzgwICA5OQ0KaXZ5LDM2OE0sMTM0OCw5MSwyNDY4LDcsODM2
LDMsMTI5Nyw4NywyMTc4LDUsOTEuMCwyLDE2LDIyMCw5OSwrKysrKywrKyss
MTM0NDAsOTgsMjMyLDk5LCsrKysrLCsrKyw3ODAsOTkNCg==
---1463811071-388443371-1008063431=:2714--
