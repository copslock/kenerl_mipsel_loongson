Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 16:09:08 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:939 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8225233AbUHWPJD>; Mon, 23 Aug 2004 16:09:03 +0100
Received: from office.vmb-service.ru ([80.73.192.47]:1036 "EHLO alec")
	by Altair with ESMTP id <S1157108AbUHWPIs>;
	Mon, 23 Aug 2004 19:08:48 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alec Voropay" <a.voropay@vmb-service.ru>
To: "'Ralf Baechle'" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Subject: RE: anybody tried NPTL?
Date: Mon, 23 Aug 2004 19:09:31 +0400
Organization: VMB-Service
Message-ID: <036001c48923$31563350$1701a8c0@alec>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20040823122843.GB20905@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips

Ralf Baechle [mailto:ralf@linux-mips.org] wrote:

> In addition to what Dom has already answered - there are very 
> significant differences between the multithreading as
> implemented in the  Windows OS family and the varioius
> threading implementations for Linux  like classic
> libpthreads, Linuxthreads, NPTL, Mozilla and more.
> If we legally could look at MS's code I'd not expect to find
> much useful for us there ...

 OK, OK. You are right. However, as it is known, there is at
least one project "to bridge" Win32/multithread and *NIX :
 WINE.
http://winehq.com/site/docs/wine-devel/x3398

 Yes, the Win32/MIPS API (and ABI) is dead, but MIPS/multithreading
lives in the WindowsCE/MIPS HPCs.


 Unfortunately, I can't find any details about Win32/MIPS
implementation.


--
-=VA=-
