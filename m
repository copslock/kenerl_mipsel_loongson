Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 12:02:32 +0100 (CET)
Received: from dtwse201.detewe.de ([195.50.171.201]:33034 "EHLO
	dtwse201.detewe.de") by linux-mips.org with ESMTP
	id <S1122118AbSKELCb>; Tue, 5 Nov 2002 12:02:31 +0100
Received: from zinse043.detewe.de (unverified) by dtwse201.detewe.de
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5e607cd783c332abc90d2@dtwse201.detewe.de> for <linux-mips@linux-mips.org>;
 Tue, 5 Nov 2002 12:02:00 +0100
Received: from detewe.de ([172.30.201.153]) by zinse043.detewe.de
          (Netscape Messaging Server 3.6)  with ESMTP id AAAFAC;
          Tue, 5 Nov 2002 12:01:25 +0100
Message-ID: <3DC7A535.A69B5DD1@detewe.de>
Date: Tue, 05 Nov 2002 12:02:13 +0100
From: Carsten Lange <Carsten.Lange@detewe.de>
X-Mailer: Mozilla 4.5 [en] (X11; I; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: backtrace() (glibc 2.2.5) not working
Content-Type: multipart/mixed; boundary="------------D56F559F00DA2794811188A3"
Return-Path: <carsten.lange@detewe.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Carsten.Lange@detewe.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------D56F559F00DA2794811188A3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I want to use backtrace() in my embedded application to get some idea where problems exist, but
backtrace() is not working (always returns 0).
I thing it is not implemented for mips.

Any ideas how to get it working?


Many thanks for any hints.

Carsten
--------------D56F559F00DA2794811188A3
Content-Type: text/x-vcard; charset=us-ascii;
 name="Carsten.Lange.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Carsten Lange
Content-Disposition: attachment;
 filename="Carsten.Lange.vcf"

begin:vcard 
n:Lange;Carsten
tel;fax:+49 30 6104 4234
tel;work:+49 30 6104 4228
x-mozilla-html:FALSE
url:http://www.detewe.de
org:Cordless Technology A/S Berlin
adr:;;Koepenicker Str. 180;10997 Berlin;;;Germany
version:2.1
email;internet:Carsten.Lange@detewe.de
x-mozilla-cpt:;2592
fn:Carsten Lange
end:vcard

--------------D56F559F00DA2794811188A3--
