Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2005 12:20:54 +0000 (GMT)
Received: from mail.soc-soft.com ([IPv6:::ffff:202.56.254.199]:3597 "EHLO
	IGateway.soc-soft.com") by linux-mips.org with ESMTP
	id <S8225261AbVCGMUf>; Mon, 7 Mar 2005 12:20:35 +0000
Received: from soc-mail.soc-soft.com ([192.168.4.25]) by IGateway with trend_isnt_name_B; Mon, 07 Mar 2005 17:52:15 +0530
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C52310.4C19A488"
Subject: How /sbin/init is executed
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date:	Mon, 7 Mar 2005 17:52:15 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C5F282A@soc-mail.soc-soft.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: How /sbin/init is executed
Thread-Index: AcUjEEucnsXfHjuVQ/67k31nFnx8OQ==
From:	<Rishabh@soc-soft.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Rishabh@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rishabh@soc-soft.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C52310.4C19A488
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Hi,

I am working on HIGHMEM implementation on Monta Vista Linux 3.1. I am
able to boot the kernel till "/sbin/init".=0D

I am getting stuck with How /sbin/init is fetched and executed from
Target ROOT Dir.=0D

Is it that a part of /sbin/init file is fetched and executed and then
the other part of the file is fetched?

If I want to debug the progress of /sbin/init execution then how can I
proceed in this direction?


Rishabh Kumar Goel
Software Engineer
=0D
SoCrates Software India Pvt. Ltd.
a TOSHIBA Group Company
#10, Industrial Layout,
Prestige Atlanta,
III Block, Koramangala,
Bangalore - 560034
=0D
Ph. 080-51101669



The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If=
 you are not
the intended recipient, please notify the sender and delete the message=
 along with
any annexure. You should not disclose, copy or otherwise use the=
 information contained
in the message or any annexure. Any views expressed in this e-mail are=
 those of the
individual sender except where the sender specifically states them to be=
 the views of
SoCrates Software India Pvt Ltd., Bangalore.
------_=_NextPart_001_01C52310.4C19A488
Content-Type: text/x-vcard;
	name="Rishabh Kumar Goel.vcf"
Content-Transfer-Encoding: base64
Content-Description: Rishabh Kumar Goel.vcf
Content-Disposition: attachment;
	filename="Rishabh Kumar Goel.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOkdvZWw7UmlzaGFiaCBLdW1hcg0KRk46UmlzaGFi
aCBLdW1hciBHb2VsDQpPUkc6U29jcmF0ZXMgU29mdHdhcmUgSW5kaWEgUHZ0IEx0ZC47T1MgJiBE
RA0KVElUTEU6U0UNClRFTDtXT1JLO1ZPSUNFOjUxMTAxNjY5ICAgIEV4dDoyNjY5DQpBRFI7V09S
SztFTkNPRElORz1RVU9URUQtUFJJTlRBQkxFOjtTb2NyYXRlcyBTb2Z0d2FyZSBJbmRpYSBQdnQu
IEx0ZC47MTAgQnJpZGUgU3RyZWV0LCA9MEQ9MEFMYW5nZm9yZCBUb3duO0Jhbmc9DQphbG9yZTtL
YXJuYXRha2E7NTYwMDI1O0lORElBDQpMQUJFTDtXT1JLO0VOQ09ESU5HPVFVT1RFRC1QUklOVEFC
TEU6U29jcmF0ZXMgU29mdHdhcmUgSW5kaWEgUHZ0LiBMdGQuPTBEPTBBMTAgQnJpZGUgU3RyZWV0
LCA9MEQ9MEFMYW5nZm9yZCBUb3duPQ0KPTBEPTBBQmFuZ2Fsb3JlLCBLYXJuYXRha2EgNTYwMDI1
PTBEPTBBSU5ESUENCkVNQUlMO1BSRUY7SU5URVJORVQ6UmlzaGFiaEBzb2Mtc29mdC5jb20NClJF
VjoyMDA1MDIxN1QwNjA4NDJaDQpFTkQ6VkNBUkQNCg==

------_=_NextPart_001_01C52310.4C19A488--
