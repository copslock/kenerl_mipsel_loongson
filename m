Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64BI3Rw032505
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 04:18:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64BI3lJ032504
	for linux-mips-outgoing; Thu, 4 Jul 2002 04:18:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64BHsRw032494;
	Thu, 4 Jul 2002 04:17:55 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g64BLoC09099;
	Thu, 4 Jul 2002 13:21:50 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g64BLmTF026734;
	Thu, 4 Jul 2002 13:21:49 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17Q4gG-0000Q1-00; Thu, 04 Jul 2002 13:21:48 +0200
Date: Thu, 4 Jul 2002 13:21:48 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: lib/Config.in missing in CVS HEAD ?
Message-ID: <Pine.LNX.4.21.0207041317070.1601-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-269209624-1025781708=:1601"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK,MIME_NULL_BLOCK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-269209624-1025781708=:1601
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	arch/mips64/config.in includes lib/Config.in which is
missing. Please either put that file on CVS HEAD if it exists and is
needed, or update arch/mips64/config.in with the following patch.
	Currently, 'make menuconfig ARCH=mips64' crashes because of this.

thanks,
Vivien Chappelier.

--279724308-269209624-1025781708=:1601
Content-Type: TEXT/plain; name="linux-mips64-lib_Config.in_missing.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0207041321480.1601@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips64-lib_Config.in_missing.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL21pcHM2NC9jb25maWcuaW4gbGludXgu
cGF0Y2gvYXJjaC9taXBzNjQvY29uZmlnLmluDQotLS0gbGludXgvYXJjaC9t
aXBzNjQvY29uZmlnLmluCU1vbiBKdWwgIDEgMjA6MjU6NTkgMjAwMg0KKysr
IGxpbnV4LnBhdGNoL2FyY2gvbWlwczY0L2NvbmZpZy5pbglUaHUgSnVsICA0
IDEyOjAzOjA3IDIwMDINCkBAIC0zMTksNCArMzE5LDMgQEANCiBmaQ0KIGVu
ZG1lbnUNCiANCi1zb3VyY2UgbGliL0NvbmZpZy5pbg0K
--279724308-269209624-1025781708=:1601--
