Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 15:19:51 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:53728
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225272AbUEOOTr>; Sat, 15 May 2004 15:19:47 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4FEJjb22587
	for <linux-mips@linux-mips.org>; Sat, 15 May 2004 16:19:45 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 15 May 2004 16:19:44 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4FEJhn27047
	for <linux-mips@linux-mips.org>; Sat, 15 May 2004 16:19:43 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 15 May 2004 16:19:43 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: CONFIG_MDULES patch
Message-ID: <Pine.GSO.4.10.10405151618380.26862-200000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1084630783=:26862"
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1084630783=:26862
Content-Type: TEXT/PLAIN; charset=US-ASCII

This is a patch for the (insignificant) bug I found some time ago and
posted this morning.

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."

---559023410-851401618-1084630783=:26862
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-cvs-mdules.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.10.10405151619430.26862@helios.et.put.poznan.pl>
Content-Description: 
Content-Disposition: attachment; filename="linux-cvs-mdules.patch"

ZGlmZiAtdXJOIGxpbnV4LW1pcHMtY3ZzLW9yaWcvYXJjaC9taXBzL2tlcm5l
bC90cmFwcy5jIGxpbnV4LW1pcHMteGtwaHlzL2FyY2gvbWlwcy9rZXJuZWwv
dHJhcHMuYw0KLS0tIGxpbnV4LW1pcHMtY3ZzLW9yaWcvYXJjaC9taXBzL2tl
cm5lbC90cmFwcy5jCVdlZCBBcHIgMjggMTU6NTQ6NTMgMjAwNA0KKysrIGxp
bnV4LW1pcHMteGtwaHlzL2FyY2gvbWlwcy9rZXJuZWwvdHJhcHMuYwlTYXQg
TWF5IDE1IDE2OjA5OjQyIDIwMDQNCkBAIC0yNzgsNyArMjc4LDEwIEBADQog
CSk7DQogfQ0KIA0KLSNpZmRlZiBDT05GSUdfTURVTEVTDQorI2lmZGVmIENP
TkZJR19NT0RVTEVTDQorDQorZXh0ZXJuIHNwaW5sb2NrX3QgbW9kbGlzdF9s
b2NrOw0KK2V4dGVybiBzdHJ1Y3QgbGlzdF9oZWFkIG1vZHVsZXM7DQogDQog
LyogR2l2ZW4gYW4gYWRkcmVzcywgbG9vayBmb3IgaXQgaW4gdGhlIG1vZHVs
ZSBleGNlcHRpb24gdGFibGVzLiAqLw0KIGNvbnN0IHN0cnVjdCBleGNlcHRp
b25fdGFibGVfZW50cnkgKnNlYXJjaF9tb2R1bGVfZGJldGFibGVzKHVuc2ln
bmVkIGxvbmcgYWRkcikNCmRpZmYgLXVyTiBsaW51eC1taXBzLWN2cy1vcmln
L2luY2x1ZGUvYXNtLW1pcHMvbW9kdWxlLmggbGludXgtbWlwcy14a3BoeXMv
aW5jbHVkZS9hc20tbWlwcy9tb2R1bGUuaA0KLS0tIGxpbnV4LW1pcHMtY3Zz
LW9yaWcvaW5jbHVkZS9hc20tbWlwcy9tb2R1bGUuaAlUdWUgQXByICA2IDA1
OjEzOjQ0IDIwMDQNCisrKyBsaW51eC1taXBzLXhrcGh5cy9pbmNsdWRlL2Fz
bS1taXBzL21vZHVsZS5oCVNhdCBNYXkgMTUgMTY6MDk6NDIgMjAwNA0KQEAg
LTcsNiArNyw3IEBADQogCS8qIERhdGEgQnVzIEVycm9yIGV4Y2VwdGlvbiB0
YWJsZXMgKi8NCiAJY29uc3Qgc3RydWN0IGV4Y2VwdGlvbl90YWJsZV9lbnRy
eSAqZGJlX3RhYmxlX3N0YXJ0Ow0KIAljb25zdCBzdHJ1Y3QgZXhjZXB0aW9u
X3RhYmxlX2VudHJ5ICpkYmVfdGFibGVfZW5kOw0KKwl1bnNpZ25lZCBpbnQg
bnVtX2RiZWVudHJpZXM7DQogfTsNCiANCiB0eXBlZGVmIHVpbnQ4X3QgRWxm
NjRfQnl0ZTsJCS8qIFR5cGUgZm9yIGEgOC1iaXQgcXVhbnRpdHkuICAqLw0K
ZGlmZiAtdXJOIGxpbnV4LW1pcHMtY3ZzLW9yaWcva2VybmVsL21vZHVsZS5j
IGxpbnV4LW1pcHMteGtwaHlzL2tlcm5lbC9tb2R1bGUuYw0KLS0tIGxpbnV4
LW1pcHMtY3ZzLW9yaWcva2VybmVsL21vZHVsZS5jCUZyaSBBcHIgMjMgMTc6
NTQ6MjIgMjAwNA0KKysrIGxpbnV4LW1pcHMteGtwaHlzL2tlcm5lbC9tb2R1
bGUuYwlTYXQgTWF5IDE1IDE2OjA5OjQyIDIwMDQNCkBAIC01NiwxMSArNTYs
MTEgQEANCiAJKHN0cmNtcChNT0RVTEVfU1lNQk9MX1BSRUZJWCBsaXRlcmFs
LCAoc3RyaW5nKSkgPT0gMCkNCiANCiAvKiBQcm90ZWN0cyBtb2R1bGUgbGlz
dCAqLw0KLXN0YXRpYyBzcGlubG9ja190IG1vZGxpc3RfbG9jayA9IFNQSU5f
TE9DS19VTkxPQ0tFRDsNCitzcGlubG9ja190IG1vZGxpc3RfbG9jayA9IFNQ
SU5fTE9DS19VTkxPQ0tFRDsNCiANCiAvKiBMaXN0IG9mIG1vZHVsZXMsIHBy
b3RlY3RlZCBieSBtb2R1bGVfbXV0ZXggQU5EIG1vZGxpc3RfbG9jayAqLw0K
IHN0YXRpYyBERUNMQVJFX01VVEVYKG1vZHVsZV9tdXRleCk7DQotc3RhdGlj
IExJU1RfSEVBRChtb2R1bGVzKTsNCitMSVNUX0hFQUQobW9kdWxlcyk7DQog
DQogc3RhdGljIERFQ0xBUkVfTVVURVgobm90aWZ5X211dGV4KTsNCiBzdGF0
aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrICogbW9kdWxlX25vdGlmeV9saXN0
Ow0K
---559023410-851401618-1084630783=:26862--
