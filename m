Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03MRaq29396
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:27:36 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03MRTg29393;
	Thu, 3 Jan 2002 14:27:29 -0800
Received: from resel.enst-bretagne.fr (user33661@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g03LRKb10912;
	Thu, 3 Jan 2002 22:27:20 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA19318;
	Thu, 3 Jan 2002 22:27:21 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MFOT-0002Jl-00; Thu, 03 Jan 2002 22:27:21 +0100
Date: Thu, 3 Jan 2002 22:27:21 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: fixes for R5000 SC
Message-ID: <Pine.LNX.4.21.0201032224260.8906-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-290444707-1010093241=:8906"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-290444707-1010093241=:8906
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	It seems secondary cache handling for R5000 (at least on the
O2) is quite different from the R4xxx. Unfortunately, it's detected by
this code and the cache operates in a wrong way. This patch disables
detection of a secondary cache for the R5000.

Vivien Chappelier.

--279724308-290444707-1010093241=:8906
Content-Type: TEXT/plain; name="linux-O2-l1cache.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201032227210.8906@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-O2-l1cache.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9tbS9yNHh4MC5jIGxpbnV4
LnBhdGNoL2FyY2gvbWlwczY0L21tL3I0eHgwLmMNCi0tLSBsaW51eC9hcmNo
L21pcHM2NC9tbS9yNHh4MC5jCVdlZCBKYW4gIDIgMjI6NTY6NDEgMjAwMg0K
KysrIGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L21tL3I0eHgwLmMJV2VkIEph
biAgMiAyMzoxMDoyNCAyMDAyDQpAQCAtMjM0Niw4ICsyMzQ2LDIxIEBADQog
CWludCBzY19wcmVzZW50ID0gMDsNCiANCiAJLyogTWF5YmUgdGhlIGNwdSBr
bm93cyBhYm91dCBhIGwyIGNhY2hlPyAqLw0KLQlwcm9iZV9zY2FjaGVfa3Nl
ZzEgPSAocHJvYmVfZnVuY190KSAoS1NFRzFBRERSKCZwcm9iZV9zY2FjaGUp
KTsNCi0Jc2NfcHJlc2VudCA9IHByb2JlX3NjYWNoZV9rc2VnMShjb25maWcp
Ow0KKwlzd2l0Y2gobWlwc19jcHUuY3B1dHlwZSkgew0KKwljYXNlIENQVV9S
NDAwMFNDOg0KKwljYXNlIENQVV9SNDAwME1DOg0KKwljYXNlIENQVV9SNDIw
MDoNCisJY2FzZSBDUFVfUjQzMDA6DQorCWNhc2UgQ1BVX1I0NDAwU0M6DQor
CWNhc2UgQ1BVX1I0NDAwTUM6DQorCWNhc2UgQ1BVX1I0NjAwOg0KKwljYXNl
IENQVV9SNDY0MDoNCisJY2FzZSBDUFVfUjQ2NTA6DQorCWNhc2UgQ1BVX1I0
NzAwOg0KKwkgIHByb2JlX3NjYWNoZV9rc2VnMSA9IChwcm9iZV9mdW5jX3Qp
IChLU0VHMUFERFIoJnByb2JlX3NjYWNoZSkpOw0KKwkgIHNjX3ByZXNlbnQg
PSBwcm9iZV9zY2FjaGVfa3NlZzEoY29uZmlnKTsNCisJICBicmVhazsNCisJ
fQ0KIA0KIAlpZiAoc2NfcHJlc2VudCkgew0KIAkJc2V0dXBfc2NhY2hlX2Z1
bmNzKCk7DQo=
--279724308-290444707-1010093241=:8906--
