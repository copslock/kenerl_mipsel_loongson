Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 08:51:35 +0200 (CEST)
Received: from dtwse201.detewe.de ([195.50.171.201]:22024 "EHLO
	dtwse201.detewe.de") by linux-mips.org with ESMTP
	id <S1122958AbSIEGvf>; Thu, 5 Sep 2002 08:51:35 +0200
Received: from zinse043.detewe.de (unverified) by dtwse201.detewe.de
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5d25ab1ec6c332abc9076@dtwse201.detewe.de> for <linux-mips@linux-mips.org>;
 Thu, 5 Sep 2002 08:52:10 +0200
Received: from detewe.de ([172.30.201.153]) by zinse043.detewe.de
          (Netscape Messaging Server 3.6)  with ESMTP id AAA13F;
          Thu, 5 Sep 2002 08:50:30 +0200
Message-ID: <3D76FEE7.D1DA2D99@detewe.de>
Date: Thu, 05 Sep 2002 08:51:19 +0200
From: Carsten Lange <Carsten.Lange@detewe.de>
X-Mailer: Mozilla 4.5 [en] (X11; I; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: gdbserver (gdb 5.2) with thread supprt
Content-Type: multipart/mixed; boundary="------------41E73B4BC5F3208D24B4F27B"
Return-Path: <carsten.lange@detewe.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 95
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Carsten.Lange@detewe.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------41E73B4BC5F3208D24B4F27B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

gdbserver from gdb 5.2 does not work for applications using threads, for others it
works fine.

I wonder whether gdbserver supports threads and what I have to do to set it up
(e.g where to get the
patch)?

Any hints?

Many thanks
        Carsten
--------------41E73B4BC5F3208D24B4F27B
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

--------------41E73B4BC5F3208D24B4F27B--
