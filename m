Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 19:17:43 +0100 (BST)
Received: from ux1.dataflo.net ([IPv6:::ffff:207.252.248.16]:9745 "EHLO
	ux1.dataflo.net") by linux-mips.org with ESMTP id <S8225777AbUERSRl>;
	Tue, 18 May 2004 19:17:41 +0100
Received: from server1.RightHand.righthandtech.com ([207.252.250.187])
	by ux1.dataflo.net (8.12.11/8.12.11) with ESMTP id i4IIHcAk042243
	for <linux-mips@linux-mips.org>; Tue, 18 May 2004 13:17:39 -0500 (CDT)
content-class: urn:content-classes:message
Subject: RE: problems on D-cache alias in 2.4.22
Date: Tue, 18 May 2004 13:17:38 -0500
Message-ID: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C43D04.66A62BCA"
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MIMEOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Topic: problems on D-cache alias in 2.4.22
Thread-Index: AcQ9BGaYIz1eHbaQSIaIN7eaTSarbA==
From: "Bob Breuer" <bbreuer@righthandtech.com>
To: <linux-mips@linux-mips.org>
Return-Path: <bbreuer@righthandtech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbreuer@righthandtech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C43D04.66A62BCA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Peter Horton
> Sent: Friday, May 14, 2004 2:53 AM
> To: wuming
> Cc: linux-mips@linux-mips.org
> Subject: Re: problems on D-cache alias in 2.4.22
>=20
>=20
> wuming wrote:
>=20
...
> > at last, when I replaced flush_page_to_ram( ) with=20
> flush_dcache_page( ),
> > the internal compiler error disappeared.
> >
...
>=20
> This is probably just hiding your problem. flush_page_to_ram() is not=20
> used anymore.
>=20
> P.
>=20
>=20

Changing that same place also fixes my problem.  However, I came across
the mips cobalt patches and after applying a variation of the IDE cache
fix from there, that also fixes the problem.  So it would seem that this
is the same problem as already fixed in the cobalt patch, but showing up
on non-cobalt hardware.

flush_page_to_ram() was made useless around the release of 2.4.21.  I
suspect that this was broken at that time, seeing how it is broken in
2.4.22 and 2.4.26.  From browsing the debian-mips mailing list archives,
it appears that they have not had a stable mips kernel since 2.4.19,
could this bug be the cause?  Are the recent Debian mips kernels still
unstable?

Would anyone with an unstable 2.4.2x kernel be willing to try one of the
attached patches to see if the situation improves?

Bob

------_=_NextPart_001_01C43D04.66A62BCA
Content-Type: application/octet-stream;
	name="cache_alias_fix1.diff"
Content-Transfer-Encoding: base64
Content-Description: cache_alias_fix1.diff
Content-Disposition: attachment;
	filename="cache_alias_fix1.diff"

SW5kZXg6IG1tL2ZpbGVtYXAuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvaG9tZS9jdnMvbGludXgv
bW0vZmlsZW1hcC5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjc0LjIuMTQKZGlmZiAtdSAtcjEu
NzQuMi4xNCBmaWxlbWFwLmMKLS0tIG1tL2ZpbGVtYXAuYwkyMCBGZWIgMjAwNCAwMToyMjoyMSAt
MDAwMAkxLjc0LjIuMTQKKysrIG1tL2ZpbGVtYXAuYwkxOCBNYXkgMjAwNCAxNzoxODoyNiAtMDAw
MApAQCAtMjExMSw3ICsyMTExLDcgQEAKIAkgKiBhbmQgcG9zc2libHkgY29weSBpdCBvdmVyIHRv
IGFub3RoZXIgcGFnZS4uCiAJICovCiAJbWFya19wYWdlX2FjY2Vzc2VkKHBhZ2UpOwotCWZsdXNo
X3BhZ2VfdG9fcmFtKHBhZ2UpOworCWZsdXNoX2RjYWNoZV9wYWdlKHBhZ2UpOwogCXJldHVybiBw
YWdlOwogCiBub19jYWNoZWRfcGFnZToK

------_=_NextPart_001_01C43D04.66A62BCA
Content-Type: application/octet-stream;
	name="cache_alias_fix2.diff"
Content-Transfer-Encoding: base64
Content-Description: cache_alias_fix2.diff
Content-Disposition: attachment;
	filename="cache_alias_fix2.diff"

SW5kZXg6IGluY2x1ZGUvYXNtLW1pcHMvaWRlLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2hvbWUv
Y3ZzL2xpbnV4L2luY2x1ZGUvYXNtLW1pcHMvaWRlLmgsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
MTEuMi43CmRpZmYgLXUgLXIxLjExLjIuNyBpZGUuaAotLS0gaW5jbHVkZS9hc20tbWlwcy9pZGUu
aAkxNSBKdWwgMjAwMyAxNTowODozMyAtMDAwMAkxLjExLjIuNworKysgaW5jbHVkZS9hc20tbWlw
cy9pZGUuaAkxOCBNYXkgMjAwNCAxNzo1Nzo0NCAtMDAwMApAQCAtNjksNiArNjksNDkgQEAKICNl
bmRpZgogCiAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvaWRlX2lvcHMuaD4KKyNpbmNsdWRlIDxhc20v
cjRrY2FjaGUuaD4KKworc3RhdGljIGlubGluZSB2b2lkIF9fZmx1c2hfZGNhY2hlX3JhbmdlKHVu
c2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kKQoreworCXVuc2lnbmVkIGxvbmcg
ZGNfc2l6ZSwgZGNfbGluZSwgYWRkcjsKKworCWRjX3NpemUgPSBjdXJyZW50X2NwdV9kYXRhLmRj
YWNoZS53YXlzaXplOworCWRjX2xpbmUgPSBjdXJyZW50X2NwdV9kYXRhLmRjYWNoZS5saW5lc3o7
CisKKwlhZGRyID0gc3RhcnQgJiB+KGRjX2xpbmUgLSAxKTsKKwllbmQgKz0gZGNfbGluZSAtIDE7
CisKKwlpZiAoZW5kIC0gYWRkciA8IGRjX3NpemUpCisJCWZvciAoOyBhZGRyIDwgZW5kOyBhZGRy
ICs9IGRjX2xpbmUpCisJCQlmbHVzaF9kY2FjaGVfbGluZShhZGRyKTsKKwllbHNlIHsKKwkJLyog
Zmx1c2ggYWxsIG9mIGRjYWNoZSAqLworCQlhZGRyID0gS1NFRzA7CisJCWVuZCA9IGFkZHIgKyBk
Y19zaXplOworCQlmb3IgKDsgYWRkciA8IGVuZDsgYWRkciArPSBkY19saW5lKQorCQkJZmx1c2hf
ZGNhY2hlX2xpbmVfaW5kZXhlZChhZGRyKTsKKwl9Cit9CisKKyN1bmRlZiBpbnN3CisjdW5kZWYg
aW5zbAorI3VuZGVmIF9faWRlX2luc3cKKyN1bmRlZiBfX2lkZV9pbnNsCisKK3N0YXRpYyBpbmxp
bmUgdm9pZCBfX2lkZV9pbnN3KHVuc2lnbmVkIGxvbmcgcG9ydCwgdm9pZCAqYWRkciwgdTMyIGNv
dW50KQoreworCV9faW5zdyhwb3J0LCBhZGRyLCBjb3VudCk7CisJX19mbHVzaF9kY2FjaGVfcmFu
Z2UoKHVuc2lnbmVkIGxvbmcpYWRkciwgKHVuc2lnbmVkIGxvbmcpYWRkciArIGNvdW50KjIpOwor
fQorCitzdGF0aWMgaW5saW5lIHZvaWQgX19pZGVfaW5zbCh1bnNpZ25lZCBsb25nIHBvcnQsIHZv
aWQgKmFkZHIsIHUzMiBjb3VudCkKK3sKKwlfX2luc2wocG9ydCwgYWRkciwgY291bnQpOworCV9f
Zmx1c2hfZGNhY2hlX3JhbmdlKCh1bnNpZ25lZCBsb25nKWFkZHIsICh1bnNpZ25lZCBsb25nKWFk
ZHIgKyBjb3VudCo0KTsKK30KKworI2RlZmluZSBpbnN3KHBvcnQsIGFkZHIsIGNvdW50KSBfX2lk
ZV9pbnN3KHBvcnQsIGFkZHIsIGNvdW50KQorI2RlZmluZSBpbnNsKHBvcnQsIGFkZHIsIGNvdW50
KSBfX2lkZV9pbnNsKHBvcnQsIGFkZHIsIGNvdW50KQogCiAjZW5kaWYgLyogX19LRVJORUxfXyAq
LwogCg==

------_=_NextPart_001_01C43D04.66A62BCA--
